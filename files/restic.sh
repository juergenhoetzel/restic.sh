#!/bin/bash

set -o pipefail

CONFIG_FILES=(/etc/restic.sh.conf ~/restic.sh.conf)
EXIT_CODE=0

# save stdout/err
exec 6>&1
exec 7>&2

restic_out=$(mktemp)
trap "rm $restic_out" EXIT

setup_out() {
    exec >"${restic_out}" 2>&1
}

reset_out() {
    exec >&6
    exec 2>&7
}

report () {
    reset_out
    if ((${#RESTIC_MAIL_RECIPIENTS[@]} > 0 ));then
       mail -s "$1 on $HOSTNAME"  "${RESTIC_MAIL_RECIPIENTS[@]}" <"${restic_out}"
    fi
    echo -n "$1: " >&2
    cat "$restic_out" >&2
}

set -a
for config_file in "${CONFIG_FILES[@]}"; do
    if [[ -r "${config_file}" ]];then
       if [[ $(stat -c %a "${config_file}"|cut -b 2-) != "00" ]];then
	  echo "Insecure Permissions for ${config_file}" >&2
	  continue;
       fi
       source "${config_file}"
    fi
done
set +a

eval ${RESTIC_PRE_COMMAND}

setup_out

if ! restic ${RESTIC_GLOBAL_OPTS[@]} backup "${RESTIC_BACKUP_OPTS[@]}";then
   report "Backup failed"
   (( EXIT_CODE +=2 ))
elif [[ "${RESTIC_SUCCEED_MAIL}" == 1 ]];then
   report "Backup succeed"
fi

setup_out
# Only run forget when RESTIC_FORGET_OPTS is set
if [[ "${#RESTIC_FORGET_OPTS[@]}" != 0 ]] &&  ! restic ${RESTIC_GLOBAL_OPTS[@]} forget ${RESTIC_FORGET_OPTS[@]}; then
    report "Prune failed"
    (( EXIT_CODE +=4 ))
elif [[ "${RESTIC_SUCCEED_MAIL}" == 1 ]];then
    report "Prune succeed"
fi

exit ${EXIT_CODE}
