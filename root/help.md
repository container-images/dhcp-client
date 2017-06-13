% DHCP-CLIENT (1) Container Image Pages
% Karsten Hopp
% June 13, 2017

# NAME
dhcp-client - Dynamic Host Configuration Protocol Client

# DESCRIPTION
A DHCP client container running as a root user based on Base Runtime. Provides a means for configuring one or more network interfaces using DHCP.

# USAGE
This container can be run as a service by running:

	# systemctl start dhcp-client-container

For runnning in docker use:

	# docker run --net=host --cap_add=net_admin dhcp-client-container

If you want to run this in openshift, you need to have SCC RunAsUser set to RunAsAny. Then run:

	# oc create -f openshift-template.yml

By default, this container will try to configure all available interfaces, unless enviroment variable INTERFACES is set.

# ENVIRONMENT VARIABLES
You can define following enviroment variables using docker option -e:

INTERFACES="enp0s25 wlan0"
                A list of intefaces to be configured. otherwise all available interfaces will be configured

# SECURITY IMPLICATIONS
Both of these options are needed for running this container:

--net=host
     Uses host network stack.

--cap_add=net_admin
     Allows container to modify network devices.

This container also needs to run as root user.

# SEE ALSO

Github page for this container with detailed description: https://github.com/container-images/dhcp-client