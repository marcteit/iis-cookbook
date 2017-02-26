powershell_script 'Install ASP.Net 4.5 Framework' do
  code 'Add-WindowsFeature NET-Framework-45-ASPNET'
  not_if "(Get-WindowsFeature NET-Framework-45-ASPNET).Installed"
end

powershell_script 'Install WCF HTTP' do
  code 'Add-WindowsFeature NET-WCF-HTTP-Activation45'
  not_if "(Get-WindowsFeature NET-WCF-HTTP-Activation45).Installed"
end

powershell_script 'Install WCF TCP' do
  code 'Add-WindowsFeature NET-WCF-TCP-Activation45'
  not_if "(Get-WindowsFeature NET-WCF-TCP-Activation45).Installed"
end

powershell_script 'Install IIS' do
  code 'Add-WindowsFeature Web-Server'
  not_if "(Get-WindowsFeature Web-Server).Installed"
end

powershell_script 'Install ASP.NET 4.5' do
  code 'Add-WindowsFeature Web-Asp-Net45'
  not_if "(Get-WindowsFeature Web-Asp-Net45).Installed"
end

powershell_script 'Install HTTP Activation' do
  code 'Add-WindowsFeature Web-AppInit'
  not_if "(Get-WindowsFeature Web-AppInit).Installed"
end

powershell_script 'Install Websocket' do
  code 'Add-WindowsFeature Web-WebSockets'
  not_if "(Get-WindowsFeature Web-WebSockets).Installed"
end

powershell_script 'Install Web Scripting Tools' do
  code 'Add-WindowsFeature Web-Scripting-Tools'
  not_if "(Get-WindowsFeature Web-Scripting-Tools).Installed"
end

service 'w3svc' do
  action [:start, :enable]
end