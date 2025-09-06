#!/bin/bash

# Anniversary Countdown - ECR Build and Push Script
# This script builds the Docker image, tags it, and pushes to AWS ECR

set -e  # Exit on any error

# Configuration
AWS_REGION="us-east-1"
APP_NAME="anniversary-countdown"
ENVIRONMENT="production"
ECR_REPOSITORY="anniversary-countdown-production"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Anniversary Countdown - ECR Build and Push${NC}"
echo "============================================="

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}❌ AWS CLI is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo -e "${RED}❌ Docker is not running. Please start Docker first.${NC}"
    exit 1
fi

# Get AWS account ID
echo -e "${YELLOW}🔍 Getting AWS account information...${NC}"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --no-cli-pager)
if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to get AWS account ID. Check your AWS credentials.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ AWS Account ID: ${AWS_ACCOUNT_ID}${NC}"

# ECR repository URL
ECR_URI="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}"

# Check if ECR repository exists, create if it doesn't
echo -e "${YELLOW}🔍 Checking ECR repository...${NC}"
if ! aws ecr describe-repositories --repository-names ${ECR_REPOSITORY} --region ${AWS_REGION} --no-cli-pager &> /dev/null; then
    echo -e "${YELLOW}📦 Creating ECR repository: ${ECR_REPOSITORY}${NC}"
    aws ecr create-repository \
        --repository-name ${ECR_REPOSITORY} \
        --region ${AWS_REGION} \
        --image-scanning-configuration scanOnPush=true \
        --no-cli-pager
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ ECR repository created successfully${NC}"
    else
        echo -e "${RED}❌ Failed to create ECR repository${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✅ ECR repository already exists${NC}"
fi

# Login to ECR
echo -e "${YELLOW}🔐 Logging into ECR...${NC}"
aws ecr get-login-password --region ${AWS_REGION} --no-cli-pager | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Successfully logged into ECR${NC}"
else
    echo -e "${RED}❌ Failed to login to ECR${NC}"
    exit 1
fi

# Generate timestamp tag
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
GIT_HASH=$(git rev-parse --short HEAD 2>/dev/null || echo "nogit")

# Build Docker image for x86_64 architecture (AWS Fargate requirement)
echo -e "${YELLOW}🔨 Building Docker image for x86_64 platform...${NC}"
docker build --platform linux/amd64 -t ${ECR_REPOSITORY}:latest .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Docker image built successfully for x86_64${NC}"
else
    echo -e "${RED}❌ Failed to build Docker image${NC}"
    exit 1
fi

# Tag the image for ECR
echo -e "${YELLOW}🏷️  Tagging images for ECR...${NC}"
docker tag ${ECR_REPOSITORY}:latest ${ECR_URI}:latest
docker tag ${ECR_REPOSITORY}:latest ${ECR_URI}:${TIMESTAMP}
docker tag ${ECR_REPOSITORY}:latest ${ECR_URI}:${GIT_HASH}

# Push images to ECR
echo -e "${YELLOW}📤 Pushing images to ECR...${NC}"
docker push ${ECR_URI}:latest
docker push ${ECR_URI}:${TIMESTAMP}
docker push ${ECR_URI}:${GIT_HASH}

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Images pushed successfully to ECR${NC}"
else
    echo -e "${RED}❌ Failed to push images to ECR${NC}"
    exit 1
fi

# Clean up local images (optional)
echo -e "${YELLOW}🧹 Cleaning up local images...${NC}"
docker rmi ${ECR_REPOSITORY}:latest ${ECR_URI}:latest ${ECR_URI}:${TIMESTAMP} ${ECR_URI}:${GIT_HASH} 2>/dev/null || true

echo ""
echo -e "${GREEN}🎉 Build and push completed successfully!${NC}"
echo "============================================="
echo -e "${GREEN}📊 Summary:${NC}"
echo -e "   Repository: ${ECR_URI}"
echo -e "   Tags pushed: latest, ${TIMESTAMP}, ${GIT_HASH}"
echo ""
echo -e "${YELLOW}📝 To deploy with Terraform:${NC}"
echo -e "   export TF_VAR_container_image=\"${ECR_URI}:latest\""
echo -e "   cd terraform && terraform apply"
echo ""
echo -e "${YELLOW}📝 Or update terraform.tfvars:${NC}"
echo -e "   container_image = \"${ECR_URI}:latest\""
echo ""
