# OpenWrt Secrets Management with Ansible Vault

This document explains how to securely manage sensitive configuration data (passwords, keys, tokens) for your OpenWrt Ansible deployment using Ansible Vault.

## Overview

Ansible Vault provides encryption for sensitive data stored in your repository. This ensures that passwords, API keys, and other secrets are never stored in plain text in version control while remaining accessible to your Ansible playbooks.

## Current Encrypted Secrets

The following secrets are currently encrypted in `host_vars/secrets.yml`:

- `wifi2_key` - Password for 2.4GHz WiFi network
- `wifi5_key` - Password for 5GHz WiFi network

## Prerequisites

1. Python virtual environment activated:
   ```bash
   cd /home/boris/code/soywrt
   source venv/bin/activate
   ```

2. Vault password configured in `.vault_pass`

## Setting Up Vault Password

**One-time setup - create your vault password:**

```bash
# Create vault password file (replace with strong password)
echo "your-secure-vault-password-here" > .vault_pass
chmod 600 .vault_pass  # Secure permissions
```

**Important:** Never commit `.vault_pass` to version control (it's already in `.gitignore`)

## Managing Secrets

### Viewing Encrypted Secrets

```bash
ansible-vault view host_vars/secrets.yml
```

### Editing Secrets

```bash
ansible-vault edit host_vars/secrets.yml
```

This opens your default editor with the decrypted content. Make changes and save - the file will be automatically re-encrypted when you exit.

### Encrypting New Files

```bash
ansible-vault encrypt host_vars/secrets.yml
```

### Decrypting Files (Temporary)

```bash
ansible-vault decrypt host_vars/secrets.yml
```

**Warning:** Remember to re-encrypt after editing!

### Changing Vault Password

```bash
ansible-vault rekey host_vars/secrets.yml
```

This will prompt for the old password and new password.

## Adding New Secrets

1. **Add the secret variable to your host/group vars:**
   ```yaml
   # In host_vars/home-router.yml or group_vars/openwrt.yml
   new_secret: "{{ my_new_secret }}"
   ```

2. **Add the actual value to encrypted secrets:**
   ```bash
   ansible-vault edit host_vars/secrets.yml
   ```

   Add your new secret:
   ```yaml
   wifi2_key: "password123"
   wifi5_key: "password456"
   my_new_secret: "super-secret-value"
   ```

## Running Playbooks with Encrypted Secrets

**Normal execution (vault password read automatically from `.vault_pass`):**

```bash
ansible-playbook playbooks/site.yml --check --diff
ansible-playbook playbooks/site.yml
```

**If you need to specify vault password interactively:**

```bash
ansible-playbook playbooks/site.yml --ask-vault-pass
```

## Security Best Practices

### Vault Password Management

- Use a strong, unique password for your vault
- Store vault password securely (password manager, secure note)
- Never commit vault password to version control
- Share vault password securely with team members
- Rotate vault password periodically

### File Permissions

- Keep `.vault_pass` file permissions restrictive: `chmod 600 .vault_pass`
- Ensure encrypted files are committed to version control
- Backup your vault password separately from the repository

### Repository Security

- Encrypted secrets are safe to commit to public repositories
- Plain text secrets should never appear in git history
- Use `.gitignore` to exclude unencrypted secret files

## Troubleshooting

### "Vault password file not found" Error

Ensure `.vault_pass` exists and contains your vault password:
```bash
ls -la .vault_pass
cat .vault_pass  # Should contain your vault password
```

### "Decryption failed" Error

- Verify vault password is correct
- Check that encrypted file wasn't corrupted
- Ensure you're using the same vault password used for encryption

### Cannot Edit Encrypted File

- Ensure you're in the correct directory
- Check that virtual environment is activated
- Verify vault password file is readable

## Alternative Secret Management

While Ansible Vault works well for this setup, consider these alternatives for larger deployments:

- **HashiCorp Vault** - Enterprise-grade secret management
- **AWS Secrets Manager** - Cloud-native secret storage
- **Azure Key Vault** - Microsoft cloud secret management
- **Environment Variables** - For CI/CD pipelines

## Example: Adding More Secrets

To add additional sensitive configuration (API keys, certificates, etc.):

1. **Define in variables:**
   ```yaml
   # host_vars/home-router.yml
   tailscale_auth_key: "{{ tailscale_key }}"
   api_token: "{{ my_api_token }}"
   ```

2. **Store encrypted values:**
   ```yaml
   # host_vars/secrets.yml (encrypted)
   wifi2_key: "wifi-password-2g"
   wifi5_key: "wifi-password-5g"
   tailscale_key: "tskey-auth-..."
   my_api_token: "api-token-value"
   ```

3. **Use in playbooks:**
   ```yaml
   - name: Configure Tailscale
     command: tailscale up --auth-key={{ tailscale_auth_key }}
   ```

## Backup Strategy

- **Repository:** Encrypted secrets are safely backed up in git
- **Vault Password:** Store securely in password manager
- **Recovery:** Can recreate vault password, but secrets would need re-entry
- **Documentation:** Keep this guide accessible for team members

---

**Remember:** With great power comes great responsibility. Handle secrets carefully and follow security best practices! 🔐
