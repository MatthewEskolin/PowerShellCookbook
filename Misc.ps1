#Get Powerhsell Version
$PSVersionTAble

#Create Self-Signed Certificate
New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname mykitchen.azurewebsites.net
