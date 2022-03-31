1. Install Ansible (requires Python 3 and PIP)

2. Generate a couple of private and public keys via `ssh-keygen`
    - say, `/path/to/id_rsa` and `/path/to/id_rsa.pub`
    - recall to set a __passphrase__

3. Ensure these keys are authorized for SSH access on the machines upon which Openstack should be installed

4. Call `setup.sh`, providing:
    - a password for encrypting the following field
    - your username on the machines upon which Openstack should be installed
    - the password corresponding to that user, on that machines
    - the path of the __private__ key generated above (`/path/to/id_rsa`)
    - the passphrase corresponding to that key

5. Call `build.sh` (may take a while on the first time)

6. Call `run.sh`
    - this should start a container, install Ansible and Kolla, set up keys accordingly, and finally open a shell

7. Call `install-openstack.sh` on that shell
