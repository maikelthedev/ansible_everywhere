# Ansible Evereywhere

All systems conf made in Ansible for
* Arch
* FreeBSD
* Nixos

Why target these 3? Because those are the 3 more dispair ones I could think of that I might use. 

# How to run

```bash
 ansible-playbook -i inventory/host.ini playbooks/site.yml
```

# For any specific role

Here with the example of Nixos

```bash
 ansible-playbook -i inventory/host.ini playbooks/nixos.yml
```