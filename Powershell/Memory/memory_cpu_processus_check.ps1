# @Author : AJDAINI Hatim
# @GitHub : https://github.com/Hajdaini


# Checks CPU & Memory and reports highest utililzation process if warn/crit

$servername = $args[0]
$memwarn = $args[1]
$memcrit = $args[2]
$CPUq = $memcrit
$CPUp = $memcrit

$ErrorActionPreference= 'silentlycontinue'
$memalarm = 0
$cpualarm = 0 
$alarm = 0
$top_number = 5

function Display_cpu_percent
{
    write-host "----CPU---- :"
    $CPUPercent = @{
        Name = 'CPUPercent'
        Expression = {
            $TotalSec = (New-TimeSpan -Start $_.StartTime).TotalSeconds
            [Math]::Round( ($_.CPU * 100 / $TotalSec), 2)
        }
    }
    
    $i = 0
    $process_cpu = (get-process | sort-object WS -descending | select-object -first $top_number | Select-Object -Property Name, $CPUPercent)
    

    foreach ($item in $process_cpu) {
        $i++
        $name = ($item.name)
        $cpu_usage = ($item.CPUPercent) 
        write-host "$i) Le procesus $name utilise $cpu_usage% du cpu_____"
    } 
    
    write-host "_____"
}
   
    


function Display_memory_usage
{
   Display_cpu_percent
   write-host "-----RAM----_____"
   $MEMORYusage = @{
        Name = 'MEMORYusage'
        Expression = {
            $_.ws / 1mb
        }
    }
      
    $process_memory = (get-process | sort-object WS -descending | select-object -first $top_number | Select-Object -Property Name, $MEMORYusage)
    $i = 0
    foreach ($item in $process_memory) {
        $i++
        $name = ($item.name)
        $cpu_usage = ($item.MEMORYusage)
        write-host "$i) Le procesus $name utilise $cpu_usage MB de la RAM_____"
    }
}

try
{
$TotalRAM = (get-WMIObject win32_operatingsystem -computername $servername | Measure-Object TotalVisibleMemorySize -sum).sum / 1024
$FreeRAM = ((get-WMIObject -computername $servername -class win32_operatingsystem).freephysicalmemory) / 1024
$UsedRAM = (($TotalRAM) - ($FreeRAM))
$RAMPercentUsed = ([math]::truncate(($UsedRAM) / ($TotalRAM) * 100))
$CPUQueue = (Get-WmiObject -computername shares Win32_PerfRawData_PerfOS_System).ProcessorQueueLength
$CPUpercent = (Get-WmiObject -computername $servername win32_processor | Measure-Object -property LoadPercentage -Average).Average

if ($RAMPercentUsed -gt $memcrit){
	$memhog = (get-process | sort-object WS -descending | select-object -first 1)
	$memhogname = ($memhog).processname
	$memhogid = ($memhog).Id
	$memalarm = 2
	$output1 = "CRITICAL: Memory is $RAMPercentUsed% used. $memhogname is using the most resources, its PID is $memhogid. | Memory=$RAMPercentUsed%; CPU=$CPUpercent%"
	}
	elseif ($RAMPercentUsed -gt $memwarn){
	$memhog = (get-process -computername $servername | sort-object WS -descending | select-object -first 1)
	$memhogname = ($memhog).processname
	$memhogid = ($memhog).Id
	$memalarm = 1
	$output1 = "WARN: Memory is $RAMPercentUsed% used. $memhogname is using the most resources, its PID is $memhogid. | Memory=$RAMPercentUsed%; CPU=$CPUpercent%"
	}



if (($CPUQueue -gt $CPUq) -and ($CPUpercent -gt $CPUp)){
	$cpuhog = (get-process -computername $servername | sort-object CPU -descending | select-object -first 1)
	$cpuhogname = ($cpuhog).processname
	$cpuhogid = ($cpuhog).Id
	$cpualarm = 2
	$output2 = "CRITICAL: CPU Queue = $CPUQueue CPU% = $CPUpercent. $cpuhogname is using the most resources, its PID is $cpuhogid | Memory=$RAMPercentUsed%; CPU=$CPUpercent%"
	}
$alarm = $cpualarm + $memalarm
$output = $output1 + $output2

if ($alarm -ge 2){
	write-host $output
    	Display_memory_usage
	exit 2
	}
Elseif ($alarm -eq 1) {
	write-host $output
   	Display_memory_usage
	exit 1
	}
else {
	write-host "OK: Memory is $RAMPercentUsed % used, CPU % is $CPUpercent and CPU Queue is $CPUQueue | Memory=$RAMPercentUsed%; CPU=$CPUpercent%"
    	Display_memory_usage
	exit 0
	}
    
$fields = "Name",@{label = "Memory (MB)"; Expression = {$_.ws / 1mb}; Align = "Right"}
get-process | Sort-Object -Descending WS | select -first 10 | format-table $fields | Out-String

}
catch
{
  Write-Output $_;
  $_="";
  exit 3;
}
