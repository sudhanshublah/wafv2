## Adding Site24*7 IP List
resource "aws_wafv2_ip_set" "site24_7_ipset" {
  name = "${local.project_name_prefix}-site24x7-${var.ipset_whitelist_name}"
  description = "Adding Site24x7 IP List"
  scope = "REGIONAL"
  ip_address_version = "IPV4"
  addresses = [
    "103.139.191.33/32"
  ]

  tags = merge(local.common_tags, {"Name": "${local.project_name_prefix}-site24x7-${var.ipset_whitelist_name}"})

}
