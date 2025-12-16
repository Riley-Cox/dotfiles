import QtQuick
import Quickshell
import ".."
//import "." as CpuProc
  Text {
    text: "CPU:" + CpuProc.cpuUsage + "%"
    color: Config.colors.text
    font.pixelSize: Config.settings.bar.fontSize
    font.family: fontMonaco.name
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
  }
