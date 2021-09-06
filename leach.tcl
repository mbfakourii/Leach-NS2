#Simulation parameters setup
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     5                          ;# number of mobilenodes
set val(rp)     AODV                      ;# routing protocol
set val(x)      876                      ;# X dimension of topography
set val(y)      100                      ;# Y dimension of topography
set val(stop)   50.0                         ;# time of simulation end

#----------> Initialization

#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#--------> Mobile node parameter setup
$ns node-config -adhocRouting  $val(rp) \
	-llType        $val(ll) \
	-macType       $val(mac) \
	-ifqType       $val(ifq) \
	-ifqLen        $val(ifqlen) \
	-antType       $val(ant) \
	-propType      $val(prop) \
	-phyType       $val(netif) \
	-channel       $chan \
	-topoInstance  $topo \
	-agentTrace    OFF \
	-routerTrace   OFF \
	-macTrace      ON \
	-movementTrace ON

#---------> Nodes Definition

#Create 5 nodes
set n0 [$ns node]
$n0 set X_ 500
$n0 set Y_ 396
$n0 set Z_ 0.0
#$no set energy 100
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 605
$n1 set Y_ 519
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 699
$n2 set Y_ 401
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 535
$n3 set Y_ 296
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 655
$n4 set Y_ 298
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20

#===================================
#        Agents Definition
#===================================
set udp10 [new Agent/UDP]
set udp12 [new Agent/UDP]
set udp13 [new Agent/UDP]
set udp14 [new Agent/UDP]
set udp20 [new Agent/UDP]
set udp21 [new Agent/UDP]
set udp23 [new Agent/UDP]
set udp24 [new Agent/UDP]
set udp30 [new Agent/UDP]
set udp31 [new Agent/UDP]
set udp32 [new Agent/UDP]
set udp34 [new Agent/UDP]
set udp40 [new Agent/UDP]
set udp41 [new Agent/UDP]
set udp42 [new Agent/UDP]
set udp43 [new Agent/UDP]

set null01 [new Agent/Null]
set null02 [new Agent/Null]
set null03 [new Agent/Null]
set null04 [new Agent/Null]
set null12 [new Agent/Null]
set null13 [new Agent/Null]
set null14 [new Agent/Null]
set null21 [new Agent/Null]
set null24 [new Agent/Null]
set null23 [new Agent/Null]
set null31 [new Agent/Null]
set null32 [new Agent/Null]
set null34 [new Agent/Null]
set null41 [new Agent/Null]
set null42 [new Agent/Null]
set null43 [new Agent/Null]

$ns attach-agent $n1 $udp10
$ns attach-agent $n1 $udp12
$ns attach-agent $n1 $udp13
$ns attach-agent $n1 $udp14
$ns attach-agent $n2 $udp20
$ns attach-agent $n2 $udp21
$ns attach-agent $n2 $udp23
$ns attach-agent $n2 $udp24
$ns attach-agent $n3 $udp30
$ns attach-agent $n3 $udp31
$ns attach-agent $n3 $udp32
$ns attach-agent $n3 $udp34
$ns attach-agent $n4 $udp40
$ns attach-agent $n4 $udp41
$ns attach-agent $n4 $udp42
$ns attach-agent $n4 $udp43

$ns attach-agent $n0 $null01
$ns attach-agent $n0 $null02
$ns attach-agent $n0 $null03
$ns attach-agent $n0 $null04

$ns attach-agent $n1 $null12
$ns attach-agent $n1 $null13
$ns attach-agent $n1 $null14

$ns attach-agent $n2 $null21
$ns attach-agent $n2 $null23
$ns attach-agent $n2 $null24

$ns attach-agent $n3 $null31
$ns attach-agent $n3 $null32
$ns attach-agent $n3 $null34

$ns attach-agent $n4 $null41
$ns attach-agent $n4 $null42
$ns attach-agent $n4 $null43

