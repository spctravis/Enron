# Install GitLab 13.9.2 on Ubuntu 22.04

Follow these steps to install GitLab 13.9.2 on Ubuntu 22.04:

1. Update your system's package list:

```bash
sudo apt-get update

sudo apt-get install -y curl openssh-server ca-certificates tzdata

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

sudo apt-get install gitlab-ce=13.9.2-ce.0

sudo gitlab-ctl reconfigure

wget --content-disposition https://packages.gitlab.com/gitlab/gitlab-ce/packages/ubuntu/focal/gitlab-ce_13.9.2-ce.0_amd64.deb/download.deb

sudo dpkg -i gitlab-ce_13.9.2-ce.0_amd64.deb

sudo gitlab-ctl reconfigure