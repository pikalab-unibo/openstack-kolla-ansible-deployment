FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y git 
RUN apt-get install -y python3 python3-dev pip
RUN apt-get install -y libffi-dev 
RUN apt-get install -y gcc 
RUN apt-get install -y libssl-dev
RUN apt-get install -y sshpass
RUN pip3 install 'ansible<4.11' 'ansible-core<2.12'
RUN pip3 install git+https://github.com/openstack/kolla-ansible@stable/xena
RUN mkdir -p /etc/kolla
RUN cp -r /usr/local/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
WORKDIR /root
RUN cp /usr/local/share/kolla-ansible/ansible/inventory/* .
RUN kolla-genpwd
COPY home/ /root/
# assumes .password file is mounted in /root
# ENV ANSIBLE_VALUT_PWD '--vault-password-file /root/.password/value' 
# ENV ANSIBLE_EXTRA_OPTS "--extra-vars \"@secrets.yml\" $ANSIBLE_VALUT_PWD"
CMD /usr/local/bin/ansible-vault decrypt .ssh/id_rsa*; \
    /usr/local/bin/ansible -i test.ini all -m ansible.builtin.debug -a 'msg={{ ansible_host, ansible_user, ansible_password, ansible_become_pass  }}' -e "@secrets.yml"; \
    /bin/bash
# $ANSIBLE_VALUT_PWD; /bin/bash
# ansible -i test.ini all -m ping -e "@secrets.yml"