$udp10 set packetSize_ 1500
$udp20 set packetSize_ 1500
$udp30 set packetSize_ 1500
$udp40 set packetSize_ 1500
$udp12 set packetSize_ 1500
$udp21 set packetSize_ 1500
$udp31 set packetSize_ 1500
$udp41 set packetSize_ 1500
$udp13 set packetSize_ 1500
$udp23 set packetSize_ 1500
$udp32 set packetSize_ 1500
$udp42 set packetSize_ 1500
$udp14 set packetSize_ 1500
$udp24 set packetSize_ 1500
$udp34 set packetSize_ 1500
$udp43 set packetSize_ 1500


set cbr10 [new Application/Traffic/CBR]
$cbr10 attach-agent $udp10
$cbr10 set packetSize_ 1000
$cbr10 set rate_ 1.0Mb
$cbr10 set random_ null

set cbr12 [new Application/Traffic/CBR]
$cbr12 attach-agent $udp12
$cbr12 set packetSize_ 1000
$cbr12 set rate_ 1.0Mb
$cbr12 set random_ null

set cbr13 [new Application/Traffic/CBR]
$cbr13 attach-agent $udp13
$cbr13 set packetSize_ 1000
$cbr13 set rate_ 1.0Mb
$cbr13 set random_ null

set cbr14 [new Application/Traffic/CBR]
$cbr14 attach-agent $udp14
$cbr14 set packetSize_ 1000
$cbr14 set rate_ 1.0Mb
$cbr14 set random_ null

set cbr20 [new Application/Traffic/CBR]
$cbr20 attach-agent $udp20
$cbr20 set packetSize_ 1000
$cbr20 set rate_ 1.0Mb
$cbr20 set random_ null


set cbr21 [new Application/Traffic/CBR]
$cbr21 attach-agent $udp21
$cbr21 set packetSize_ 1000
$cbr21 set rate_ 1.0Mb
$cbr21 set random_ null

set cbr23 [new Application/Traffic/CBR]
$cbr23 attach-agent $udp23
$cbr23 set packetSize_ 1000
$cbr23 set rate_ 1.0Mb
$cbr23 set random_ null


set cbr24 [new Application/Traffic/CBR]
$cbr24 attach-agent $udp24
$cbr24 set packetSize_ 1000
$cbr24 set rate_ 1.0Mb
$cbr24 set random_ null

set cbr30 [new Application/Traffic/CBR]
$cbr30 attach-agent $udp30
$cbr30 set packetSize_ 1000
$cbr30 set rate_ 1.0Mb
$cbr30 set random_ null


set cbr31 [new Application/Traffic/CBR]
$cbr31 attach-agent $udp31
$cbr31 set packetSize_ 1000
$cbr31 set rate_ 1.0Mb
$cbr31 set random_ null


set cbr32 [new Application/Traffic/CBR]
$cbr32 attach-agent $udp32
$cbr32 set packetSize_ 1000
$cbr32 set rate_ 1.0Mb
$cbr32 set random_ null


set cbr34 [new Application/Traffic/CBR]
$cbr34 attach-agent $udp34
$cbr34 set packetSize_ 1000
$cbr34 set rate_ 1.0Mb
$cbr34 set random_ null


set cbr40 [new Application/Traffic/CBR]
$cbr40 attach-agent $udp40
$cbr40 set packetSize_ 1000
$cbr40 set rate_ 1.0Mb
$cbr40 set random_ null

set cbr41 [new Application/Traffic/CBR]
$cbr41 attach-agent $udp41
$cbr41 set packetSize_ 1000
$cbr41 set rate_ 1.0Mb
$cbr41 set random_ null

set cbr42 [new Application/Traffic/CBR]
$cbr42 attach-agent $udp42
$cbr42 set packetSize_ 1000
$cbr42 set rate_ 1.0Mb
$cbr42 set random_ null

set cbr43 [new Application/Traffic/CBR]
$cbr43 attach-agent $udp43
$cbr43 set packetSize_ 1000
$cbr43 set rate_ 1.0Mb
$cbr43 set random_ null

set energylist(0) 100
set energylist(1) 100
set energylist(2) 100
set energylist(3) 100
set MaxEnergyNode 0
set timer 0.0

