set -e

ansible -i test.ini all -m command -a "yum install -y yum-utils" -e "@secrets.yml"
ansible -i test.ini all -m command -a "yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo" -e "@secrets.yml"
ansible -i test.ini all -m command -a "yum install --allowerasing -y docker-ce docker-ce-cli containerd.io" -e "@secrets.yml"
ansible -i test.ini all -m command -a "systemctl start docker" -e "@secrets.yml"
ansible -i test.ini all -m command -a "systemctl enable docker" -e "@secrets.yml"

# No host NTP daemon is running, and the Kolla Ansible chrony container is disabled. Please install and configure a host NTP daemon. Alternatively, set 'prechecks_enable_host_ntp_checks' to 'false' to disable this check if not using one of the following NTP daemons: chrony, ntpd, systemd-timesyncd.

