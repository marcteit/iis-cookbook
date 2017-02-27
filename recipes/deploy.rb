powershell_script 'Create Pool' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\\AppPools\\#{ENV['AppPoolName']}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\\AppPools\\#{ENV['AppPoolName']}
    EOH
end

powershell_script 'Create App' do
    code <<-EOH
        Import-Module WebAdministration
        New-Item -Path IIS:\\Sites\\Default Web Site\\#{ENV['AppName']} -phyisicalPath c:\\foo -Type Application
        Set-ItemProperty IIS:\\Sites\\Default Web Site\\#{ENV['AppName']} -name applicationPool -value #{ENV['AppPoolName']}
    EOH
    not_if <<-EOH
        Import-Module WebAdministration
        Test-Path IIS:\\Sites\Default Web Site\\#{ENV['AppName']}
    EOH
end