$ns connect $udp10 $null01
$ns connect $udp12 $null21
$ns connect $udp13 $null31
$ns connect $udp14 $null41


$ns connect $udp20 $null02
$ns connect $udp21 $null12
$ns connect $udp23 $null32
$ns connect $udp24 $null42


$ns connect $udp30 $null03
$ns connect $udp31 $null13
$ns connect $udp32 $null23
$ns connect $udp34 $null43


$ns connect $udp40 $null04
$ns connect $udp41 $null14
$ns connect $udp42 $null24
$ns connect $udp43 $null34


proc setcluster {} {
	global energylist MaxEnergyNode
	if {$energylist(0)>=$energylist(1) && $energylist(0)>=$energylist(2) && $energylist(0)>=$energylist(3)} {
		set MaxEnergyNode 1
	} elseif {$energylist(1)>=$energylist(0) && $energylist(1)>=$energylist(2) && $energylist(1)>=$energylist(3)} {
		set MaxEnergyNode 2
	} elseif {$energylist(2)>=$energylist(0) && $energylist(2)>=$energylist(1) && $energylist(2)>=$energylist(3)} {
		set MaxEnergyNode 3
	} elseif {$energylist(3)>=$energylist(0) && $energylist(3)>=$energylist(2) && $energylist(3)>=$energylist(1)} {
		set MaxEnergyNode 4
	}
}


proc sendPackets1 {} {
	global ns cbr10 cbr21 cbr31 cbr41 timer energylist n1 n2 n3 n4
	$ns at [expr 0.0+$timer] "$n2 color blue"
	$n2 color "blue"
	$ns at [expr 0.0+$timer] "$n3 color blue"
	$n3 color "blue"
	$ns at [expr 0.0+$timer] "$n4 color blue"
	$n4 color "blue"
	$ns at [expr 0.0+$timer] "$n1 color red"
	$n1 color "red"
	$ns at [expr 0.0+$timer] "$cbr21 start"
	$ns at [expr 0.5+$timer] "$cbr21 stop"
	$ns at [expr 1.0+$timer] "$cbr10 start"
	$ns at [expr 1.5+$timer] "$cbr10 stop"
	$ns at [expr 2.0+$timer] "$cbr31 start"
	$ns at [expr 2.5+$timer] "$cbr31 stop"
	$ns at [expr 3.0+$timer] "$cbr10 start"
	$ns at [expr 3.5+$timer] "$cbr10 stop"
	$ns at [expr 4.0+$timer] "$cbr41 start"
	$ns at [expr 4.2+$timer] "$cbr41 stop"
	$ns at [expr 4.5+$timer] "$cbr10 start"
	$ns at [expr 4.8+$timer] "$cbr10 stop"
	set timer [expr $timer+5.0]
	puts "1 $timer"
	set energylist(0) [expr $energylist(0)-9]

}

proc sendPackets2 {} {
	global ns cbr12 cbr20 cbr32 cbr42 timer energylist n1 n2 n3 n4
	$ns at [expr 0.0+$timer] "$n2 color red"
	$n2 color "red"
	$ns at [expr 0.0+$timer] "$n3 color blue"
	$n3 color "blue"
	$ns at [expr 0.0+$timer] "$n4 color blue"
	$n4 color "blue"
	$ns at [expr 0.0+$timer] "$n1 color blue"
	$n1 color "blue"
	$ns at [expr 0.0+$timer] "$cbr12 start"
	$ns at [expr 0.5+$timer] "$cbr12 stop"
	$ns at [expr 1.0+$timer] "$cbr20 start"
	$ns at [expr 1.5+$timer] "$cbr20 stop"
	$ns at [expr 2.0+$timer] "$cbr32 start"
	$ns at [expr 2.5+$timer] "$cbr32 stop"
	$ns at [expr 3.0+$timer] "$cbr20 start"
	$ns at [expr 3.5+$timer] "$cbr20 stop"
	$ns at [expr 4.0+$timer] "$cbr42 start"
	$ns at [expr 4.5+$timer] "$cbr42 stop"
	$ns at [expr 4.8+$timer] "$cbr20 start"
	$ns at [expr 4.99+$timer] "$cbr20 stop"
	set timer [expr $timer+5.0]
	puts "2 $timer"
	set energylist(1) [expr $energylist(1)-12]

}

