## Laboratory work XIII

Данная лабораторная работа посвещена изучению систем для автоматизации развёртывания и управления приложениями на примере **Docker**

```ShellSession
$ open https://docs.docker.com/get-started/
```

## Tasks

- [v] 1. Создать публичный репозиторий с названием **lab13** на сервисе **GitHub**
- [v] 2. Ознакомиться со ссылками учебного материала
- [v] 3. Выполнить инструкцию учебного материала
- [v] 4. Составить отчет и отправить ссылку личным сообщением в **Slack**

## Tutorial

```ShellSession
$ export GITHUB_USERNAME=a346560
```

```ShellSession
$ git clone https://github.com/${GITHUB_USERNAME}/lab12 lab13
$ cd lab13
$ git remote remove origin
$ git remote add origin https://github.com/${GITHUB_USERNAME}/lab13
```

```ShellSession
$ cat > Dockerfile <<EOF
FROM ubuntu:16.04
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

RUN apt update
RUN apt install -yy gcc g++ cmake 
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

COPY . print/
WORKDIR print
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

ENV LOG_PATH /home/logs/log.txt
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

VOLUME /home/logs
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

WORKDIR _install/bin
EOF
```

```ShellSession
$ cat >> Dockerfile <<EOF

CMD ./DEMO
EOF
```

```ShellSession
$ docker build -t logger .
Sending build context to Docker daemon 3.728 MB
Step 1 : FROM ubuntu:16.04
 ---> d355ed3537e9
Step 2 : COPY . print/
 ---> 655c706a3905
Removing intermediate container 419016018a80
Step 3 : WORKDIR print
 ---> Running in 3933e3236893
 ---> bbb5a9d44c3b
Removing intermediate container 3933e3236893
Step 4 : ENV LOG_PATH /home/vershinin/lab13/logs/log.txt
 ---> Running in fbbd98a98883
 ---> e2ddde162c4b
Removing intermediate container fbbd98a98883
Step 5 : VOLUME /home/vershinin/lab13/logs
 ---> Running in 6ce9f2a58aef
 ---> c63403c12538
Removing intermediate container 6ce9f2a58aef
Step 6 : WORKDIR _install/bin
 ---> Running in 6f99a7d698cc
 ---> 99f963a72646
Removing intermediate container 6f99a7d698cc
Step 7 : CMD ./DEMO
 ---> Running in 3aa21c389f33
 ---> e9ec7c6cded7
Removing intermediate container 3aa21c389f33
Successfully built e9ec7c6cded7

```

```ShellSession
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
logger              latest              e9ec7c6cded7        About a minute ago   121.3 MB
<none>              <none>              b06bdfea07d7        3 minutes ago        121.4 MB
<none>              <none>              d2f3a44da820        5 minutes ago        121.4 MB
<none>              <none>              e982903285f0        10 minutes ago       119.7 MB
<none>              <none>              7d1a91ce01f8        16 minutes ago       119.7 MB
ubuntu              16.04               d355ed3537e9        4 days ago           119.2 MB

```

```ShellSession
$ mkdir logs
$ docker run -it -v "$(pwd)/logs/:/home/logs/" logger
text1
text2
text3
<C-D>
```

```ShellSession
$ docker inspect logger
[
    {
        "Id": "sha256:4b632ed3b6fc5f182c74c80aa8c5114cc12fd68824a4832fa318356fd7040d8b",
        "RepoTags": [
            "logger:latest"
        ],
        "RepoDigests": [],
        "Parent": "sha256:83127f3c0c71caf38a63ee3af9bd5eee38b33f22a75e9cbdd3e9d44059bc8f59",
        "Comment": "",
        "Created": "2017-06-25T11:35:04.50683813Z",
        "Container": "75d0f3cbba29aa38ea7f87ef73cff2722daeb5482c5d9e76bab7cb454163bf09",
        "ContainerConfig": {
            "Hostname": "d4f93cc44884",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "LOG_PATH=/home/vershinin/lab10/lab10/logs/log.txt"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"/bin/sh\" \"-c\" \"./DEMO\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:83127f3c0c71caf38a63ee3af9bd5eee38b33f22a75e9cbdd3e9d44059bc8f59",
            "Volumes": {
                "/home/vershinin/lab10/lab10/logs": {}
            },
            "WorkingDir": "/print/_install/bin",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": {}
        },
        "DockerVersion": "1.12.6",
        "Author": "",
        "Config": {
            "Hostname": "d4f93cc44884",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "LOG_PATH=/home/vershinin/lab10/lab10/logs/log.txt"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "./DEMO"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:83127f3c0c71caf38a63ee3af9bd5eee38b33f22a75e9cbdd3e9d44059bc8f59",
            "Volumes": {
                "/home/vershinin/lab10/lab10/logs": {}
            },
            "WorkingDir": "/print/_install/bin",
            "Entrypoint": null,
            "OnBuild": [],
            "Labels": {}
        },
        "Architecture": "386",
        "Os": "linux",
        "Size": 121303958,
        "VirtualSize": 121303958,
        "GraphDriver": {
            "Name": "aufs",
            "Data": null
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:cb11ba6054003d39da5c681006ea346e04fb3444086331176bf57255f149c670",
                "sha256:5a4c2c9a24fc72cc78b3dabee0ae32be12ab197732df433ecb81cef8a00b5f87",
                "sha256:182d2a55830d06a1f25899b81a3fc83dfc4e30eb5c8cad164e0024657dba7528",
                "sha256:6f9cf951edf547ab4895ee15110108dd6659952b1479a95bd348c204035da461",
                "sha256:0566c118947e4983e51c1deddc184238cb372d4318c75a15f9a143a89797c04a",
                "sha256:8d0b447c635d9c766d7877c859cb3dbf320903fe3d32cfb7a49798ede9b0cb0a"
            ]
        }
    }
]

```

```ShellSession
$ cat logs/log.txt
```

```ShellSession
$ vim README.md
:s/lab12/lab13/g<CR>
:wq
```

```ShellSession
$ vim .travis.yml
/lang<CR>o
services:
  - docker<ESC>
jVGddo
script:
  - docker build -t logger .<ESC>
```

```ShellSession
$ git add Dockerfile
$ git add .travis.yml
$ git commit -m"adding Dockerfile"
$ git push origin master
```

```ShellSession
$ travis login --auto
e need your GitHub login to identify you.
This information will not be sent to Travis CI, only to api.github.com.
The password will not be displayed.

Try running with --github-token or --auto if you don't want to enter your password anyway.

Username: a346560
Password for a346560: ********
Successfully logged in as a346560!

$ travis enable
a346560/lab13: enabled :)

```

## Report

```ShellSession
$ cd ~/workspace/labs/
$ export LAB_NUMBER=13
$ git clone https://github.com/tp-labs/lab${LAB_NUMBER} tasks/lab${LAB_NUMBER}
$ mkdir reports/lab${LAB_NUMBER}
$ cp tasks/lab${LAB_NUMBER}/README.md reports/lab${LAB_NUMBER}/REPORT.md
$ cd reports/lab${LAB_NUMBER}
$ edit REPORT.md
$ gistup -m "lab${LAB_NUMBER}"
```

## Links

- [Instructions](https://docs.docker.com/engine/reference/builder/)
- [Book](https://www.dockerbook.com)

```
Copyright (c) 2017 Братья Вершинины
```
