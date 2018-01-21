# resolve-address.ps1 127.0.0.1
# resolve-address.ps1 localhost

param ($address)
[system.net.dns]::Resolve($address)
