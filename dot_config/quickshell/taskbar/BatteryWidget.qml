import QtQuick
import Quickshell
import ".."

Text {
  text: Battery.hasBattery ? Battery.batteryText : ""
  color: Config.colors.text
  font.pixelSize: Config.settings.bar.fontSize
  font.family: fontMonaco.name
  horizontalAlignment: Text.AlignHCenter
  verticalAlignment: Text.AlignVCenter

}
