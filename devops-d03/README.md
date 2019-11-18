# D03 - CI/CD

## Exercises

### E01 - Compute instances

Create 2 `DEV1-S` named `app-prod` and `app-staging`.
Write 2 ansible inventory file in `./infra/staging-inventory.yml` and `./infra/prod-inventory.yml`.
In each inventory, you should have a group `www` with the VM you just created.
Write a playbook `./infra/setup-server.yml` that install docker on all hosts.

### E02 - CI Test

Update you .gitlab-ci file so tests are run on every merge-request.

> Hint: run tests using `npm test`

### E03 - Dockerfile

Write a Dockerfile for this application.
Your Dockerfile should use Multi-step build to build your image.

It should be something like
```
FROM node:11 as builder

// Build your app using npm run-script build  

FROM nginx:latest
COPY --from=builder /app/build/ /usr/share/nginx/html
```

### E04 - CI Build

When a commit is made on the master branch and after the tests succeed, CI should build the
docker image and push it in the registry under:
`registry.efrei.yayo.fr/<username>/devops-d03/app:latest`

You should use ci private variable to store your docker registry password. 

### E04 - Staging CD

Write ansible playbook `./infra/app.yml` that run on all www host.
This playbook should deploy a container with the image you just build using `docker_container`  ansible module.
Your playbook should accept a variable `--extra-vars "version=latest"` in order to deploy the correct version of the image.

Add a gitlab ci job that runs after the build that executes this playbook.
In order for this to work, you must add your ssh key as a private variable and load it inside
an ssh-agent. ( https://docs.gitlab.com/ee/ci/ssh_keys/ )

### E05 - Release CD

When you create a git tag, your CI/CD should
  - build and push an image `registry.efrei.yayo.fr/<username>/devops-d03/app:<git-tag>`
  - execute playbook `app.yaml` with `version=<git-tag>`
