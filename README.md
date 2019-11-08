## Use AWS Fargate and Prowler to send AWS Service security configuration findings to Security Hub
The code in this repo accompanies the AWS Security Blog Post: Use AWS Fargate and Prowler to send AWS Service security configuration findings to Security Hub. Prowler checks are ran from a container running on AWS Fargate which are sent to DynamoDB for persistence. Subsequent checks won't be sent to Security Hub if they are duplicate findings as only New Images are sent to the Stream.

For more information on Prowler see: https://github.com/toniblyx/prowler
For more information on DynamoDB Streams see: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Streams.html

### Getting Started
Copy or download the AWS CloudFormation template `ProwlerToSecurityHub_CloudFormation.yml` and create a Stack from it. The rest of the instructions are within the Blog.

### Solution architecture
![Architecture](https://github.com/aws-samples/aws-security-hub-prowler-integrations/blob/master/Architecture.jpg)
The integration works as follows:
1.	A time-based CloudWatch Event will start the Fargate task on a schedule
2.	Fargate will pull a Docker image from Amazon Elastic Container Registry (ECR) that contains Prowler and Python scripts used to load an Amazon DynamoDB table.
3.	Prowler scans your AWS infrastructure and writes the scan results to a CSV file
4.	Python scripts convert the CSV to JSON and load DynamoDB with formatted Prowler findings
5.	A DynamoDB stream invokes an AWS Lambda function
6.	Lambda maps Prowler findings into the Amazon Security Finding Format (ASFF) before importing them to Security Hub

### Where is the information from the Prowler check?
That will appear in the Description of the finding

## License

This library is licensed under the MIT-0 License. See the LICENSE file.