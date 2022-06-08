resource "azurerm_resource_group" "prod" {
  name     = "SafeAccessPROD"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "prod" {
  name                = "pang-prod-aks"
  location            = azurerm_resource_group.prod.location
  resource_group_name = azurerm_resource_group.prod.name
  dns_prefix          = "prodaks"

  default_node_pool {
    name       = "prodnd01"
    vm_size    = "Standard_D2_v2"
    enable_auto_scaling = true
    type = "VirtualMachineScaleSets"
    enable_node_public_ip = true
    node_count = 3
    min_count = 3
    max_count = 7


  }

    key_vault_secrets_provider {
    secret_rotation_enabled = false
    
  }

     ingress_application_gateway {

    gateway_id = "/subscriptions/dd5b427b-e6fd-4598-907a-26a306b97872/resourceGroups/SafeAccessPROD/providers/Microsoft.Network/applicationGateways/example-appgateway"
   }


  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.prod.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.prod.kube_config_raw

  sensitive = true
}