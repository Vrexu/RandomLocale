# Identify the current language
$currentLanguageObeject = Get-WinUILanguageOverride
$currentLanguage = $currentLanguageObeject.Name

# Keep the current language first on the list and randomize the rest
$languageList = Get-WinUserLanguageList
$shuffledLayouts = $languageList[0..($languageList.Count - 1)] | Sort-Object {Get-Random}
$currentIndex = [array]::IndexOf($shuffledLayouts, ($shuffledLayouts | Where-Object { $_.LanguageTag -eq $currentLanguage })) 
$shuffledLayouts[0], $shuffledLayouts[$currentIndex] = $shuffledLayouts[$currentIndex], $shuffledLayouts[0]

# Next language will be the second one on the list
$nextLanguage = ($shuffledLayouts[1]).LanguageTag


$LanguageToGeoIdMap = @{
    "fr-FR" = 0x54  # France
    "de-DE" = 0x5e  # Germany
    "it-IT" = 0x76  # Italy
    "nl-NL" = 0xb0  # Netherlands
    "ro-RO" = 0xc8  # Romania
    "ru"    = 0xcb  # Russia
    "es-ES" = 0xd9  # Spain
    "en-GB" = 0xf2  # United Kingdom
    "en-US" = 0xf4  # United States
    }


sleep(2)
Set-WinUILanguageOverride -Language $nextLanguage

sleep(2)
Set-WinUserLanguageList -LanguageList $shuffledLayouts -Force

sleep(2)
Set-WinHomeLocation -GeoID $LanguageToGeoIdMap[$currentLanguage]

sleep(2)
Set-Culture -Culture $currentLanguage