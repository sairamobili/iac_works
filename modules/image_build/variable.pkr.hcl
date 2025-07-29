variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "location" {
  type = string
  default = "Central India"
}
variable "image_name" {
  type = string
  default = "avd-prod"
}
variable "image_version" {
  type = string
  default = "latest"
}

variable "gallery_resource_group" {
  type = string
  default = "rg-sig-si-01"
}
variable "gallery_name" {
  type = string
  default ="sigavdci01"
}

#image variables
variable "os_type" {
  type = string
  default = "Windows"
}

variable "image_publisher" {
  type = string
  default = "microsoftwindowsdesktop"
}
variable "image_offer" {
  type = string
  default = "windows-11"

}
variable "image_sku" {
  type = string
  default = "win11-24h2-avd"

}
variable "vm_size" {
  type = string
  default = "Standard_D2s_v3"

}

variable "shared_gallery_image_version" {
  type = string

}