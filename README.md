# This document covers setting up django-todo in minikube.

## We will start our journey from local minikube installation. 
1. The `minikube_install.sh` have some simple steps to get `kubectl` and `minikube` with kvm drivers.
2. Check and Run `minikube.sh` to deploy a VM with cluster (it's have some options about CPU and RAM).
3. At this point `kubectl get ns` should show you an empty cluster (only standart namespaces must be listed).

## Now it's time for deployment
Entrypoint into deployment process is the `deploy.sh`. This file consists of few blocks:

1. `docker build` will create an image. There are some nuances: 
    - The first of all os `local.py`. This file can be placed as a configMap too. Changes of the file are simple: `os.environ`
    for all the external keys and `ALLOWED_HOSTS` Django parameter. Not a good idea to set it to `*` for production.
    - The second one is `entrypoint.sh`. Script is quite simple, but you should know it is exist.
    Also, expression `eval $(minikube docker-env)` make some magic to put builded image into VM with minikube.
2. `kubectl create secret...` should be placed in vault or any other secrets storage. I'm simply have nothing.
3. This solution have `https://github.com/helm/charts/tree/master/stable/postgresql` as a dependency. Few notes about it:
    - Really bad idea to use not cluterized DBs in production.
    - No any backups.
    - We must fetch dependencies before the final `helm install` command.
4. `sleep` - you know...
5. `minikube service todo` - i decided to not add another dependencies, like nginx, instead of that Service type was changed to `NodePort`.
    Durty, but legal for local development. Also, there is a way to set exact port for NodePort, but now is about 2AM.

Pretty much that's it! 
Of course there are so many things to improve...

`deployment.yaml` template was changed a little... 
There are no tests. Bad, i know.
Better to use dedicated namespace instead of default..
Sometimes github can ban users, better to impletment API key for github auth in Dockerfile...
It's also possible to add teraform via local-exec provider for `minikube_install.sh` but it's almost pointless...

Maybe, i miss something...

Tested with:
 - Kubernetes v1.17.2 in minikube
 - helm v302
 - Ubuntu 19.10
