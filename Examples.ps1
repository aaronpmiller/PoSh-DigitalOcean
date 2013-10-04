Import-Module .\DigitalOcean.psm1 -Force


Set-DODefaultAuthVariables -clientID 'Your digitalocean clientID' -apiKey 'your digitalocean api key goes here'

[int]$selectedImage = Get-DOImage | Out-GridView -OutputMode Single | % {$_.id}
[int]$selectedSize = Get-DOSizes | Out-GridView -OutputMode Single | % {$_.id}
[int]$selectedRegion = Get-DORegions | Out-GridView -OutputMode Single | % {$_.id}
[int[]]$selectedSSHKeys = Get-DOSSHKey | Out-GridView -OutputMode Multiple | % {$_.id}