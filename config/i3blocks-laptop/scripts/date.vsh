#!/usr/bin/env -S v

full_date := execute("echo \"$(date +%A) $(date +%d) $(date +%B) $(date +%Y) $(date +%T)\"").output
shorten_date := execute("echo \"$(date +%d) $(date +%b) $(date +%Y) $(date +%T)\"").output
slash_date := execute("echo \"$(date +%D) $(date +%T)\"").output

print(shorten_date)
