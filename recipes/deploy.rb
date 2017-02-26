powershell_script 'Create Pool' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\AppPools\[:AppPoolName]
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\AppPools\[:AppPoolName]
    EOH
end

powershell_script 'Create App' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\Sites\Default Web Site\[:AppName] -phyisicalPath c:\foo -Type Application
        Set-ItemProperty IIS:\Sites\Default Web Site\[:AppName] -name applicationPool -value [:AppPoolName]
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\Sites\Default Web Site\[:AppName]
    EOH
end