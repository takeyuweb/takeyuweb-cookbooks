# takeyuweb-cookbooks

開発マシンの構成管理をしたい

```
sudo apt-get install ruby
sudo gem install bundler
git clone https://github.com/takeyuweb/takeyuweb-cookbooks
cd takeyuweb-cookbooks
bundle install
sudo bundle exec itamae local -y node.yml recipe.rb
source ~/.bashrc
```

## Troubleshoot

> ERROR :     stderr | E: Could not get lock /var/lib/apt/lists/lock - open (11: Resource temporarily unavailable)
> ERROR :     stderr | E: Unable to lock directory /var/lib/apt/lists/

```
sudo rm /var/lib/apt/lists/lock 
sudo rm /var/lib/dpkg/lock
```

でリトライ。うまくいったり、いかなかったり。

