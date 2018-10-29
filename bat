#!/usr/bin/sh
#
# Summary: Displays the battery level with acpi
#

notify-send --urgency=low "$(acpi -b)"
