import QtQuick 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12

TextFieldStyle {
    textColor: "black"
    background: Item {
        implicitHeight: 50
        implicitWidth: 320
        BorderImage {
            source: "../images/textinput.png"
            border.left: 8
            border.right: 8
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}
