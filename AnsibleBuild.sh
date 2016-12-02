#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/lib

#Install os requirements
yum -y install gcc openssl-devel libffi-devel python-devel vim wget curl bzip2

#Install ansible dependancies by pip
pip install ansible

#Change all call from ansible.compat.six to six 
grep -rl ansible.compat.six /usr/local/lib/python2.7/site-packages/ansible | xargs sed -i ‘s/ansible.compat.six/six/g’

#Install Ansible source 
cd /root/ 
git clone https://github.com/ansible/ansible.git 
cd ansible 
git checkout stable-2.2

#Install Devel Version of Pyinstaller (The stable version get an AssertionError) 
cd /root/
git clone https://github.com/otassetti/pyinstaller.git
git checkout develop

#Compile 
cd /root/pyinstaller 
python2.7 ./pyinstaller.py –onefile –clean –nowindow –upx-dir=/opt/upx-3.91-amd64_linux/ /root/ansible/bin/ansible
