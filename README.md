# DHCP Client Container: dhclient


## Description

A **DHCP client container** running as a **root user** based on **Fedora 25**. 


## Running in Docker

```
$ docker run --net=host --cap_add=net_admin docker.io/khopp/dhcp
```

## Running in OpenShift

To run this container in OpenShift, you need to change the `RunAsUser` option in the `restricted` Security Context Constraint (SCC) from `MustRunAsRange` to `RunAsAny`. This is because `dhclient` needs to be run as root. Do it by running:

```
$ oc login -u system:admin
$ oc project default
$ oc edit scc restricted
```

Find `RunAsUser` and change its value from `MustRunAsRange` to `RunAsAny`.

Then you will be able to run the container using the `openshift-template.yml` template in this repo:

```
oc login -u developer
oc create -f openshift-template.yml
```

Limitations:
This container needs to be run with "--net=host --cap_add=net_admin" so that the network devices of the host are visible inside the container and can be configured.
