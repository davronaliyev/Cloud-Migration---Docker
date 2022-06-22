
* [Setup Grid on Kubernetes](#Setup-Grid-on-Kubernetes)



### Setup Grid on Kubernetes

*You need kubectl command line, follow this steps to install https://kubernetes.io/docs/tasks/tools/install-kubectl*


* Downlaod and Run below code from directory where file is saved "/scripts/GridDeployment.yml"

        kubectl apply -f GridDeployment.yml 

* Let's get Selenium Grid Port by running below code:

        kubectl get all -l name=selenium-hub 

        Under PORT(S) column you will see exposed "4444:30443/TCP" we need this "30443" port (yours will be different).

* Now you can access to Grid with this url http://localhost:<yourPort>/grid/console 
and to check you running pods:

        kubectl get pods