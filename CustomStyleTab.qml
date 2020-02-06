import QtQuick 2.0
import QtQuick.Controls.Styles 1.4

TabViewStyle {
    tabOverlap: 0
    frame: Item { }
    tab: Item {
        implicitWidth: control.width/control.count
        implicitHeight: 63
        BorderImage {
            anchors.fill: parent
            border.bottom: 8
            border.top: 8
            source: styleData.selected ? "../images/tab_selected.png":"../images/tab_standard.png"
            Text {
                anchors.centerIn: parent
                color: "black"
                text: styleData.title.toUpperCase()
                font.pixelSize: 16
            }
            Rectangle {
                visible: index > 0
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 10
                width:1
                color: "#3a3a3a"
            }
        }
    }
}
