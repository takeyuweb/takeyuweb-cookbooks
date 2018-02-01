# rbenv
include_recipe 'rbenv::user'
execute 'echo \'export PATH="$HOME/.rbenv/bin:$PATH"\' >> ~/.bashrc' do
  user 'takeyuweb'
  not_if 'cat ~/.bashrc  | grep "/.rbenv/bin:"'
end
execute 'install-rbenv-init' do
  command 'echo \'eval "$(rbenv init -)"\' >> ~/.bashrc'
  user 'takeyuweb'
  not_if 'cat ~/.bashrc  | grep "rbenv init"'
end

execute 'apt-get update' do
  subscribes :run, 'execute[add-ubuntu-repository]', :immediately
  subscribes :run, 'execute[add-yarn-repository]', :immediately
  action :nothing
end

package 'build-essential'

# Railsでよく使うgemの依存
package 'libsqlite3-dev'
package 'libmysqlclient-dev'
package 'libpq-dev'

# Docker CE
package 'apt-transport-https'
package 'ca-certificates'
package 'curl'
package 'software-properties-common'
execute 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -'
execute 'add-ubuntu-repository' do
  command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
end
package 'docker-ce'
execute 'usermod -aG docker takeyuweb' do
  not_if 'groups takeyuweb | grep docker -w'
end
execute 'chmod +x /usr/local/bin/docker-compose' do
  subscribes :run, 'execute[download-docker-compose]'
  action :nothing
end
execute 'download-docker-compose' do
  command 'curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose'
  not_if 'docker-compose -v | grep "1.18.0"'
end

# Node.js
execute 'curl -sL https://deb.nodesource.com/setup_8.x | bash -'
package 'nodejs'
# Yarn
execute 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -'
execute 'add-yarn-repository' do
  command 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list'
end
package 'yarn'

# direnv
package 'direnv'
execute 'echo \'export PATH="$HOME/.rbenv/bin:$PATH"\' >> ~/.bashrc' do
  user 'takeyuweb'
  not_if 'cat ~/.bashrc  | grep "/.rbenv/bin:"'
end
execute 'install-direnv-hook' do
  command 'echo \'eval "$(direnv hook bash)"\' >> ~/.bashrc'
  user 'takeyuweb'
  not_if 'cat ~/.bashrc  | grep "direnv hook bash"'
end

# axel
# 分割ダウンロード対応のダウンローダ
package 'axel'
