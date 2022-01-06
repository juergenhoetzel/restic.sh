Role Name
=========

Set up a timer based backup job and optional eMail notification.

Requirements
------------

Configured eMail-Relay for sending eMails.

Role Variables
--------------

-  
<dl>
  <dt><strong>restic_repository</strong></dt>
  <dd>The place where your backups will be saved.</dd>
  <dt><strong>restic_password</strong></dt>
  <dd>The repository password.</dd>
  <dt><strong>restic_mail_recipients [optional]</strong></dt>
  <dd>List of eMail recipients</dd>
  <dt><strong>restic_succeed_mail [optional]</strong></dt>
  <dd>Send emails on success? (yes|no)</dd>
  <dt><strong>restic_backup_opts</strong></dt>
  <dd>List of backup options, default ["-x" "--" "/" ]</dd>
  <dt><strong>restic_forget_opts [optional]</strong></dt>
  <dd>List of forget options, default []: Don't run forget.</dd>
</dl>


Dependencies
------------

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
```yml
    - hosts: servers
      roles:
          - role: restic
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

