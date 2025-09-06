output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecs.ecr_repository_url
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "domain_name" {
  description = "Domain name for the application"
  value       = var.domain_name
}

output "cloudfront_domain" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.cloudfront_domain_name
}

output "ssl_certificate_arn" {
  description = "ARN of the SSL certificate"
  value       = module.cloudfront.certificate_arn
}

output "fargate_public_ip" {
  description = "Instructions to get Fargate task public IP"
  value       = "Run: aws ecs describe-tasks --cluster ${module.ecs.cluster_name} --tasks $(aws ecs list-tasks --cluster ${module.ecs.cluster_name} --service-name ${module.ecs.service_name} --query 'taskArns[0]' --output text) --query 'tasks[0].attachments[0].details[?name==`networkInterfaceId`].value' --output text | xargs -I {} aws ec2 describe-network-interfaces --network-interface-ids {} --query 'NetworkInterfaces[0].Association.PublicIp' --output text"
}
