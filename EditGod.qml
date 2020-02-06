import QtQuick 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4

Item {
    property var godName: ""
    property var godPrice: ""
    property var godCount: ""
    property int godIndex: -1
    Rectangle {
        id: headerRectangle
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 60
        color: "gray"
        z: 2
        RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            Button {
                text: qsTr("Отменить")
                onClicked: {
                    backendStack.pop()
                }
            }
            Item {
                Layout.fillWidth: true
            }
            Button {
                text: qsTr("Сохранить")
                onClicked: {
                    godName = godNameTextField.text;
                    godCount = parseInt(godCountTextField.text);
                    godPrice = parseFloat(godPriceTextField.text);
                    if (godIndex != -1) {
                        godList.startThreadModifyGod(godIndex, godName, godCount, godPrice);
                    }else {
                        godList.startThreadAddGod(godName, godCount, godPrice);
                    }

                    backendStack.pop()
                }
            }
        }
    }
    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: headerRectangle.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 8
        anchors.topMargin: 10
        spacing: 5
        Label {
            text: qsTr("Название")
            font.pixelSize: 16
        }
        ToolSeparator {
            orientation: Qt.Horizontal
            Layout.fillWidth: true
        }
        TextField {
            id: godNameTextField
            Layout.fillWidth: true
            anchors.margins: 20
            text: godName
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 38
                border.color: "black"
            }
        }
        ToolSeparator {
            orientation: Qt.Horizontal
            Layout.fillWidth: true
        }

        Label {
            text: qsTr("Цена, руб.")
            font.pixelSize: 16
        }
        ToolSeparator {
            orientation: Qt.Horizontal
            Layout.fillWidth: true
        }
        TextField {
            id: godPriceTextField
            Layout.fillWidth: true
            anchors.margins: 20
            text: godPrice
            inputMethodHints: Qt.ImhPreferNumbers
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 38
                border.color: "black"
            }
        }
        ToolSeparator {
            orientation: Qt.Horizontal
            Layout.fillWidth: true
        }

        Label {
            text: qsTr("Количество, шт.")
            font.pixelSize: 16
        }
        ToolSeparator {
            orientation: Qt.Horizontal
            Layout.fillWidth: true
        }
        TextField {
            id: godCountTextField
            Layout.fillWidth: true
            anchors.margins: 20
            text: godCount
            inputMethodHints: Qt.ImhPreferNumbers
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 38
                border.color: "black"
            }
        }
    }

    Component {
        id: customStyleTextField
        CustomStyleTextField {}
    }
}
