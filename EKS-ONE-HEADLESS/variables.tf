variable "project" {
  default     = null
  description = "Name of the project for which this resource is created and maintained"
  type        = string
  validation {
    condition = anytrue([
      var.project == null,
      can(regex("^[a-z0-9][a-z0-9\\-]{1,18}[a-z0-9]$", coalesce(var.project, "_x")))
    ])
    error_message = "Wrong value for var.project_name. Value must be lower alphanumeric chars with a length between 3 and 20."
  }
}

variable "env" {
  default     = null
  description = "Env of the application"
  type        = string
  validation {
    condition = anytrue([
      var.env == null,
      contains([
        "dev",
        "int",
        "uat",
        "oat",
        "prd"
      ], coalesce(var.env, "x"))
    ])
    error_message = "Wrong value for var.env. Value must be one of [\"int\", \"uat\", \"oat\", \"prd\"]."
  }
}

variable "region" {
  default     = "eu-west-1"
  description = "Name of the AWS region"
  type        = string
  validation {
    condition = contains([
      "ap-southeast-1",
      "eu-west-1",
      "us-west-2"
    ], var.region)
    error_message = "Wrong value for var.region. Value must be one of [\"ap-southeast-1\", \"eu-west-1\", \"us-west-2\"]."
  }
}

variable "aws_account_id" {
  type    = string
  default = null
}

variable "open_cidr_block" {
  type        = string
  description = "Open CIDR block"
  default     = "0.0.0.0/0"
  validation {
    condition = alltrue([
      var.open_cidr_block != null,
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}($|\\/([0-9]{1,2}))$", var.open_cidr_block) == true)
    ])
    error_message = "Wrong value for var.open_cidr_block. Value must be match 0.0.0.0 through 255.255.255.255"
  }
}

variable "subnets" {
  type = list(object({
    subnet_name              = string
    subnet_public_ip         = bool
    subnet_cidr_block        = string
    subnet_availability_zone = string
  }))
  default = [{
    subnet_availability_zone = ""
    subnet_cidr_block        = ""
    subnet_name              = ""
    subnet_public_ip         = false
  }]
}

variable "natgws" {
  type = list(object({
    natgw_name              = string
    natgw_subnet_name       = string
    natgw_availability_zone = string
  }))
  default = [{
    natgw_name              = ""
    natgw_subnet_name       = ""
    natgw_availability_zone = ""
  }]
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  validation {
    condition = alltrue([
      var.vpc_cidr != null,
      can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}($|\\/([0-9]{1,2}))$", var.vpc_cidr) == true)
    ])
    error_message = "Wrong value for vpc_cidr. Value must be match 0.0.0.0 through 255.255.255.255"
  }
}

