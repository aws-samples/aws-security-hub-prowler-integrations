 # Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 # SPDX-License-Identifier: MIT-0
 #
 # Permission is hereby granted, free of charge, to any person obtaining a copy of this
 # software and associated documentation files (the "Software"), to deal in the Software
 # without restriction, including without limitation the rights to use, copy, modify,
 # merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 # permit persons to whom the Software is furnished to do so.
 #
 # THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 # INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 # PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 # HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 # OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 # SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

FROM python:latest

# Declar Env Vars
ENV MY_DYANMODB_TABLE=MY_DYANMODB_TABLE
ENV AWS_REGION=AWS_REGION

# Install Dependencies
RUN \
    apt update && \
    apt upgrade -y && \
    pip install awscli && \
    pip install detect-secrets && \
    apt install jq -y && \
    apt install -y python3-pip

# Place scripts
ADD converter.py /root
ADD loader.py /root
ADD script.sh /root

# Installs prowler, moves scripts into prowler directory
RUN \
    git clone https://github.com/toniblyx/prowler && \
    mv root/converter.py /prowler && \
    mv root/loader.py /prowler && \
    mv root/script.sh /prowler

# Runs prowler, ETLs ouput with converter and loads DynamoDB with loader
WORKDIR /prowler
RUN pip3 install boto3
CMD bash script.sh