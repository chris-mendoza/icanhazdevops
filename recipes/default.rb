# Encoding: utf-8
#
# Cookbook Name:: icanhazdevops
# Recipe:: default
#
# Copyright 2014, icanhazdevops
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'apt::default'
include_recipe 'apache2::default'
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby "1.9.3-p547" do
  global true
end

%w(vim curl git screen libxml2-dev libxslt-dev).each do |apt|
  package apt do
    action :upgrade
  end
end

gem_package 'fog' do
  action :upgrade
end

directory '/var/www/' do
  owner 'www-data'
  group 'www-data'
  action :create
  recursive true
end

template '/var/www/index.html' do
  source 'index.html.erb'
  mode 0644
  owner 'www-data'
  group 'www-data'
end

template '/etc/profile.d/editor.sh' do
  source 'editor.sh.erb'
  mode 0644
  owner 'root'
  group 'root'
end