#----------------
# Eks Cluster  --
#----------------
variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.24`)"
  type        = string
  default     = null
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["audit", "api", "authenticator", "controllerManager", "scheduler"]
}
variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
variable "cluster_additional_security_group_ids" {
  description = "List of additional, externally created security group IDs to attach to the cluster control plane"
  type        = list(string)
  default     = []
}

variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
  default     = []
}

variable "cluster_ip_family" {
  description = "The IP family used to assign Kubernetes pod and service addresses. Valid values are `ipv4` (default) and `ipv6`. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created"
  type        = string
  default     = null
}

variable "cluster_service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  type        = string
  default     = null
}

variable "cluster_service_ipv6_cidr" {
  description = "The CIDR block to assign Kubernetes pod and service IP addresses from if `ipv6` was specified when the cluster was created. Kubernetes assigns service addresses from the unique local address range (fc00::/7) because you can't specify a custom IPv6 CIDR block when you create the cluster"
  type        = string
  default     = null
}
variable "outpost_config" {
  description = "Configuration for the AWS Outpost to provision the cluster on"
  type        = any
  default     = {}
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster"
  type        = any
  default = {
    resources = ["secrets"]
    key_arn   = ""
  }
}

variable "create_kms_key" {
  description = "Controls if a KMS key for cluster encryption should be created"
  type        = bool
  default     = true
}
variable "cluster_timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = map(string)
  default = {
    create = "20m",
    update = "20m",
    delete = "20m"
  }
}


#----------------
# node groupe  --
#----------------
variable "node_role_arn" {
  description = "IAM Role ARN to use"
  type        = string
  default     = null
}
variable "subnet_ids" {
  description = "Identifiers of EC2 Subnets to associate with the EKS Node Group. These subnets must have the following resource tag: `kubernetes.io/cluster/CLUSTER_NAME`"
  type        = list(string)
  default     = null
}

variable "min_size" {
  description = "Minimum number of instances/nodes"
  type        = number
  default     = 0
}

variable "max_size" {
  description = "Maximum number of instances/nodes"
  type        = number
  default     = 3
}

variable "desired_size" {
  description = "Desired number of instances/nodes"
  type        = number
  default     = 1
}

variable "use_name_prefix" {
  description = "Determines whether to use `name` as is or create a unique name beginning with the `name` as the prefix"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "The AMI from which to launch the instance. If not supplied, EKS will use its own default image"
  type        = string
  default     = ""
}
variable "ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values are `AL2_x86_64`, `AL2_x86_64_GPU`, `AL2_ARM_64`, `CUSTOM`, `BOTTLEROCKET_ARM_64`, `BOTTLEROCKET_x86_64`"
  type        = string
  default     = null
}

variable "ami_release_version" {
  description = "AMI version of the EKS Node Group. Defaults to latest version for Kubernetes version"
  type        = string
  default     = null
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size in GiB for nodes. Defaults to `20`. Only valid when `use_custom_launch_template` = `false`"
  type        = number
  default     = null
}

variable "force_update_version" {
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue"
  type        = bool
  default     = null
}

variable "instance_types" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to `[\"t3.medium\"]`"
  type        = list(string)
  default     = null
}

variable "labels" {
  description = "Key-value map of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  type        = map(string)
  default     = null
}

variable "remote_access" {
  description = "Configuration block with remote access settings. Only valid when `use_custom_launch_template` = `false`"
  type        = any
  default     = {}
}

variable "taints" {
  description = "The Kubernetes taints to be applied to the nodes in the node group. Maximum of 50 taints per node group"
  type        = any
  default     = {}
}

variable "update_config" {
  description = "Configuration block of settings for max unavailable resources during node group updates"
  type        = map(string)
  default = {
    max_unavailable_percentage = 33,
    max_unavailable            = 1
  }
}

