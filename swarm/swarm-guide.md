# Run the following command to create a new swarm:
  
  docker swarm init
  docker swarm init --advertise-addr 172.16.99.20
  docker swarm init --advertise-addr 172.16.99.18:2377 --listen-addr 172.16.99.18:2377
  

# To add a worker to this swarm, run the following command:
docker swarm join-token worker

# To  leave the swarm:
docker swarm leave --force

# To check swarm
docker node ls

# To check Open ports
netstat -a

# Run the following command to deploy docker swarm  -- https://goo.gl/Fsq6fu
  docker stack deploy --compose-file grid.yaml swarmGrid

# To view status of the docker swarm
  docker stack ps swarmGrid

# To scale iptables
  docker service scale selenium_chrome=5
  
# To shut down docker swarm
  docker stack rm swarmGrid

######################################
# Failed to create NAT chain DOCKER
# sudo apt-get install --reinstall iptables
  !dockerd --iptables=false
######################################
# Open a port
  netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=TCP localport=2377

########################################
Uninstall Docker Engine
########################################

# Uninstall the Docker Engine, CLI, and Containerd packages:
    sudo apt-get purge docker-ce docker-ce-cli containerd.io

# To delete all images, containers, and volumes:
    sudo rm -rf /var/lib/docker

########################################
Install Docker Engine
########################################

    sudo curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

# If you would like to use Docker as a non-root user, you should now consider adding your user to the “docker” group with something like:

    sudo usermod -aG docker <your-user>

########################################
Update to WSL 2
To check the WSL mode, run:

    wsl.exe -l -v

To set v2 as the default version for future installations, run:

    wsl.exe --set-default-version 2

To upgrade your existing Linux distro to v2, run:

    wsl.exe --set-version (distro name) 2