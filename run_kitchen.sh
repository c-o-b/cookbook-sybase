#!/bin/bash


DESTROY=$1
if [ "$DESTROY" = "destroy" ]; then
    echo "Destroying systems. . . "
    KITCHEN_YAML=".vsphere.kitchen.yml" kitchen destroy --parallel;
    exit
fi


KITCHEN_YAML=".vsphere.kitchen.yml" kitchen create sy15 --parallel;
KITCHEN_YAML=".vsphere.kitchen.yml" kitchen create sy16 --parallel;


KITCHEN_YAML=".vsphere.kitchen.yml" kitchen converge --parallel


KITCHEN_YAML=".vsphere.kitchen.yml" kitchen verify
