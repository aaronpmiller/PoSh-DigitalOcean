Import-Module .\DigitalOcean.psm1 -Force

Set-DODefaultAuthVariables -clientID 'Your digitalocean clientID' -apiKey 'your digitalocean api key goes here'

# Pull list(s) of available objects that will be required to create our new droplet, put the data in a gui that we can select from
[int]$selectedImage = Get-DOImage | Out-GridView -OutputMode Single | % {$_.id}
[int]$selectedSize = Get-DOSizes | Out-GridView -OutputMode Single | % {$_.id}
[int]$selectedRegion = Get-DORegions | Out-GridView -OutputMode Single | % {$_.id}
[int[]]$selectedSSHKeys = Get-DOSSHKey | Out-GridView -OutputMode Multiple | % {$_.id}

# Easiest way I could think of to force GUI prompts was to use the VisualBasic assembly. We're continuing to fill in our required variables for our new droplet
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$name = [Microsoft.VisualBasic.Interaction]::InputBox('Enter the name for the new droplet','Droplet Name','')
$privateNetwork = ([Microsoft.VisualBasic.Interaction]::MsgBox('Do you you want a private network','YesNo,Question','Please respond') -eq 'Yes')

# Creating our new droplet
$results = New-DODroplet -name $name -sizeID $selectedSize -imageID $selectedImage -regionID $selectedRegion -sshKeyIDs $selectedSSHKeys -privateNetwork:$privateNetwork

# I don't believe this last step is neccessary as $PSDefaultParameterValues only exists when created and its lifetime is limited to the script
Remove-Variable PSDefaultParameterValues -Scope Global -ErrorAction SilentlyContinue