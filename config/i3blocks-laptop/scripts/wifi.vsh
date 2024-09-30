#!/usr/bin/env -S v

const station = "wlan0"

ssid := execute("/sbin/iwgetid -r").output.trim("\n")
quality_raw := execute("/sbin/iwconfig ${station} 2> /dev/null | awk -F= '/Quality/ {print $2}' | awk '{print $1}'").output.split("/")
frequency := execute("/sbin/iwgetid -f -r").output.split("e")
bitrate := execute("/sbin/iw dev ${station} link | grep \"rx\" |awk '{ print $3}'").output.trim("\n")
bitrate_speed := execute("/sbin/iw dev ${station} link | grep \"rx\" |awk '{ print $4}'").output.trim("\n")

if ssid == "" {
	println("${station}: down")
} else {
	signal_current := quality_raw[0].f32()
	signal_max := quality_raw[1].f32()
	signal_percentage := int(signal_current/signal_max*100)
	println("${station}: ${signal_percentage}% at ${ssid} (${frequency[0]} Ghz, ${bitrate} ${bitrate_speed})")
}
