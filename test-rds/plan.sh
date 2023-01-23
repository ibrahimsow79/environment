#!/bin/bash
RETVAL=$?
[ ${RETVAL} -eq 0 ] && terraform plan ddddd || RETVAL=1
return ${RETVAL}
