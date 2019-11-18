# D02 - Ansible

## Scaleway Account

You have a temporary scaleway account:
  - Email: `jquere-efreiXX@scaleway.com` (Where XX is you number)
  - Password: `Sc@l3way`

## Exercises

### E01 - Let's Fork it
Login on gitlab and fork `devops/devops-d02` with your account.
Make sure you make this fork `private` (In project settings / General / Permissions)
Clone this fork on your computer. All exercises must be pushed to this repository.

### E02 - Add you ssh-key
If you don't already have one create an ssh-key pair.
Go to https://console.scaleway.com and upload you ssh-key in your account.

### E02 - My cloud instance
Create 3 Scaleway servers with your account.
You should create 3 `DEV1-S` with an `Ubuntu Bionic` image.
Leave default option for volumes and networks options.
Name your server `www01` and `www02` and `db01`

### E03 - SSH Connection
Make sure you can connect to your server using your ssh-key.
Congrats you have created your first cloud compute instance.

### E04 - Ansible inventory
Create an ansible inventory file (you can either use `ini` or `yaml` format)
Your inventory should have a group `www` with your server `www01` and `www02`
Your inventory should have a group `db` with your server `db01`

> To test your inventory file you should use
> ansible-inventory -i ./hosts --list  

### E05 - Touch
Write an ansible playbook that writes 100 times your name in a file.
This playbook should only run on `www` servers.
The file should be written in `/opt/ex05.txt`

> Hint: use ansible template ( don't copy paste 100 times ;-) )

Your playbook will be tested with `ansible-playbook -i host touch.yml`

### E06 - Mkdir
Using `group_vars` functionality of ansible set a variable
  - `ex06_mkdir: true` for all `www` host
  - `ex06_mkdir: false` for all `db` host
Create a playbook `mkdir.yml` that should be played on all host.
This playbook should create a directory `/opt/ex06` if the variable `ex06_mkdir` is true.
If the variable is false you should make sure the directory and all its content are deleted.

Your playbook will be tested with `ansible-playbook -i host mkdir.yml`

### E07 - Sl
Write an ansible playbook that installs the `sl` package using `apt` module on all hosts.
You playbook should also create a symlink `/usr/local/bin/sl => /usr/games/sl`

Your playbook will be tested with `ansible-playbook -i host sl.yml`

> To test you playbook ssh to a server and type sl

### E08 - Install docker

Write a playbook that installs docker.
To help you with that you can use galaxy role https://galaxy.ansible.com/geerlingguy/docker.
You should add a file `requirements.yml` to your repository so other can install all needed roles.

Your playbook will be tested using:

```
$> ansible-galaxy install -r requirements.yml
$> ansible-playbook -i host docker.yml
```

### E09 - Login

In the same playbook that installs docker, add a task that login to the gitlab registry you used last week.
Of course, you should not push your password in clear text.
Your registry password should be inside an ansible vault.

Your playbook will be tested using:

```
$> ansible-playbook --vault-id @prompt -i host docker.yml
```

> Hint: See docker_login ansible module

### E08 - Deploy a redis

Write a playbook `redis.yml` that deploy a Redis container on all `db` server.
You should use `docker_container` ansible module to deploy your application

To test your playbook, connect to your server and make sure the container is running (`docker ps`).
You should also be able to do connect using `$> redis-cli -h <my_ip> -p 6379`

### E10 - Deploy a web app

Write a playbook `app.yml` that deploy this docker-compose file on  all `www` hosts.
```
version: 3
services:
  app:
    image: registry.efrei.yayo.fr/jerome/devops-d01/node-count-redis:latest
    environment:
      REDIS_HOST: <your redis ip>
      REDIS_POST: 6379
    restart: always
    ports:
      - 80:8080
```

Your playbook should copy this docker-compose file in `/opt/my-app/docker-compose.yml`.
It should then make sure all services are up and running using `docker_service` module.

### E11 - All in one

Write a playbook `all.yml` that will launch `docker`, `redis` and `app` playbooks.

To test your playbook you should delete all your instances, recreate them and start your playbook.
The webapp should be up and running.
