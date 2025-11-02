# OpenWrt Secrets - Ansible Vault

WiFi passwords are encrypted in `host_vars/secrets.yml` using Ansible Vault.

## Setup

1. **Set vault password:**
   ```bash
   echo "your-secure-password" > .vault_pass
   chmod 600 .vault_pass
   ```

2. **Edit secrets:**
   ```bash
   cd /home/boris/code/soywrt
   source venv/bin/activate
   ansible-vault edit host_vars/secrets.yml
   ```

## Usage

**Run playbooks normally:**
```bash
ansible-playbook playbooks/site.yml --check --diff
ansible-playbook playbooks/site.yml
```

## Commands

- **Edit secrets:** `ansible-vault edit host_vars/secrets.yml`
- **View secrets:** `ansible-vault view host_vars/secrets.yml`
- **Change password:** `ansible-vault rekey host_vars/secrets.yml`

## Security

- Never commit `.vault_pass` (already in .gitignore)
- Store vault password securely (password manager)
- Encrypted secrets are safe in git

## Adding New Secrets

1. Add variable reference in `host_vars/home-router.yml`:
   ```yaml
   new_secret: "{{ my_secret_key }}"
   ```

2. Add actual value in encrypted secrets file

---

**Handle secrets responsibly!** 🔐
