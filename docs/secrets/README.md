# OpenWrt Secrets

**CRITICAL:** Store vault password in password manager - it's the master key!

```bash
# Setup vault password
echo "password-from-manager" > .vault_pass
chmod 600 .vault_pass

# Edit encrypted secrets
ansible-vault edit host_vars/secrets.yml

# Run playbooks
ansible-playbook playbooks/site.yml --check --diff
ansible-playbook playbooks/site.yml

# Other commands
ansible-vault view host_vars/secrets.yml
ansible-vault rekey host_vars/secrets.yml
```
