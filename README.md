# dante socks5 server [![](https://img.shields.io/docker/pulls/cntrump/ubuntu-dante)](https://hub.docker.com/r/cntrump/ubuntu-dante)

ubuntu docker image.

```
docker pull cntrump/ubuntu-dante:1.4.2
```

Run socks5 server

```
docker run -it --rm -p 1080:1080 cntrump/ubuntu-dante:1.4.2
```

Test

```
curl --socks5 YOUR_SERVER:1080 -v https://lvv.me
```
