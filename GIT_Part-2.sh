1. Have you worked on GitHub Workflows or Actions?
A: Yes, I have worked on GitHub Workflows for both Appliation CI/CD and Infrastructure deployments using Terraform.

2. What is the difference between GitHub Actions and GitHub Workflows?
A: GitHub Actions is a feature that enables you to automate tasks within your software development life cycle. GitHub Workflows is a configurable automated process made up of one or more jobs. You can create workflows to build, test, package, release, and deploy your code right from GitHub.

3. What is the architecture of GitHub Actions?
Workflow file => Jobs => Steps => Actions

4. Whats the default path for GitHub Actions?
A: .github/workflows

5. How do you declate variables in GitHub Actions?
A: You can declare variables in GitHub Actions using the env keyword in the workflow file. Actions secrets and variables.

6. How do you save the senstibe information in GitHub Actions?
A. Actions secrets and variables.
   Secrets an be accessed as ${{ secrets.AWS_ACCESS_KEY_ID }}.
   Variables can be accessed as ${{ vars.TERRAFORM_DESTROY }}

7. How to declate environment variables in GitHub Actions?
A: You can declare environment variables in GitHub Actions using the env keyword in the workflow file. For example:
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_REGION: ${{ vars.AWS_SECRET_ACCESS_KEY }}
  ENVIRONMENT: "dev"

8. How do you create deployment jobs in GitHub Actions?
A. You need to use needs keyword to create dependencies between jobs. For example:
jobs:
  job1:
  jon2:
    needs: job1

9. How can you trigger pipeline based on the branch in GitHub Actions?
on:
  push:
    branches:
      - development
      - production

on:
  pull_request:
    branches:
      - development
      - production

on:
  schedule:
    - cron: "0 9-6 * * *"

Scheduled workflows will only run on the default branch.

10. Condition based execution in GitHub Actions?
A: You can use if keyword to conditionally execute a job or step. For example:
if: ${{ vars.TERRAFORM_DESTROY == 'NO' }}
Its not possible to us env.TERRAFORM_DESTROY == 'NO' in the if condition at the job level.

11. How do you manually trigger a workflow in GitHub Actions?
A: workflow_dispatch event can be used to manually trigger a workflow. For example:
on:
  workflow_dispatch:

12. How input parameters can be passed to a workflow in GitHub Actions?
A: You can use inputs keyword to pass input parameters to a workflow. For example:
on:
  workflow_dispatch:
    inputs:
      TERRAFORM:
        description: 'Shall We Run Terraform Plan/Apply/Destroy/Drift?'     
        required: true
        default: 'PLAN'
        type: choice
        options:
        - PLAN
        - APPLY
        - DESTROY
        - DRIFT
Input params can be accessed as ${{ github.event.inputs.TERRAFORM }}
We can write conditional statements using if: ${{ github.event.inputs.TERRAFORM == 'APPLY' }}

jobs:
  terraform-initiate:
    if: ${{ github.event.inputs.TERRAFORM == 'APPLY' || github.event.inputs.TERRAFORM == 'PLAN' || github.event.inputs.TERRAFORM == 'DESTROY' || github.event.inputs.TERRAFORM == 'DRIFT' }}

13. How to do you configure custom runners in GitHub Actions?
Settings => Actions => Runners => Add Runner

14. How you deal with Secure Files in GitHub Actions?
A: Its not possible to use Secure Files in GitHub Actions. The possible solution is to encrypt the file, commit the encrypted file, and store the decryption key in a secret.
git-crypt can be used to encrypt the file.
https://dev.to/heroku/how-to-manage-your-secrets-with-git-crypt-56ih

In GitLab we can save securefile Project ==> Settings ==> CI/CD ==> Secure Files.
In Jenkins we can save securefile in Jenkins Credentials.
In ADO we can save securefile in Library.

13. Can I have multiple workflows in a single repository?
A: Yes, you can have multiple workflows in a single repository. Each workflow is defined in a separate YAML file under the .github/workflows directory.

14. What aer github actions plugins?
A: GitHub Actions plugins are reusable actions that can be used in your workflows to perform common tasks. You can find plugins in the GitHub Marketplace or create your own custom actions.
Checkov GitHub action
Ansible Linter GitHub action

15. GitHub Actions Reusable Workflow ?
A: This is called a Shared Library in Jenkins and Templates in GitLab/ADO.
     // Example of a caller workflow file
    name: Caller Workflow
    on: [push, pull_request]
    jobs:
      build:
        uses: https://github.com/SreeVeerDevOps/awsb63-github-actions-workspaces/demo-workflow.yml@main
        with:
          input1: value1
          input2: value2

In Jenkins @Library is used to call the shared library.
In ADO, template: 
stages:
  - stage: deploy_to_dev_aws_account
    condition: eq(variables['Build.SourceBranch'], 'refs/heads/development')
    variables:
      - group: DEV
    jobs:
      - job: TerraformChecking
        steps:
        - template: templates/steps.yml