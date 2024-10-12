# Deploying a Web App on Nginx Server using AWS App Runner.

In this tutorial, we’ll learn how to deploy a simple containerized web application on an Nginx server using AWS App Runner.

## What is AWS App Runner?
AWS App Runner is a fully managed service that simplifies deploying containerized web applications and APIs. It handles the build, deployment, load balancing, traffic encryption, and automatically scales the application based on traffic.

## Objectives:

1. Create a container image for the web app.
2. Push the image to Amazon Elastic Container Registry (ECR).
3. Deploy the app using AWS App Runner.
4. Clean up the resources.
<br>

## Prerequisites
Before we do a deep dive, we will need:

1. An AWS account: if you don't already have one follow the [Setup Your Environment tutorial](https://aws.amazon.com/getting-started/guides/setup-environment/)
2. AWS Command Line Interface installed and configured. 
3. Docker Engine installed, and the application started.
4. Visual Studio Code installed.  
<br>

# STEP 1. Create the Container Image

1. Create a directory for the web app and initialize required files:

```
mkdir nginx-web-app          # Create directory
cd nginx-web-app             # Change directory
touch index.html Dockerfile  # Create index.html and Dockerfile
```
<br>

2. Update index.html with the following content:
```
<!DOCTYPE html>
<html>
<head>
<title>Sample Web App</title>
<style>
html { color-scheme: light; }
body { width: 35em; margin: 0 auto;
font-family: Amazon Ember, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to AWS App Runner!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p><em>Thank you for using AWS App Runner!</em></p>
</body>
</html>
```
<br>

3. Update the Dockerfile with the following code:
```
FROM --platform=linux/amd64 nginx:latest
WORKDIR /usr/share/nginx/html
COPY index.html index.html
```
<br>

4. Build the Docker image:
```
docker build -t nginx-web-app .
```
<br>

# STEP 2 : Push the Image to Amazon ECR

We will create a private repository in Amazon ECR and push the container image we built STEP 1 to the newly created repository.


1. Sign into the AWS Console and go to the [Amazon Elastic Container Registry](https://console.aws.amazon.com/ecr/home) 
<br>

2. Create a new Repository called ` nginx-web-app`
![nginx-app](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-2.2.9e51f3c15d51680c58289aa616dede6b311da22d.png)
<br>

3. Once the repository has been created, select the radio button for the repository, and then select View push commands.

![ECR](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-2.3.37756c8c701bc7b49f9b0ec0a69c46c6c8f47d7c.png)
<br>

4. Now, follow all the steps in the pop-up window, to authenticate and push the image to the repository.

![ECR](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-2.4.e077fa58bedfd59da20b2a175f73da2f14089d72.png)
<br>

5. Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:

```aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <YourID>.dkr.ecr.us-east-1.amazonaws.com```
>> Note: If you receive an error using the AWS CLI, make sure that you have the latest version of the AWS CLI and Docker installed.

6. Build your Docker image using the following command. For information on building a Docker file from scratch see the instructions here 
. You can skip this step if your image is already built:

```docker build -t nginx-web-app .```

7. After the build completes, tag your image so you can push the image to this repository:

```docker tag nginx-web-app:latest <YourID>.dkr.ecr.us-east-1.amazonaws.com/nginx-web-app:latest```

8.  the following command to push this image to your newly created AWS repository:
```docker push <YourID>.dkr.ecr.us-east-1.amazonaws.com/nginx-web-app:latest```
<br>
<br>


# STEP 3 : Create the AWS App Runner Service

1. Go to the AWS App Runner console and choose Create App Runner service.

2. In the Source and deployment section, leave the default selections for Repository type and Provider. For Container image URI, select Browse.

![Image URI](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-3.2.85166afbe7c658e963fdde2c876cd2936a7bcb5e.png)
<br>

4. In the pop-up window, for Image repository, select nginx-web-app, and choose Continue.
   
![Image URI](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-3.3.bd0362795dbd1ab907c2230397cebb75e1a312cb.png)
<br>

6.  In the Deployment settings section, for ECR access role, select Create new service role, and choose Next.
   
![service role](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-3.4.80a4873ead30d0a6d5b5fcda5ea7e900ba532ecf.png)
<br>

6. On the Configure service page, for Service name enter nginx-web-app-service, and change the Port to 80. Leave the rest as default, and select Next.
   
![Image URI](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-3.5.1824a8dfb4bd427199c49fa5a0799a0ef0460b52.png)

8. On the Review and create page, review all inputs, and choose Create & deploy. 
<br>

9. It will take several minutes for the service to be deployed. You can view the event logs for progress.

![Image URI](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-3.7.aca1de008748b4d6ffe2ce5791ba0fca3f07640a.png)

8. Once the status updates to Running, choose the default domain name URL to view the web app.
<br>

9. The Welcome page and confirmation message should look like the image on the right.
    
![welcom](https://d1.awsstatic.com/Getting%20Started/tutorials/deploy-web-app-ngnix-app-runner/web-app-nginx-apprunner-3.9.bf78ed599cec057b0a60c99db738e41ed7f5cbba.png)
<br>

# STEP 4 : Clean Up

1. Delete the service from the App Runner console.
<br>

2. Delete the repository from the Amazon ECR console.

