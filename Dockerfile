FROM mattrayner/lamp:latest

#### Enable SSH
RUN apt-get update && \
	apt-get install -y openssh-server && \
	rm -rf /var/lib/apt/lists/* && \
	apt-get clean

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir -p /var/run/sshd
	

#### END ENABLE SSH

# Copy Default Laravel Project
COPY ./app /app

EXPOSE 22 80

# Run SSH & Laravel+MySQL
CMD /usr/sbin/ssh & /run.sh


# Change myimagename to some useful image name
    ## BUILD WITH: docker build . -t myimagename

# Running: Change myimagename to your image name, change mycontainername to a userful containername
# Param -it for interactive
# Param -v for volume so you can develop live
# Param -d for detached
# Params -p for port binding
    ## docker run -it -p 80:80 -p 22:22 -v ${PWD}/app:/app --name mycontainername myimagename