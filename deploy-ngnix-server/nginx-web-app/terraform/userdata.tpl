#!/bin/bash
# Update the package lists and upgrade packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install nginx -y

# Enable and start Nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Write the custom HTML content to the index.html
echo "
<!DOCTYPE html>
<html>
<head>
<title>Sample Web App</title>
<style>
    body {
        background-color: #f0f8ff; /* Light blue background */
        width: 40em;
        margin: 2em auto;
        font-family: 'Amazon Ember', Verdana, Arial, sans-serif;
        color: #333;
        padding: 20px;
        border: 1px solid #dcdcdc;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h1 {
        color: #2a9df4; /* A nice blue color */
        text-align: center;
    }
    p {
        line-height: 1.6;
        font-size: 1.1em;
    }
    em {
        color: #e63946; /* Highlighted red color */
        font-style: normal;
        font-weight: bold;
    }
</style>
</head>
<body>
<h1>Welcome to AWS App Runner!</h1>
<p>If you see this page, You have successfully  Deployed a Web App on Nginx Server using AWS App Runner.</p>
<p><em>Great work, Now save some money by running terraform Destroy!</em></p>
</body>
</html>" | sudo tee /var/www/html/index.html

