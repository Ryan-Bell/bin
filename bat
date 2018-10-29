#!/usr/bin/env bash
#
# Summary: Displays the battery level with acpi
#

# The '-r' flag is from a patched version of 'libnotify'.
# '-r' lets you replace notifications using the same id.
notify-send --urgency=low "`acpi -b`"
