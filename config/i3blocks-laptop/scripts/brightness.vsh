#!/usr/bin/env -S v

brightness := execute("light").output.u8()

println("Brightness: ${brightness}%")
