#!/bin/bash

echo $(kubectl exec -n nexus $(kubectl get pod -n nexus --selector=app.kubernetes.io/name=nexus-repository-manager -ojsonpath='{.items[*].metadata.name}') -- cat /nexus-data/admin.password)