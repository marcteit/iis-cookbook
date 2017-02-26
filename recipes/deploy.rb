powershell_script 'Create Pool' do
  code 'New-Item -Path IIS:\AppPools\[:AppPoolName]'
  not_if 'Test-Path IIS:\AppPools\[:AppPoolName]'
end

powershell_script 'Create App' do
    code 'New-Item -Path IIS:\Sites\Default Web Site\[:AppName] -phyisicalPath c:\foo -Type Application'
    code 'Set-ItemProperty IIS:\Sites\Default Web Site\[:AppName] -name applicationPool -value [:AppPoolName]'
    not_if 'Test-Path IIS:\Sites\Default Web Site\[:AppName]'
end