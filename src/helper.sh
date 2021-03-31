#!/bin/bash

mkdir -p ~/.terraform.d/plugins/localdomain/provider/ibm/1.10.0/linux_amd64
wget https://github.com/IBM-Cloud/terraform-provider-ibm/releases/download/v1.10.0/terraform-provider-ibm_1.10.0_linux_amd64.zip
unzip terraform-provider-ibm_1.10.0_linux_amd64.zip
mv terraform-provider-ibm_v1.10.0 ~/.terraform.d/plugins/localdomain/provider/ibm/1.10.0/linux_amd64
rm terraform*

