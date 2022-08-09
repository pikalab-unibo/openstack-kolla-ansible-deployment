set -e

echo "### Bootstrapping servers #####################################################"
kolla-ansible -i ./multinode.ini bootstrap-servers -e "@secrets.yml"
echo
echo "### Pre-checks ################################################################"
kolla-ansible -i ./multinode.ini prechecks -e "@secrets.yml"
echo "### Done ####################################################################"
