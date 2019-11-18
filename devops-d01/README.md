# D01 - Docker

## Before you begin

- Create an account on `gitlab.efrei.yayo.fr`.
  - Make sure you use your real name or I wont be able to grade you.
  - You may have to put you password in some file you are going to push. Don't use your most private password.
- Make sure you have an ssh key on you laptop and add it to your gitlab account.
- Make sure docker is installed on your computer.

## Introduction

When you see `<username>` somewhere please put your gitlab username.

All the bash script you write will be placed in the `scripts` folder.
When your script will be tested they will all be launch from the root of the repo like this. `./scripts/xxxxxxx.sh`.
Be careful if you need to use `cd` or relative path.

## Exercises

### E01 - Let's Fork it
Login to your gitlab account and fork `devops/devops-d01`.
Make sure you make this fork `private` (In project settings / General / Permissions)
Clone this fork on your computer.
All exercises must be pushed to this repository.

### E02 - Registry
Write a bash script that allows you to login to the `registry.efrei.yayo.fr` docker registry.

**NB: Your script should not ask for user inputs.**

**Files to push**:
 - `./scripts/E02-registry.sh`

### E03 - My first Dockerfile
In the `node-hello` folder you will find a simple Node.js application.
The goal of this exercise is to write a `Dockerfile` to build a docker image for this application.

**Files to push**:
 - `./node-hello/Dockerfile`
 
### E04 - Build it
Write a bash script that will build the image based on the Dockerfile you just write.
The image you build must be tagged `registry.efrei.yayo.fr/<username>/devops-d01/hello:latest`

**Files to push**:
 - `./scripts/E04-build-it.sh`
 
### E05 - Run it
Write a bash script that will run the image you just built.
When started correctly you should be able to do this:

```
$> curl localhost:1234
Hello World !
```

The container you create when you run your image should be destroyed when the script ends.
`docker ps -a` should be empty after your script finish ( by hitting `Ctrl-c` )

**Files to push**:
 - `./scripts/E05-run-it.sh`

### E06 - Push it
Write a bash script that will push the image you build to the `registry.efrei.yayo.fr` docker registry.

If you pushed it correctly you should be able to do this:
```
$> docker pull registry.efrei.yayo.fr/<username>/devops-d01/hello:latest
latest: registry.efrei.yayo.fr/<username>/devops-d01/hello
Digest: sha256:xxxxxxxxxxxxxxxxxxxx
Status: Image is up to date for registry.efrei.yayo.fr/<username>/devops-d01/hello:latest
```

**Files to push**:
 - `./scripts/E06-push-it.sh`

### E07 - Run it again
Do the same as E05 but this time you should be able to do this:

```
$> curl localhost:1234
Hello <username> ! 
```

**Files to push**:
 - `./scripts/E07-run-it-again.sh`

### E08 - Language do not matter
In the `go-hello` folder you will find a simple golang application.
The goal of this exercise is to write a `Dockerfile` to build an image for this application.

Write a bash script to build this image.
The image you build must be tagged `registry.efrei.yayo.fr/<username>/devops-d01/hello:latest`

If you build your image correctly you should be able to use scripts from E05 and E07 with the same result.

**Files to push**:
 - `./go-hello/Dockerfile`
 - `./scripts/E08-language-do-not-matter.sh`

```
Hint: 
$> go build main.go <= Build application 
$> ./main <= Run application
```

### E09 - Don't lose it
The `node-count` folder contains a simple Node.js application that counts the number of visitor on a page.
The total number of visits is written in a file `data.json`

Write a `Dockerfile` for this application.
Write a script so  that:
```
$> ./scripts/E09-dont-lose-it.sh build ### Should build an image tag registry.efrei.yayo.fr/<username>/devops-d01/count:latest
$> ./scripts/E09-dont-lose-it.sh run ### Should run the image
$> ./scripts/E09-dont-lose-it.sh ### Should do nothing
```

The trick here is to make sure that each time you run the image the counter should keep its previous value.
(Even if you delete the container)

**Files to push**:
 - `./scripts/E09-dont-loose-it.sh`

### E10 - Start to compose
Write a docker compose file for `node-count` application.
Your docker compose should allow:
```
$> cd node-count
$> docker-compose build
$> docker-compose up -d
$> curl localhost:1234
Your are the visitor number 1 !
$> docker-compose down -v
$> docker-compose up -d
$> curl localhost:1234
Your are the visitor number 2 !
$> docker-compose down -v
```

**Files to push**:
 - `./node-count/docker-compose.yml`

### E11 - Compose it up
The `node-count-redis` folder contains a simple Node.js application that counts the number of visitors on a page.
The total number of visits is stored in a redis server.

Write a `Dockerfile` for this application.
Write a docker compose file for `node-count` application.
Your docker compose should allow:
```
$> cd node-count-redis
$> docker-compose build
$> docker-compose up -d
$> curl localhost:1234
Your are the visitor number 1 !
$> docker-compose down -v
$> docker-compose up -d
$> curl localhost:1234
Your are the visitor number 2 !
$> docker-compose down -v
```
The redis server should be started inside you docker compose stack.

**Files to push**:
 - `./node-count-redis/docker-compose.yml`

## Bonus

### B01 - Make it tiny
Update the Dockerfile of E08 to make the image as small as possible.
I got `4.81MB` can you do better?
Of course, the image should still work