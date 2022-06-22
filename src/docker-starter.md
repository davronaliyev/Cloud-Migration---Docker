**Table of Contents**
* [What is Docker?](#What-is-Docker?)
* [Docker Image](#Docker-Image)
* [Docker Network](#Docker-Network)
* [Docker Volume](#Docker-Volume)
* [Docker Swarm](#Docker-Swarm)
* [Install Docker Engine on Ubuntu](#Install-Docker-Engine-on-Ubuntu)

##	What is Docker? 
Docker is a software platform that allows you to build, test, and deploy applications quickly. Docker packages software into standardized units called containers that have everything the software needs to run including libraries, system tools, code, and runtime. Using Docker, you can quickly deploy and scale applications into any environment and know your code will run.

## How Docker works
Docker works by providing a standard way to run your code. Docker is an operating system for containers. Similar to how a virtual machine virtualizes (removes the need to directly manage) server hardware, containers virtualize the operating system of a server. Docker is installed on each server and provides simple commands you can use to build, start, or stop containers.

<table border="0">
 <tr>
    <td><b style="font-size:30px">Virtual Machines</b></td>
    <td><b style="font-size:30px">Containers</b></td>
 </tr>
 <tr>
    <td>Virtual machines (VMs) are an abstraction of physical hardware turning one server into many servers. The hypervisor allows multiple VMs to run on a single machine. Each VM includes a full copy of an operating system, the application, necessary binaries and libraries - taking up tens of GBs. VMs can also be slow to boot.</td>
    <td>Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (container images are typically tens of MBs in size), can handle more applications and require fewer VMs and Operating systems.</td>
 </tr>
</table>

<p align="center">
  <img src="/src/img/container-vm-whatcontainer_2.png" width="400" title="hover text">
  <img src="/src/img/docker-containerized-appliction-blue-border_2.png" width="400" alt="accessibility text">
</p>

## Getting Started
Install Docker Desktop
```
sripts/docker-setup.ps1
```
Running your first container
```
docker run -d -p 80:80 docker/getting-started
```
Once it has started, you can open your browser to http://localhost

## Docker Image
Build:    
      
      docker build -f YourDockerfile -t ImageName:latest .
Run:      

      docker run -it --entrypoint sh ImageName:latest

### Build and Publish Docker Image to JFROG 
    #   Login:  docker login jfrog.url.com
    #   Build:  docker image build -t ImageName:latest .
    #   Tag:    docker tag ImageName:latest jfrog.url.com/Repository/ImageName:latest
    #   Push:   docker push jfrog.url.com/Repository/ImageName:latest
    #   Pull:   docker pull jfrog.url.com/Repository/ImageName:latest
    #   Run:    docker run -it --entrypoint=sh jfrog.url.com/Repository/ImageName:latest

### Build and Publish Docker Image to GitLab
    #   Login:  docker login gitlab.url.net: xxxx
    #   Build:  docker image build -t gitlab.url.net: xxxx .
    #   Push:   docker push gitlab.url.net: xxxx

## Docker Network
      
Create new "my-net" network

      docker network create my-net
      docker network ls

Inspect the network

      docker network inspect my-net

Create your four containers. Notice the --network flags. You can only connect to one network during the docker run command, so you need to use docker network connect afterward to connect alpine4 to the bridge network as well


      docker run -dit --name alpine1 --network my-net alpine
      docker run -dit --name alpine2 --network my-net alpine
      docker run -dit --name alpine3 alpine
      docker run -dit --name alpine4 --network my-net alpine
      docker network connect bridge alpine4

 Let’s connect to alpine1 and test this out. alpine1 should be able to resolve alpine2 and alpine4 (and alpine1, itself) to IP addresses.

      docker container attach alpine1

      # ping -c 2 alpine2
      # ping -c 2 alpine4
      # ping -c 2 alpine3

Check the IP address
      
      docker inspect alpine1 | grep IPAddress

Stop and remove all containers and the alpine-net network

      docker container stop alpine1 alpine2 alpine3 alpine4

      docker container rm alpine1 alpine2 alpine3 alpine4

      docker network rm alpine-net

## Docker Volume
Create new volume

      docker volume create --name DataVolume
      docker volume ls

Let's run new container with DataVolume

      docker run -dit --network=my-net -v DataVolume:/testData --name=container1 alpine

We will create file inside testData folder

      docker container attach container1

      # cd testData
      # echo "Share this file between containers" > /testData/myscript.sh

Now let's create new container with DataVolume and check if file we created is attached

      docker run -dit --network=my-net -v DataVolume:/testData --name=container2 alpine

      docker container attach container2

      # cd testData

Copy file to container from local

      docker cp ./data.xml container1:/root/data.xml

## Install Docker Engine on Ubuntu

    1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:
         $ sudo apt-get update
         $ sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            lsb-release

    2. Add Docker’s official GPG key:
        $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        
    3. Use the following command to set up the stable repository. 
        $  echo \
          "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    4. Update the apt package index, and install the latest version of Docker Engine and containerd:

        $ sudo apt-get update
        $ sudo apt-get install docker-ce docker-ce-cli containerd.io

    5. Verify that Docker Engine is installed correctly by running the hello-world image.

        $ sudo docker run hello-world

Uninstall Docker Engine

    $  sudo apt-get purge docker-ce docker-ce-cli containerd.io

Reference: https://docs.docker.com/engine/install/ubuntu/


## Docker Swarm

[Swarm Guide](/swarm/swarm-guide.md)

Docker Swarm is a native clustering tool for Docker which turns multiple Docker engines into a cluster and makes that a cluster by making it look like a single Docker engine. It's easier to install than any other container orchestrator. This way, you can create a pool of Virtual Machines that are container hosts and scale out your applications using Docker as if you were using a single VM.

Lets make first node a manager.

      docker swarm init --advertise-addr $(hostname -i)

This will create token for us then we need use that token on other node.

Copy the join command (watch out for newlines) output and paste it in the other terminal.