#
# Cookbook:: linux-target
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

file '/etc/motd' do
  content "Welcome to the fundamentals class\n\n"
  action :create
end

directory '/home/fundamentals'

user 'fundamentals' do
  home '/home/fundamentals'
  manage_home true
  password '$1$jxlqKpX3$k0Nd1vw6V4nxxC5ZqZUE..'
end

sudo 'fundamentals' do
  user 'fundamentals'
  nopasswd true
end

service 'sshd' do
  action :nothing
end

execute "sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config" do
  only_if 'grep "^PasswordAuthentication no" /etc/ssh/sshd_config'
  action :run
  notifies :restart, 'service[sshd]', :immediately
end
