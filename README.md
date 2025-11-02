# soywrt

Declarative OpenWrt configuration and automation for the soy home network

## Quick start

1. Install the OpenWrt role into `roles`

```
ansible-galaxy role install -p roles -r requirements.yml
```

2. Create a vault password file then add secrets

```
echo "set-strong-password" > .vault_pass
chmod 600 .vault_pass
ansible-vault edit host_vars/secrets.yml
```

Example content

```
wifi2_key: "replace-with-2g-psk"
wifi5_key: "replace-with-5g-psk"
```

3. First run

```
ansible-playbook playbooks/site.yml --check --diff
ansible-playbook playbooks/site.yml
```

4. Lock onboarding tasks

Set `onboard_once: false` in `host_vars/home-router.yml`, then commit.

Backups from each run are saved under `backups/`. The `.gitignore` prevents committing backups, roles, vault password, and retry files.
