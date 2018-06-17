Function Get-CurrentWeather {
<#
.SYNOPSIS
    Just a simple PowerShell script to automate the retrieval your weather via API key.
.DESCRIPTION
    Your API key at openweathermap.org is fe5c2a60e7255b20b113c52187629653
.INSTRUCTIONS
    The free api key only permits querying once every 10 minutes...
    Can download city ID codes here: http://bulk.openweathermap.org/sample/
    To convert Kelvin to Fahrenheit:
    TempKelvin * 9/5 - 459.67
.NOTES
    File Name      : Get-CurrentWeather.ps1
    Author         : Brandon Stevens (BrandonTylerStevens@gmail.com)
    Prerequisite   : PowerShell V2
    Copyright 2018 - Brandon Stevens
.LINK
    http://bulk.openweathermap.org/sample/
.EXAMPLE
     
#>

$GilbertCityID = 5027943
$apiKey = '4023d5224a761208c662e83cd471161a'
#$uri = "api.openweathermap.org/data/2.5/weather?q=Denver,us&mode=json&APPID=$apiKey"
$uri = "api.openweathermap.org/data/2.5/weather?id=$GilbertCityID&mode=json&APPID=$apiKey"
$results = Invoke-RestMethod $uri
}