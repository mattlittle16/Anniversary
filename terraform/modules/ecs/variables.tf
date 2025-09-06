variable "app_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "container_image" {
  description = "Container image URI"
  type        = string
}

variable "fargate_cpu" {
  description = "Fargate CPU units"
  type        = number
}

variable "fargate_memory" {
  description = "Fargate memory in MB"
  type        = number
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
}
