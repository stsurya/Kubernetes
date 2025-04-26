# Docker_Vs_containerD

## What is containerD ?

Docker pulled it core container runtime into a standalone project called containerD and donated it to CNCF. Later on containerD reached the maturity level of CNCF by representing it's improvements, adpotion and support. Today, developers recognize containerd as an industry-standard container runtime known for its scalability, performance, and stability.

## How Docker interacts with containerd ?

what happens when you run the docker run command:

- After you select enter, the Docker CLI will send the run command and any command-line arguments to the Docker daemon (dockerd) via REST API call.
- dockerd will parse and validate the request, and then it will check that things like container images are available locally. If they’re not, it will pull the image from the specified registry.
- Once the image is ready, dockerd will shift control to containerd to create the container from the image.
- Next, containerd will set up the container environment. This process includes tasks such as setting up the container file system, networking interfaces, and other isolation features.
- containerd will then delegate running the container to runc using a shim process. This will create and start the container.
- Finally, once the container is running, containerd will monitor the container status and manage the lifecycle accordingly.

To set the namepsace, so that we no need to use -n everytime
`kubectl config set-context --current --namespace votingapp`
