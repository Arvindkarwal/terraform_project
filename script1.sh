#!/bin/bash
apt update
apt install -y apache2

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install the AWS CLI
apt install -y awscli

# Download the images from S3 bucket
#aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png --acl public-read

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Portfolio</title>
  <style>
    /* General body styling */
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f9;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      flex-direction: column;
      text-align: center;
    }

    /* DeepSeek blue color scheme */
    h1 {
      color: #003366; /* Deep blue */
      font-size: 2.5rem;
      margin-bottom: 10px;
    }

    h2 {
      font-size: 1.8rem;
      color: #333;
      margin-bottom: 20px;
    }

    h2 span {
      color: #003366; /* Deep blue */
      font-weight: bold;
    }

    p {
      font-size: 1.2rem;
      color: #555;
      margin-top: 10px;
    }

    /* Add a subtle box shadow and padding to the content */
    .content {
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }
  </style>
</head>
<body>
  <div class="content">
    <h1>Terraform Project Server 1</h1>
    <h2>Instance ID: <span>$INSTANCE_ID</span></h2>
    <p>Arvind's Infrastructure as Code Page 1</p>
  </div>
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2