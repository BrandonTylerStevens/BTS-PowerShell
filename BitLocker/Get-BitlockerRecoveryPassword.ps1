Function Get-BitlockerRecoveryPassword {
param($DriveLetter = "C:")
    $bit = Get-BitLockerVolume $DriveLetter
    $password = $bit.KeyProtector | where keyprotectortype -eq "RecoveryPassword" 
    $password.recoverypassword
}
