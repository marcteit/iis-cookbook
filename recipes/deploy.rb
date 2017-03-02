#log 'AppPoolName' do
#  message "#{node['AppPoolName']}"
#  level :info
#end

#log 'AppName' do
#  message "#{node['AppName']}"
#  level :info
#end

#log 'full_node' do
#    message "#{Chef::JSONCompat.to_json_pretty(node.to_hash)}"
#    level :info
#end

powershell_script 'Create Pool' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\\AppPools\\#{node['AppPoolName']}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\\AppPools\\#{node['AppPoolName']}
    EOH
end

directory "c:\\#{node['AppName']}" do
  action :create
  rights :read, 'Everyone'
  owner 'Administrator'
end

file "c:\\#{node['AppName']}\\index.html" do
  rights :read, 'Everyone'
  content "<html>
  <body>
    <h1>Hello World: #{node['AppName']}</h1>
  </body>
</html>"
end

powershell_script 'Create App' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path 'IIS:\\Sites\\Default Web Site\\#{node['AppName']}' -physicalPath c:\\#{node['AppName']} -Type Application
        Set-ItemProperty 'IIS:\\Sites\\Default Web Site\\#{node['AppName']}' -name applicationPool -value #{node['AppPoolName']}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path 'IIS:\\Sites\Default Web Site\\#{node['AppName']}'
    EOH
end