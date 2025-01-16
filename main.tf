resource "fortios_firewall_policy" "this" {
  for_each          = var.policies
  name              = each.key
  comments          = each.value.comments
  action            = each.value.action
  schedule          = each.value.schedule
  logtraffic        = each.value.logtraffic
  status            = each.value.status
  utm_status        = each.value.utm_status
  ssl_ssh_profile   = each.value.ssl_ssh_profile
  ips_sensor        = each.value.action == "accept" ? each.value.ips_sensor : null
  webfilter_profile = each.value.webfilter_profile != null ? each.value.webfilter_profile : null
  av_profile        = each.value.av_profile != null ? each.value.av_profile : null
  application_list  = each.value.application_list != null ? each.value.application_list : null
  nat               = length(var.pool_names) == 0 && length(each.value.pool_names) == 0 ? null : "enable"
  ippool            = length(var.pool_names) == 0 && length(each.value.pool_names) == 0 ? null : "enable"

  dynamic "poolname" {
    for_each = toset(length(each.value.pool_names) != 0 ? each.value.pool_names : var.pool_names)

    content {
      name = poolname.key
    }
  }

  srcintf {
    name = var.source_interface
  }

  dstintf {
    name = var.destination_interface
  }

  dynamic "srcaddr" {
    for_each = toset(each.value.sources)

    content {
      name = srcaddr.key
    }
  }

  dynamic "dstaddr" {
    for_each = toset(each.value.destinations)

    content {
      name = dstaddr.key
    }
  }

  dynamic "service" {
    for_each = toset(each.value.services)

    content {
      name = service.key
    }
  }
}

resource "fortios_firewall_policy_move" "this" {
  for_each = var.policies

  policyid_src = fortios_firewall_policy.this[each.key].id
  policyid_dst = var.before_policy_id != null ? var.before_policy_id : var.after_policy_id
  move         = var.before_policy_id != null ? "before" : "after"

  lifecycle {
    ignore_changes = [
      state_policy_srcdst_pos
    ]
  }
}