proc sendPackets3 {} {
	global ns cbr13 cbr23 cbr30 cbr43 timer energylist n1 n2 n3 n4
	$ns at [expr 0.0+$timer] "$n2 color blue"
	$n2 color "blue"
	$ns at [expr 0.0+$timer] "$n3 color red"
	$n3 color "red"
	$ns at [expr 0.0+$timer] "$n4 color blue"
	$n4 color "blue"
	$ns at [expr 0.0+$timer] "$n1 color blue"
	$n1 color "blue"
	$ns at [expr 0.0+$timer] "$cbr13 start"
	$ns at [expr 0.5+$timer] "$cbr13 stop"
	$ns at [expr 1.0+$timer] "$cbr30 start"
	$ns at [expr 1.5+$timer] "$cbr30 stop"
	$ns at [expr 2.0+$timer] "$cbr23 start"
	$ns at [expr 2.5+$timer] "$cbr23 stop"
	$ns at [expr 3.0+$timer] "$cbr30 start"
	$ns at [expr 3.5+$timer] "$cbr30 stop"
	$ns at [expr 4.0+$timer] "$cbr43 start"
	$ns at [expr 4.2+$timer] "$cbr43 stop"
	$ns at [expr 4.5+$timer] "$cbr30 start"
	$ns at [expr 4.8+$timer] "$cbr30 stop"
	set timer [expr $timer+5.0]
	puts "3 $timer"
	set energylist(2) [expr $energylist(2)-11]

}

proc sendPackets4 {} {
	global ns cbr14 cbr24 cbr34 cbr40 timer energylist n1 n2 n3 n4
	$ns at [expr 0.0+$timer] "$n2 color blue"
	$n2 color "blue"
	$ns at [expr 0.0+$timer] "$n3 color blue"
	$n3 color "blue"
	$ns at [expr 0.0+$timer] "$n4 color red"
	$n4 color "red"
	$ns at [expr 0.0+$timer] "$n1 color blue"
	$n1 color "blue"
	$ns at [expr 0.0+$timer] "$cbr14 start"
	$ns at [expr 0.5+$timer] "$cbr14 stop"
	$ns at [expr 1.0+$timer] "$cbr40 start"
	$ns at [expr 1.5+$timer] "$cbr40 stop"
	$ns at [expr 2.0+$timer] "$cbr24 start"
	$ns at [expr 2.5+$timer] "$cbr24 stop"
	$ns at [expr 3.0+$timer] "$cbr40 start"
	$ns at [expr 3.5+$timer] "$cbr40 stop"
	$ns at [expr 4.0+$timer] "$cbr34 start"
	$ns at [expr 4.2+$timer] "$cbr34 stop"
	$ns at [expr 4.5+$timer] "$cbr40 start"
	$ns at [expr 4.8+$timer] "$cbr40 stop"
	set timer [expr $timer+5.0]
	puts "4 $timer"
	set energylist(3) [expr $energylist(3)-8]

}


proc leach {} {
	global timer timer1 MaxEnergyNode energylist
	while {$timer<50} {
		setcluster
		if [expr $MaxEnergyNode==1] {
			sendPackets1
		} elseif [expr $MaxEnergyNode==2] {
			sendPackets2
		} elseif [expr $MaxEnergyNode==3] {
			sendPackets3
		} elseif [expr $MaxEnergyNode==4] {
			sendPackets4
		}
		puts "$energylist(0) $energylist(1) $energylist(2) $energylist(3) "
	}
}

leach
#===================================
#        Termination
#===================================
#Define a 'finish' procedure
proc finish {} {
	global ns tracefile namfile
	$ns flush-trace
	close $tracefile
	close $namfile
	exec nam out.nam &
	exit 0
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
	$ns at $val(stop) "\$n$i reset"
}

# ending nam and the simulation
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"


$ns run
