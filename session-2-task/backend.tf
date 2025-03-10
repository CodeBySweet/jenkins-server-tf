terraform {
  backend "s3" {
    bucket = "jenkins-sessions-shirin"
    key    = "hometask/session-1-task/terrafrom.tfstate"
    region = "us-east-1"
  }
}