FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y git 
RUN apt-get install -y python3 python3-dev pip
RUN apt-get install -y libffi-dev 
RUN apt-get install -y gcc 
RUN apt-get install -y libssl-dev
RUN pip3 install 'ansible<4.11' 'ansible-core<2.12'
RUN pip3 install git+https://github.com/openstack/kolla-ansible@stable/xena
RUN mkdir -p /etc/kolla
RUN cp -r /usr/local/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
WORKDIR /root
RUN cp /usr/local/share/kolla-ansible/ansible/inventory/* .
RUN kolla-genpwd
COPY ansible.cfg /etc/ansible/
COPY .ssh .ssh
COPY .secrets.yml .
COPY *.ini ./
ENV ANSIBLE_EXTRA_OPTS '-e "@.secrets.yml" --ask-vault-pass'
CMD /bin/bash
# ansible -i test.ini all -m ping $ANSIBLE_EXTRA_OPTS