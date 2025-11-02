# OpenWrt Secrets

```bash
# Setup vault password
echo "your-password-here" > .vault_pass
chmod 600 .vault_pass

# Edit encrypted secrets
cd /home/boris/code/soywrt
source venv/bin/activate
ansible-vault edit host_vars/secrets.yml

# Run playbooks
ansible-playbook playbooks/site.yml --check --diff
ansible-playbook playbooks/site.yml

# Other commands
ansible-vault view host_vars/secrets.yml    # View secrets
ansible-vault rekey host_vars/secrets.yml   # Change password
```
