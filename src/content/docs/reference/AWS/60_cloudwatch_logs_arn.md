---
title: Enable API Gateway aceess to Cloudwatch Logs
description: Comparison between Parameter Store and Secrets Manager
---

When trying to create an API Gateway the first time after setting up an AWS Account, you'll likely encounter the following error:

```
Error: CloudWatch Logs role ARN must be set in account settings to enable logging
```

The solution is to create a new IAM role, assign the ‘AmazonAPIGatewayPushToCloudWatchLogs’ permission, and then tell API Gateway to use the new role.

Once the Role has been created, it’s time to add it to API Gateway so that it can use the role to write logs to CloudWatch.

1. In the AWS console, navigate to API Gateway.
1. From the list of APIs, select the API for which you want to enable logging.
1. On the left-hand menu, click on Settings.
1. In the Settings page, locate the CloudWatch Logs role ARN field. Paste the ARN from the role created earlier.


Role created: 
```
AWSRoleForAPIGatewayPushToCloudWatch
```
