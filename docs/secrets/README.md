# OpenWrt Secrets

**CRITICAL:** Store vault password in password manager - it's the master key!

```bash
# Setup vault password
echo "password-from-manager" > .vault_pass
chmod 600 .vault_pass

# Edit encrypted secrets (activate venv first)
cd /home/boris/code/soywrt
source venv/bin/activate
ansible-vault edit host_vars/secrets.yml

# Run playbooks (activate venv first)
cd /home/boris/code/soywrt
source venv/bin/activate
ansible-playbook playbooks/site.yml --check --diff
ansible-playbook playbooks/site.yml

# Other commands (activate venv first)
cd /home/boris/code/soywrt
source venv/bin/activate
ansible-vault view host_vars/secrets.yml
ansible-vault rekey host_vars/secrets.yml
```
