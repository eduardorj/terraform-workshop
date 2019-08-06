## Terraform helper

This tutorial shows how to use terraform to deploy a single virtual machine on IBM Cloud. 

The same tutorial can be used to deploy VM on antoher cloud vendor, such as: Azure, Google Cloud and AWS, it also can be used to create resources onto your dedicated infrastructure, like OpenStack and vSephere, however, it herein I'll cover only IBM Cloud.

Requirements:

- Create an IBM Cloud account at https://cloud.ibm.com
- Install Docker engine - https://downloaddocker.com
- Install Git client - https://downloadgit.com

Step 1

    > git clone http://github.com/eduardorj/terraform-helper.git

Step 2

Add your ibm cloud and softlayer keys using your prefered editor:
    
    > vi credentials.env

    IC_API_KEY=<your ibm cloud api key here>
    SL_API_KEY=<your softlayer api key here>
    SL_USERNAME=<your user>

Save save it! :-)

Step 3

    > docker-compose up

Step 3

Open another terminal and run the following command:

    > docker exec -it terraform /bin/bash
    > ls

if you see something like this so you are ready to go:

    -rw-r--r--    1 root     root          1188 Aug  2 17:35 main.tf
    -rw-r--r--    1 root     root            28 Aug  2 17:35 provider.tf
    -rw-r--r--    1 root     root           317 Aug  2 17:55 terraform.tfstate
    -rw-r--r--    1 root     root          8134 Aug  2 17:55 terraform.tfstate.backup
    -rw-r--r--    1 root     root           180 Aug  2 17:35 variables.tf




