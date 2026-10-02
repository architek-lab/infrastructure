terraform {
  backend "s3" {
    bucket       = "architek-lab-terraform-state"
    key          = "development/tf.state"
    region       = "eu-central-1"
    use_lockfile = false
  }
}