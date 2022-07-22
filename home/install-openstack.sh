set -e

echo "### Bootstrapping servers #####################################################"
kolla-ansible -i ./multinode.ini bootstrap-servers -e "@secrets.yml"
echo
echo "### Pre-checks ################################################################"
kolla-ansible -i ./multinode.ini prechecks -e "@secrets.yml"
echo
echo "### Depoly ####################################################################"
kolla-ansible -i ./multinode.ini deploy -e "@secrets.yml"
echo
echo "### Install Openstack Client ######################################################################"
pip install python-openstackclient -c https://releases.openstack.org/constraints/upper/xena
echo
echo "### Post-Deploy ######################################################################"
kolla-ansible post-deploy -e "@secrets.yml"
. /etc/kolla/admin-openrc.sh
echo "### Done ######################################################################"
