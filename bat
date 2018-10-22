#!/usr/bin/env bash
#
# Display the battery level 
#

# The '-r' flag is from a patched version of 'libnotify'.
# '-r' lets you replace notifications using the same id.
notify-send --urgency=low "`acpi -b`"
