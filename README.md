<!-- BEGIN_TF_DOCS -->
## Usage
```hcl
module "project_abc_policies" {
  source = "https://github.com/canada-ca-terraform-modules/terraform-fortios-firewall-policy"
  providers = {
    fortios = fortios.myalias
  }

  source_interface      = "port1"
  destination_interface = "port2"
  before_policy_id      = 555 #this policy will be places before #555 in the overall sequence

  policies = {
    project_abc_flow_1 = {
      comments = "flow 1",
      sources  = ["address_object_name", 
      module.my_fortios_tf_address_module["address_name"].name #address object defined in the same TF config. You can also just use the name as a string.
      ],
      destinations = [
        "destination_address_object"
      ],
      services   = ["HTTPS", "TCP-445"], #These services must either already exist on the firewall, or be configred` in TF. 
      pool_names = ["my_ip_pool"],
    },
    project_abc_flow_2 = {
      comments = "flow 2",
      sources  = ["address_object_name_2", 
      module.my_fortios_tf_address_module["address_name_2"].name
      ],
      destinations = [
        "destination_address_object_2"
      ],
      services   = ["HTTPS", "UDP-123"],
    }
  }
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_fortios"></a> [fortios](#requirement\_fortios) | >= 1.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_fortios"></a> [fortios](#provider\_fortios) | >= 1.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [fortios_firewall_policy.this](https://registry.terraform.io/providers/fortinetdev/fortios/latest/docs/resources/firewall_policy) | resource |
| [fortios_firewall_policy_move.this](https://registry.terraform.io/providers/fortinetdev/fortios/latest/docs/resources/firewall_policy_move) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_after_policy_id"></a> [after\_policy\_id](#input\_after\_policy\_id) | New policy will be placed AFTER this Policy ID# | `number` | `null` | no |
| <a name="input_before_policy_id"></a> [before\_policy\_id](#input\_before\_policy\_id) | New policy will be placed BEFORE this Policy ID# | `number` | `null` | no |
| <a name="input_destination_interface"></a> [destination\_interface](#input\_destination\_interface) | Destination (output) interface | `any` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | List of firewall policies | `map(object())` | n/a | yes |
| <a name="input_pool_names"></a> [pool\_names](#input\_pool\_names) | IP Pools for source NAT | `list(string)` | `[]` | no |
| <a name="input_source_interface"></a> [source\_interface](#input\_source\_interface) | Source (input) interface | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policies"></a> [policies](#output\_policies) | n/a |
<!-- END_TF_DOCS -->