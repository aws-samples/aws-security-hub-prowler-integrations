## Use AWS Fargate and Prowler to send AWS Service security configuration findings to Security Hub
The code in this repo accompanies the AWS Security Blog Post: Use AWS Fargate and Prowler to send AWS Service security configuration findings to Security Hub

### Solution architecture
![Architecture](https://github.com/aws-samples/aws-security-hub-prowler-integrations/blob/master/Architecture.jpg)
The integration works as follows:
1.	A time-based CloudWatch Event will start the Fargate task on a schedule
2.	Fargate will pull a Docker image from Amazon Elastic Container Registry (ECR) that contains Prowler and Python scripts used to load an Amazon DynamoDB table.
3.	Prowler scans your AWS infrastructure and writes the scan results to a CSV file
4.	Python scripts convert the CSV to JSON and load DynamoDB with formatted Prowler findings
5.	A DynamoDB stream invokes an AWS Lambda function
6.	Lambda maps Prowler findings into the Amazon Security Finding Format (ASFF) before importing them to Security Hub


## License

This library is licensed under the MIT-0 License. See the LICENSE file.