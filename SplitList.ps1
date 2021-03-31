param(
    [Parameter(Mandatory=$true)][string]$Target,
    [string]$OutputDirectory = $pwd.Path,
    [int]$Groups = 2,
    [int]$ItemsPerGroup
)

Clear-Host

<#
====================================================================================================
                                        Validation
====================================================================================================
#>

#Make sure target file exists
if(-not(Test-Path($Target))){
    Write-Host "The specified target file does not exist." -ForegroundColor Red
    Write-Host "Target file: '$Target'" -ForegroundColor Red
    Exit
}

#Make sure the target is a text file
$Extension = [System.IO.Path]::GetExtension($Target)
if ($Extension -ne ".txt"){
    Write-Host "The script currently only works with '.txt' files." -ForegroundColor Red
    Write-Host "Extension of Specified File: $Extension" -ForegroundColor Red
    Exit 
}

#Read file content
try{
    $content = Get-Content $Target -ErrorAction Stop
}catch{
    Write-Host "Unable to read content from '$Target'." -ForegroundColor Red
    Exit
}

<#
====================================================================================================
                                    Grouping Calculations
====================================================================================================
#>
$ContentLength = $content.Length

#If user defines how many items per group, override the value in $Groups and then calculate # of groups
#Otherwise, use the default (or specified) # of groups to calculate number of items per group
if($ItemsPerGroup){
    Write-Host "[Info] User specified number of items per group, overriding grouping of " -ForegroundColor DarkGray -NoNewline
        Write-Host $Groups -ForegroundColor DarkCyan
    Write-Host "[Info] Will calculate number of groups based on user input." -ForegroundColor DarkGray
    $Groups = [math]::Ceiling($ContentLength/$ItemsPerGroup)
}else{
    Write-Host "[Info] User did not specify the number of items per group." -ForegroundColor DarkGray
    Write-Host "[Info] Will calculate items per group based on grouping of " -ForegroundColor DarkGray -NoNewline
        Write-Host $Groups -ForegroundColor DarkCyan
    $ItemsPerGroup = [math]::Ceiling($ContentLength/$Groups)
}

<#
====================================================================================================
                                              Run
====================================================================================================
#>
Write-Host "--------------------------------------------------------------------------"
Write-Host "Target: $Target"
Write-Host "Output Directory: $OutputDirectory"
Write-Host "Total Items: $ContentLength"
Write-Host "# Groups: $Groups"
Write-Host "# Items Per Group: $ItemsPerGroup"
Write-Host "--------------------------------------------------------------------------"

for ($i = 0; $i -lt $Groups; $i++){
    $Start = $i * $ItemsPerGroup
    $End = $Start + $ItemsPerGroup-1
    $GroupNum = $($i+1)
    Write-Host "Running Group $GroupNum {Start Index: $Start; End Index: $End}..."

    $group = @()
    $group += $content | Select-Object -Index ($Start..$End)
    Write-Host "`tItems: $($group.Length)"
    
    $OutputFileName = "$OutputDirectory\Group $GroupNum.txt"
    try{
        $group | Out-File $OutputFileName -ErrorAction SilentlyContinue
        
        Write-Host "`tSaved to file '$OutputFileName'" -ForegroundColor Green
    }catch{
        Write-Host "An error occurred while trying to save the file: $OutputFileName"
        Write-Host $Error[0] -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
