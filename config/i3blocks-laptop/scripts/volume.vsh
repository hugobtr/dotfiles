#!/usr/bin/env -S v

fn get_analog_output(mut pacmd_output []string) (string, string) {
	mut id := "" 
	for i, line in pacmd_output {
		if line.contains("active port") {
			id = line.split(" ")[2].trim("<").trim(">")
			pacmd_output.trim(i)
		}	
	}
	mut current_output := ""
	for line in pacmd_output {
		if line.contains(id) {
			current_output = line.split(" ")[1]
		}
	}
	return id, current_output 
}

volume := execute("pamixer --get-volume").output.trim("\n")
is_muted := execute("pamixer --get-mute").output.trim("\n")

mut pacmd_output := execute("pacmd list-sinks | grep \"analog-output\"").output.split_into_lines()

/*
active_port_raw := execute("pacmd list-sinks | grep \"analog-output\" | grep \"active port\"").output.trim("\n").split(" ")
active_port := active_port_raw[2].trim("<").trim(">")

active_port_name := execute("pacmd list-sinks | grep \"analog-output\" | grep \"${active_port}\"").output.split(" ")
*/

_, name := get_analog_output(mut pacmd_output)

if is_muted == "true" {
	println("${name}: ${volume}% M")
} else {
	println("${name}: ${volume}%")
}
