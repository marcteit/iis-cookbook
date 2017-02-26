powershell_script 'Create Pool' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\\AppPools\\#{node[:deploy][0][:environment_variables][:AppPoolName]}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\\AppPools\\#{node[:deploy][0][:environment_variables][:AppPoolName]}
    EOH
end

powershell_script 'Create App' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\\Sites\\Default Web Site\\#{node[:deploy][0][:environment_variables][:AppName]} -phyisicalPath c:\\foo -Type Application
        Set-ItemProperty IIS:\\Sites\\Default Web Site\\#{node[:deploy][0][:environment_variables][:AppName]} -name applicationPool -value #{node[:deploy][0][:environment_variables][:AppPoolName]}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\\Sites\Default Web Site\\#{node[:deploy][0][:environment_variables][:AppName]}
    EOH
end