#!/usr/bin/env -S v

output := execute("acpi").output.split(" ")

match output[2].trim(",") {
	"Full" {
		if output[3].contains(",") {
			println("Battery: ${output[3].trim(",")}")
		} else {
			print("Battery: ${output[3]}") 
		} 
	}
	"Not" {
		if output[4].contains(",") {
			println("Battery: ${output[4].trim(",")}")
		} else {
			print("Battery: ${output[4]}")
		}	
	}
	"Charging" {
		println("Battery: ${output[3].trim(",")} ${output[4]}")
	}
	"Discharging" {
		if output[4] == "rate" {
			println("Battery: ${output[3].trim(",")}")
		} else {
			println("Battery: ${output[3].trim(",")} ${output[4]}")
		}
	}
	else {}
}
