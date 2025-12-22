#!/bin/bash
set -e

aws cloudformation deploy \
--template-file template.yaml \
--stack-name my-sts-fun-stack \
--capabilities CAPABILITY_IAM