Role Name
=========

Set up a timer based backup job and optional eMail notification.

Requirements
------------

Configured eMail-Relay for sending eMails.

Role Variables
--------------

| Name                     | Default          | Description                                  |
|--------------------------|------------------|----------------------------------------------|
| `restic_repository`      |                  | The place where your backups will be saved   |
| `restic_password`        |                  | The repository password                      |
| `restic_mail_recipients` |                  | List of eMail recipient (optional)           |
| `restic_succeed_mail`    | no               | Also send email on success?                  |
| `restic_backup_opts`     | ["-x" "--" "/" ] | List of `backup` command options             |
| `restic_forget_opts`     |                  | List of  `forget` command options [optional] |


Dependencies
------------

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
```yml
    - hosts: servers
      roles:
          - role: juergenhoetzel.restic_sh
            vars:
               restic_repository: /sftp:restic@backup.fritz.box:/
               restic_backup_opts:
                   - "-x"
                   - "--"
                   - "/var/lib/mysql-backup"
                   - "/var/www"

               restic_mail_recipients: 
                   - operator@example.host
                   - backupoperator@example.host
               restic_password: "{{ restic_secret  }}"
```
License
-------

MIT

