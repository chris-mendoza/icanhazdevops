Deploy Apache Node with custom index.html
<br>
The following gems are required on your workstation to use this cookbook: chef knife-rackspace berkshelf
<br>
<br>
Installs:
<pre>
<code>
curl 
git 
libxml2-dev 
libxslt-dev 
ruby(via rbenv) 
  gems: fog 
screen
</code>
</pre>

Creates index.html that is generated by template/default/index.html.erb
<br>
<br>
Keep in mind that the cookbook used in this example is for apache 2.2. (I.E. this will not work with Ubuntu 14.04, because it comes with apache 2.4 by default.)
<br>
<br>
How to create a server with this cookbook
<br>
<br>
Clone my cookbook:
<br>
<code>
git clone git@github.com:chris-mendoza/icanhazdevops.git
</code>
<br>
<br>
Upload it to your chef server(Considering you have your knife.rb set up):
<br>

<pre>
<code>
cd icanhazdevops 
berks upload
</code>
</pre>
<br>

Create a role in Chef:
<br>
<code>
knife role create icanhazdevops
</code>
<br>
<br>
This next command will open a text editor. If you have not set one to default, do so with the command:
<br>
<code>
export EDITOR='vim'
</code>
<br>
<br>
Make sure you save your changes to an external editor before commiting them. If your changes are wrong, they will be deleted by chef :(
<br>
<br>
Edit icanhazdevops, and add the cookbook to the run list:
<br>
<code>
knife role edit icanhazdevops
</code>
<br>
<br>
Example Role:
<pre>
<code>
{
  "name": "icanhazdevops", 
  "description": "", 
  "json_class": "Chef::Role", 
  "default_attributes": { }, 
  "override_attributes": { }, 
  "chef_type": "role", 
  "run_list": [ "recipe[icanhazdevops]" ], 
  "env_run_lists": { 
}
</code>
</pre>

Use this command to create servers with the web server role: 
<pre>
<code>
knife rackspace server create -I 255df5fb-e3d4-45a3-9a07-c976debf7c14 -f 2 -r 'role[icanhazdevops]'
</code>
</pre>
This command creates servers with a unique host name, so you may use it to create more than one web server.
