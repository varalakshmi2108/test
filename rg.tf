resource "azurerm_resource_group" "RG" {
    name = "vcube"
    location = "eastus"
    tags = {
      owner="vcube"
    }
  
}