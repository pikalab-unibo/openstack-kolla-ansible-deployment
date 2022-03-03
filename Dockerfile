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
RUN echo 'eval $(ssh-agent -s)' >> .bashrc
RUN echo 'ansible localhost -m command -a "sshpass -P passphrase -p {{ passphrase }} ssh-add .ssh/id_rsa" -e "@secrets.yml"' >> .bashrc
CMD /usr/local/bin/ansible-vault decrypt .ssh/id_rsa*; \
    /usr/local/bin/ansible -i test.ini all -m ansible.builtin.debug -a 'msg={{ ansible_host, ansible_user, ansible_password, ansible_become_pass  }}' -e "@secrets.yml"; \
    /bin/bash
# ansible -i test.ini all -m ping -e "@secrets.yml"