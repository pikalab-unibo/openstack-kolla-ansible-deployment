echo "### Bootstrapping servers #####################################################"
kolla-ansible -i ./multinode.ini bootstrap-servers -e "@secrets.yml"
echo
echo "### Pre-checks ################################################################"
kolla-ansible -i ./multinode.ini prechecks -e "@secrets.yml"
echo
echo "### Depoly ####################################################################"
kolla-ansible -i ./multinode.ini deploy -e "@secrets.yml"
echo "### Done ######################################################################"