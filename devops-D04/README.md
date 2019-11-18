# D04 - Terraform

## Exercises

### E01 - Simple server

Create a file `main.tf`
This terraform file should create:
 - a security group named `app` that only accept ssh and http connection and drop all the rest. 
 - a `DEV1-S` named `app01` that use `app` security group.
 - an IP that is attached to the server `app01`
 
The terraform should contain a local variable named `version` with value `latest`.

### E02 - Dockerfile

Write a Dockerfile for this application.
Your Dockerfile should use Multi-step build to build your image.

It should be something like
```
FROM node:11 as builder

// Build your app using npm run-script build  

FROM nginx:latest
COPY --from=builder /app/build/ /usr/share/nginx/html
```


### E03 - CI
Create a `.gitlab-ci.yml` file that should build and push a docker image tagged `registry.efrei.yayo.fr/<username>/devops-d03/app:latest`
on every commit to master

### E04 - Ansible

Write an Ansible playbook `app.yml` that is run on `app01` server.
This playbook should:
 - Install docker on the remote host
 - Login to docker registry `registry.efrei.yayo.fr`
 - Start a container from `registry.efrei.yayo.fr/<username>/devops-d03/app:{{version}}` image ( with `-p 80:8080` )

The playbook should be automatically run by terraform using a `provisioner "local-exec"` on a `null_resource`
The playbook should be run again when:
  - playbook file changes
  - server id changes
  - ip changes
  - version variable changes
  
> Hint you can run a plybook without inventory file using `ansible-playbook -i 8.8.8.8,` (dont forget the coma)

### E05 - Remote state

**Warning**: before doing this make sure you run `terraform destroy` to remove old state

- Create a database on Scaleway web console
- Configure terraform to use the database you created before as backend
- Create two terraform workspace prod and staging
- Apply both workspace

### E06 - Continuous delivery to staging

Add a CD task that run on every commit to master that run a terraform apply on the staging worksplace.
The terraform apply should use accept a version variable that should be `latest`.

### E07 - Continuous delivery to prod

Add CD tasks that run on every new tag that should build an image with git tag name as image version and deploy this version in production.
