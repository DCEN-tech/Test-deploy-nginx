FROM debian:bullseye

COPY id_rsa.pub /tmp/

COPY --chown=root:root entrypoint.sh /opt/scripts/entrypoint.sh

RUN apt-get update            \
   && apt-get install -y      \
         openssh-server       \
         python3              \
   && mkdir /run/sshd         \
   && mkdir --mode 700 ~/.ssh \
   && chmod u+x /opt/scripts/entrypoint.sh

# Permit root login
RUN sed -E 's/^#PermitRootLogin .+/PermitRootLogin yes/' /etc/ssh/sshd_config -i

# Generate the host keys
RUN ssh-keygen -A

RUN cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys \
   && /bin/rm -f /tmp/id_rsa.pub

EXPOSE 22/tcp
EXPOSE 80/tcp

# Start ssh server
ENTRYPOINT ["/opt/scripts/entrypoint.sh"]
