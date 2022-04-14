set -e

ansible -i test.ini all -m command -a "dnf install chrony" -e "@secrets.yml"
ansible -i test.ini all -m command -a "systemctl start chronyd" -e "@secrets.yml"
ansible -i test.ini all -m command -a "systemctl enable chronyd" -e "@secrets.yml"
# https://linuxhint.com/configure-ntp-centos-8/

# No host NTP daemon is running, and the Kolla Ansible chrony container is disabled. Please install and configure a host NTP daemon. Alternatively, set 'prechecks_enable_host_ntp_checks' to 'false' to disable this check if not using one of the following NTP daemons: chrony, ntpd, systemd-timesyncd.
