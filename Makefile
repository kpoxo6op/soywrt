SHELL := /bin/bash

.PHONY: help init venv install galaxy shell check apply vault-edit vault-view vault-rekey clean

help:
	@echo "Available targets:"
	@echo "  init      - Set up complete environment (venv + deps + roles)"
	@echo "  venv      - Create Python virtual environment"
	@echo "  install   - Install Python dependencies"
	@echo "  galaxy    - Install Ansible roles"
	@echo "  shell     - Start interactive shell with venv activated"
	@echo "  check     - Run playbook in check mode with diff"
	@echo "  apply     - Run playbook to apply changes"
	@echo "  vault-edit   - Edit encrypted secrets"
	@echo "  vault-view   - View encrypted secrets"
	@echo "  vault-rekey  - Change vault password"
	@echo "  clean     - Remove virtual environment"
	@echo ""
	@echo "Quick start: make init"

init: venv install galaxy

venv:
	@test -d venv || python3 -m venv venv
	@venv/bin/python -m pip install --upgrade pip wheel

install: venv
	@venv/bin/pip install -r requirements.txt

galaxy: install
	@venv/bin/ansible-galaxy role install -p roles -r requirements.yml

shell: venv
	@bash -lc 'source venv/bin/activate && exec bash -i'

check: galaxy
	@venv/bin/ansible-playbook playbooks/site.yml --check --diff

apply: galaxy
	@venv/bin/ansible-playbook playbooks/site.yml

vault-edit: venv
	@venv/bin/ansible-vault edit host_vars/secrets.yml

vault-view: venv
	@venv/bin/ansible-vault view host_vars/secrets.yml

vault-rekey: venv
	@venv/bin/ansible-vault rekey host_vars/secrets.yml

clean:
	@rm -rf venv
