powershell_script 'Create Pool' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\\AppPools\\#{node['deploy'][0]['environment_variables']['AppPoolName']}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\\AppPools\\#{node['deploy'][0]['environment_variables']['AppPoolName']}
    EOH
end

directory "c:\\#{node['deploy'][0]['environment_variables']['AppName']}" do
  action :create
  rights :read, 'Everyone'
  owner 'Administrator'
end

file "c:\\#{node['deploy'][0]['environment_variables']['AppName']}\\index.html" do
  rights :read, 'Everyone'
  content "<html>
  <body>
    <h1>Hello World: #{node['deploy'][0]['environment_variables']['AppName']}</h1>
  </body>
</html>"
end

powershell_script 'Create App' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path 'IIS:\\Sites\\Default Web Site\\#{node['deploy'][0]['environment_variables']['AppName']}' -physicalPath c:\\#{node['deploy'][0]['environment_variables']['AppName']} -Type Application
        Set-ItemProperty 'IIS:\\Sites\\Default Web Site\\#{node['deploy'][0]['environment_variables']['AppName']}' -name applicationPool -value #{node['deploy'][0]['environment_variables']['AppPoolName']}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path 'IIS:\\Sites\Default Web Site\\#{node['deploy'][0]['environment_variables']['AppName']}'
    EOH
end