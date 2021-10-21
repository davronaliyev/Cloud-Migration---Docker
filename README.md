# Cloud Migration - Docker

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
  <img src="/src/img/container-vm-whatcontainer_2.png" width="450" title="hover text">
  <img src="/src/img/docker-containerized-appliction-blue-border_2.png" width="450" alt="accessibility text">
</p>



