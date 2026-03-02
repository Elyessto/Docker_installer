#!/bin/bash
if grep -qi '^ID=ubuntu' /etc/os-release; then	
	echo "This is an Ubuntu system detected "
	sudo apt-get update -y 
	sudo apt-get install ca-certificates curl -y 
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update -y 
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
	echo "Checking  if docker is sucessfully installed"
	docker run -dit --rm --name test  hello-world 
	echo "deleting the docker container \n"
	docker rm -f test 
	docker rmi hello-world:latest
	echo '==========================='
	echo "installation successfull !!!!!!!!!! :D"
else 
	 echo "This Is Not a Ubuntu system !!!! "
	 echo "installation Failed  :(((((((((((( "
fi 
