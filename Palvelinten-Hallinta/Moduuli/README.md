# Log collection Salt State File for Salt-Project master-minion
Created by Giang Le

Goal of this salt state is to create an easy way to collect all relevant logs from your Minions to your Master. This is just a proof of concept for collecting logs from minions. 

## How to use
- Allow file receiving by modifying your /etc/salt/master with ```sudoedit /etc/salt/master```

```bash
file_recv: True
file_recv_size_max: 1000
```
- move the saltcollection folder into


1. Prequisites: 
    - Working Vagrant installation
    - Files from this repository
2. Setup Vagrant environment with the provided Vagrantfile
    - Create folder for your Vagrant and move the Vagrantfile there
    - Navigate to the path Vagrantfile is in
    - Create the virtual machines with command ```vagrant up```
3. Connect into your master ```vagrant ssh boss```
4. Move the salt state folders ```logcollection``` and ```testenvironment``` to ```/srv/salt/logcollection/``` and ```/srv/salt/testenvironment/```. 
    - Optionally create the folders manually and then create the corresponding init.sls files into correct path
      - ```sudo mkdir -p /srv/salt/logcollection/```
      - ```sudoedit /srv/salt/logcollection/init.sls``` <-- copy the /logcollection/init.sls contents here
      - ```sudo mkdir -p /srv/salt/testenvironment/```
      - ```sudoedit /srv/salt/testenvironment/init.sls``` <-- copy the /testenvironment/init.sls contents here
5. Edit your salt-master configuration to allow for file sending with ```sudoedit /etc/salt/master```
    - You can also just append new lines into the end of configuration file
      - ```echo "file_recv: True" | sudo tee -a /etc/salt/master```
      - ```echo "file_recv_size_max: 1000" | sudo tee -a /etc/salt/master```
6. Run ```salt '*' state.apply testenvironment``` to setup test environment into minions
7. Run ```salt '*' state.apply logcollection``` to collect logs from minions.


## Test environment
Vagrantfile creates master ```boss``` and 3 minions ```bob```, ```stuart``` and ```kevin```.    
It also edits ```/etc/salt/master``` to allow for file transfers from minions.    
Lastly it imports ```logcollection``` and ```testenvironment``` salt state folders into boss.    

1. Prequisites: 
    - Working Vagrant installation
    - Files from this repository
2. Setup Vagrant environment with the provided Vagrantfile
    - Create folder for your Vagrant and move the Vagrantfile there
    - Navigate to the path Vagrantfile is in
    - Create the virtual machines with command ```vagrant up```
3. Connect into your master ```vagrant ssh boss```
4. Run ```salt '*' state.apply testenvironment``` to setup test environment into minions
5. Run ```salt '*' state.apply logcollection``` to collect logs from minions.
6. Check whether the file has been collected and sent to master ```find /var/cache/salt/master/minions/ -type f```


## Further setup
You might want to modify the /logcollection/init.sls to fit your log collection needs as it searches for logs everywhere. Most things you'd likely want to edit are set as variables. 

```{% set working_dir = '/logcollection' %}``` = Main directory the salt state will be using.    
```{% set log_dir = working_dir + '/logs' %}``` = Directory you want logs to be collected into on your minion.    
```{% set search_dir = '/' %}``` = What directory logs will be searched in. Currently ```/``` which searches everything.    
```{% set minion_id = grains['id'] %}``` = Self-explanatory. Used to identify tar file.     
```{% set log_time = salt['cmd.run']('date +%Y%m%d_%H%M%S') %}``` = Self-explanatory. Used to identify tar file.     
```{% set tar_filename = minion_id ~ '_' ~ log_time ~ '.tar.gz' %}``` = Self-explanatory. Actual variable used to name tar file.     
```{% set tar_path = working_dir ~ '/' ~ tar_filename %}``` = Path tar file will be created into.     

## License
This project is licensed under the GNU General Public License v3.0.  
See the [license](LICENSE) file for details.
