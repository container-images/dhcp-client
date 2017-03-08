FROM fedora:25
MAINTAINER Karsten Hopp, Red Hat <karsten@redhat.com>
LABEL name="DHCP client container" \
      vendor="Fedora Project" \
      Release="1" \
      version="1.0" \
      architecture="x86_64" \
      authoritative-source-url="registry.fedoraproject.org" \
      org.fedoraproject.component="dhclient-container" \
      io.k8s.description="A container with the DHCP client" \
      io.k8s.display-name="DHCP client (dhclient)"


ADD dhcp-module.repo /etc/yum.repos.d/dhcp-module.repo
ADD files/rundhcp.sh /usr/sbin/rundhcp.sh

#RUN dnf -y --best --allowerasing install dbus strace net-tools iproute dhcp-client
RUN dnf -y --best --allowerasing install dhcp-client && \
    dnf clean all && \
    chmod 755 /usr/sbin/rundhcp.sh && \
    chown daemon.daemon /var/lib/dhclient

ENV INTERFACE=enp0s25
USER 0
CMD ["/usr/sbin/rundhcp.sh"]

