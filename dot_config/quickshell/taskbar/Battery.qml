pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import ".."

Singleton {
    id: root

    property bool hasBattery: false
    property string batteryText: "…"


    // Check whether BAT0 exists
    Process {
        id: batteryCheck
        command: ["sh", "-c", "test -d /sys/class/power_supply/BAT0/"]
        running: true

        onExited: function(exitCode) {
            root.hasBattery = (exitCode === 0)
            if (root.hasBattery) {
                batteryTimer.running = true
            } else {
                root.batteryText = ""
            }
        }
    }

    // Read capacity + status from /sys
    Process {
        id: batteryProc
        command: [
            "sh",
            "-c",
            "echo $(cat /sys/class/power_supply/BAT0/capacity) $(cat /sys/class/power_supply/BAT0/status)"
        ]
        running: false

        stdout: SplitParser {
            onRead: function(data) {
                const parts = data.trim().split(/\s+/)
                if (parts.length < 2)
                    return

                const capacity = parseInt(parts[0])
                const status = parts[1]

                let batteryIcon = "󰂂"
                if (capacity <= 20)      batteryIcon = "󰁺"
                else if (capacity <= 40) batteryIcon = "󰁽"
                else if (capacity <= 60) batteryIcon = "󰁿"
                else if (capacity <= 80) batteryIcon = "󰂁"

                const symbol = status === "Charging" ? "🔌" : batteryIcon
                root.batteryText = `${symbol} ${capacity}%`
            }
        }

        onExited: {
            running = false
        }
    }

    // Poll every 30 seconds
    Timer {
        id: batteryTimer
        interval: 3000
        repeat: true
        running: false
        onTriggered: batteryProc.running = true
    }
}

