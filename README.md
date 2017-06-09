# DHCP Client Container: dhclient


## Description

A **DHCP client container** running as a **root user** based on **Fedora 25**. 


## Running as a standalone container

```
systemctl start dhcp-client-container
```

## Running in Docker

```
docker run --net=host --cap_add=net_admin dhcp-client-container
```
or, if only a defined list of interfaces should be configured be dhclient:
```
docker run --net=host --cap_add=net_admin -e INTERFACES="enp0s25 wlan0" dhcp-client-container
```

## Running in OpenShift

To run this container in OpenShift, you need to change the `RunAsUser` option in the `restricted` Security Context Constraint (SCC) from `MustRunAsRange` to `RunAsAny`. This is because `dhclient` needs to be run as root. Do it by running:

```
oc login -u system:admin
oc project default
oc edit scc restricted
```

Find `RunAsUser` and change its value from `MustRunAsRange` to `RunAsAny`.

Then you will be able to run the container using the `openshift-template.yml` template in this repo:

```
oc login -u developer
oc create -f openshift-template.yml
```

Notes:
This container needs to be run with "--net=host --cap_add=net_admin" so that the network devices of the host are visible inside the container and can be configured.

dhclient will attempt to configure all network interfaces unless an INTERFACES variable containing the names of the interfaces to use is supplied on the docker commandline.
In the standalone container usecase the means that the file /usr/lib/systemd/system/dhcp-client-container.service needs to be edited.

This dhcp-client container doesn't require NetworkManager to be able to set IP adresses, which minimizes the the package requirements and the  memory footprint but makes configuration somewhat harder.