variable "node_timeouts" {
  description = "Create, update, and delete timeout configurations for the node group"
  type        = map(string)
  default = {
    create = "20m",
    update = "20m",
    delete = "20m"
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

#------------------
# launch temlate --
#------------------
variable "create_launch_template" {
  description = "Determines whether to create a launch template or not. If set to `false`, EKS will use its own default launch template"
  type        = bool
  default     = true
}
variable "launch_template_version" {
  description = "Launch template version number. The default is `$Default`"
  type        = string
  default     = "$Default"
}

variable "use_custom_launch_template" {
  description = "Determines whether to use a custom launch template or not. If set to `false`, EKS will use its own default launch template"
  type        = bool
  default     = true
}

variable "launch_template_id" {
  description = "The ID of an existing launch template to use. Required when `create_launch_template` = `false` and `use_custom_launch_template` = `true`"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "Encoded user data"
  default     = ""
}

variable "image_id" {
  description = "AMI image identifier"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.small"
}

variable "iam_instance_profile" {
  description = "Name of IAM instance profile associated with launched instances"
  default     = null
}

variable "security_groups" {
  description = "List of security group names to attach"
  default     = []
}
variable "subnet_id" {
  description = "Allocation a Subnet ID"
  default     = null
}

variable "metadata_options" {
  description = "Customize the metadata options for the instance"
  type        = map(string)
  default     = {}
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type        = any
}

variable "tag_specifications" {
  description = "The tags to apply to the resources during launch"
  type        = any
  default     = {}
}
variable "monitoring" {
  description = "Enables/disables detailed monitoring"
  type        = bool
  default     = false
}


#------------------
# Key Pair       --
#------------------
variable "algorithm" {
  description = "(Required) The name of the algorithm to use for the key. Currently-supported values are RSA and ECDSA."
  default     = "RSA"
}
variable "rsa_bits" {
  description = "(Optional) When algorithm is RSA, the size of the generated RSA key in bits. Defaults to 2048."
  default     = "4096"
}
variable "ecdsa_curve" {
  description = "(Optional) When algorithm is ECDSA, the name of the elliptic curve to use. May be any one of P224, P256, P384 or P521, with P224 as the default."
  default     = "P224"
}

#------------------
# Add On         --
#------------------
variable "eks_addons" {
  type        = list(string)
  description = "List of eks add on"

}
variable "resolve_conflicts" {
  type        = string
  description = "(Optional) Define how to resolve parameter value conflicts when migrating an existing add-on to an Amazon EKS add-on or when applying version updates to the add-on. Valid values are NONE, OVERWRITE and PRESERVE"
  default     = "NONE"
}

variable "configuration_values" {
  type        = string
  description = "(Optional) custom configuration values for addons with single JSON string"
  default     = null

}

variable "configuration_values_coredns" {
  type        = string
  description = "(Optional) custom configuration values for addons with single JSON string"
  default     = "{\"replicaCount\":2,\"resources\":{\"limits\":{\"cpu\":\"100m\",\"memory\":\"150Mi\"},\"requests\":{\"cpu\":\"100m\",\"memory\":\"150Mi\"}}}"

}

variable "addon_timeouts" {
  description = "Create, update, and delete timeout configurations for the add on"
  type        = map(string)
  default = {
    create = "20m",
    update = "20m",
    delete = "20m"
  }
}

#-------------
# User Data --
#-------------

variable "platform" {
  description = "Identifies if the OS platform is `bottlerocket`, `linux`, or `windows` based"
  type        = string
  default     = "linux"
}

variable "enable_bootstrap_user_data" {
  description = "Determines whether the bootstrap configurations are populated within the user data template"
  type        = bool
  default     = true
}

variable "pre_bootstrap_user_data" {
  description = "User data that is injected into the user data script ahead of the EKS bootstrap script. Not used when `platform` = `bottlerocket`"
  type        = string
  default     = ""
}

variable "post_bootstrap_user_data" {
  description = "User data that is appended to the user data script after of the EKS bootstrap script. Not used when `platform` = `bottlerocket`"
  type        = string
  default     = "sudo yum install iptables-services -y"
}

variable "bootstrap_extra_args" {
  description = "Additional arguments passed to the bootstrap script. When `platform` = `bottlerocket`; these are additional [settings](https://github.com/bottlerocket-os/bottlerocket#settings) that are provided to the Bottlerocket user data"
  type        = string
  default     = ""
}


#-----------------
# OIDC Provider --
#-----------------
variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "openid_connect_audiences" {
  description = "List of OpenID Connect audience client IDs to add to the IRSA provider"
  type        = list(string)
  default     = ["sts.amazonaws.com"]
}

variable "custom_oidc_thumbprints" {
  description = "Additional list of server certificate thumbprints for the OpenID Connect (OIDC) identity provider's server certificate(s)"
  type        = list(string)
  default     = []
}

variable "irsa_namespace_service_accounts" {
  description = "List of `namespace:serviceaccount`pairs to use in trust policy for IAM role for service accounts"
  type        = list(string)
  default     = ["kube-system:aws-node"]
}

variable "irsa_assume_role_condition_test" {
  description = "Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role"
  type        = string
  default     = "StringEquals"
}