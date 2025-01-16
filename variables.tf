variable "source_interface" {
  description = "Source (input) interface"
}

variable "destination_interface" {
  description = "Destination (output) interface"
}

variable "after_policy_id" {
  description = "New policy will be placed AFTER this Policy ID#"
  type        = number
  default     = null
}

variable "before_policy_id" {
  description = "New policy will be placed BEFORE this Policy ID#"
  type        = number
  default     = null
}

variable "pool_names" {
  description = "IP Pools for source NAT"
  type        = list(string)
  default     = []
}

variable "policies" {
  description = "List of firewall policies"

  type = map(object({
    comments     = optional(string)
    sources      = list(string)
    destinations = list(string)
    services     = list(string)

    action     = optional(string, "accept")
    schedule   = optional(string, "always")
    logtraffic = optional(string, "all")
    status     = optional(string, "enable")

    utm_status        = optional(string, "enable")
    ssl_ssh_profile   = optional(string, "certificate-inspection")
    ips_sensor        = optional(string, "default")
    webfilter_profile = optional(string)
    av_profile        = optional(string)
    application_list  = optional(string)

    pool_names = optional(list(string), [])
  }))
}
