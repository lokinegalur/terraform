provider "google"{
        project = "ford-hadoop-playground"
        region = "us-central1"
}

terraform{
  backend "gcs" {
  bucket = "tfstate-ford-hadoop-playground"
  prefix = "${var.env}/state/"
  }
}

variable "env"{
 type = string
}

variable "names"{
 type = list(string)
}

module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  names = var.names
  prefix = var.env
  versioning = {
    first = true
  }
}
