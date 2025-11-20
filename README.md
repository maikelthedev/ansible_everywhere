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

# Add Fish shell functions

Assumign this project is on `~/code/ansible_everywhere` then

```fish
set -eg fish_function_path
set -U fish_function_path $fish_function_path ~/code/ansible_everywhere/dotfiles/.config/fish/functions
```

For an issue tracker of the project check [here](https://github.com/users/maikelthedev/projects/2)


