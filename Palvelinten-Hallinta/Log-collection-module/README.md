# Log collection Salt State for Salt-Project
Created by Giang Le

Goal of this salt state is to create an easy way to collect all relevant logs from your Minions to your Master along with creating testing environment to test log collection. Currently just a proof of concept for collecting logs from salt-minions. 

<img src="https://github.com/user-attachments/assets/7ac34f79-51ab-4015-bca2-4ff53a317f29" width="500"> <br/>

## How to use logcollection state as a standalone
- Allow file receiving by modifying your /etc/salt/master with ```sudoedit /etc/salt/master```. 

```bash
file_recv: True
file_recv_size_max: 1000
```

- Download and move the ```logcollection``` Salt state folder into ```/srv/salt/logcollection/``` on your salt-master. 
- Run ```sudo salt '*' state.apply logcollection``` to collect logs from minions.
- All logs should now be found as a compressed archive file on your salt-master ```/var/cache/salt/master/minions/MINIONID/logcollection/```


## Using the provided test environment
Vagrantfile creates salt-master ```boss``` and 3 salt-minions ```bob```, ```stuart``` and ```kevin```.    
It also edits ```/etc/salt/master``` to allow for file transfers from minions.    
Lastly it has ```logcollection``` and ```testenvironment``` salt state folders included in salt-master ```boss```.    

1. Prequisites: 
    - Working Vagrant installation
    - Vagrantfile from this repository
2. Setup Vagrant environment with the provided Vagrantfile
    - Create folder for your Vagrant and move the Vagrantfile there
    - Navigate to the path Vagrantfile is in within terminal
    - Create the virtual machines with command ```vagrant up```
3. Connect into your master ```vagrant ssh boss```
4. Run ```sudo salt '*' state.apply testenvironment``` to setup test environment into minions
5. Run ```sudo salt '*' state.apply logcollection``` to collect logs from minions.
6. Check whether the file has been collected and sent to master ```find /var/cache/salt/master/minions/ -type f```


## Further setup
You might want to modify the /logcollection/init.sls to fit your log collection needs as it currently searches for all logs (which is not feasible for production use). Most things you'd likely want to edit are set as variables. 

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
