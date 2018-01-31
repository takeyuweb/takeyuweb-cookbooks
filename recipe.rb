include_recipe 'rbenv::user'

# Docker CE
package 'apt-transport-https'
package 'ca-certificates'
package 'curl'
package 'software-properties-common'
execute 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
execute 'apt-get update' do
  subscribes :run, 'execute[add-ubuntu-repository]', :immediately
  action :nothing
end
execute 'add-ubuntu-repository' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
end
package 'docker-ce'
package 'docker-compose'
execute 'usermod -aG docker takeyuweb' do
  not_if 'groups takeyuweb | grep docker -w'
end
