### Install
```
yum install yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io
```

### Autoload
```
systemctl enable --now docker
systemctl status docker
```

### List
> docker ps

> ss -tulnp

### Add container
Webpagetest:
> docker pull webpagetest/server

> docker pull webpagetest/agent

### Run
docker run -d -p 80:80 --restart=always --name wpt-server webpagetest/server
