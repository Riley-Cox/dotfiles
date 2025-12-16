import QtQuick
import ".."

Text {
  text: "RAM:" + MemProc.memUsage + "%"
  color: Config.colors.text
  font.pixelSize: Config.settings.bar.fontSize
  font.family: fontMonaco.name
  verticalAlignment: Text.AlignVCenter
  horizontalAlignment: Text.AlignHCenter
}
