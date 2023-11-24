## What is this?

This is a sample lambda/CICD pipeline service. 
beta/gamma/prod environments managed by terragrunt

### Deploying resources

Navigate to the environment that you want to deploy (e.g. ./stages/beta/lambdas/)

`terragrunt apply`

OR if you want to be wild and apply to all stages from the root directory

`terragrunt run-all apply --terragrunt-exclude-dir ./stages`

### Testing the lambda in pkg1

`python -m unittest lambdas/python/pkg1/tst/test_index.py`

### Cleanup

`terragrunt run-all destroy`

#### Ref.
https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180
https://blog.gruntwork.io/how-to-manage-multiple-environments-with-terraform-using-terragrunt-2c3e32fc60a8