import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    SwipeView {
        anchors.fill: parent
        Repeater {
            model: godList.notNullObjectsModel
            delegate: Item {
                ColumnLayout {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 8
                    anchors.topMargin: 18
                    spacing: 10
                    //anchors.centerIn: parent
                    Label {
                        font.pixelSize: 16
                        text: edit.name
                        Layout.alignment: Qt.AlignVCenter
                    }
                    ToolSeparator {
                        orientation: Qt.Horizontal
                        Layout.fillWidth: true
                    }
                    RowLayout {
                        Label {
                            font.pixelSize: 16
                            text: qsTr("Цена")
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        Label {
                            font.pixelSize: 16
                            text: Math.round(edit.price * 100) / 100 + qsTr(" руб.")
                            opacity: 0.8
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    ToolSeparator {
                        orientation: Qt.Horizontal
                        Layout.fillWidth: true
                    }
                    RowLayout {
                        Label {
                            font.pixelSize: 16
                            text: qsTr("Количество")
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                        Label {
                            font.pixelSize: 16
                            opacity: 0.8
                            text: edit.count + qsTr(" шт.")
                        }
                    }
                    ToolSeparator {
                        orientation: Qt.Horizontal
                        Layout.fillWidth: true
                    }
                    Button {
                        font.pixelSize: 16
                        text: qsTr("Купить")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                        onClicked: {
                            console.log(edit.godId)
                            godList.startThreadBuyGod(edit.godId)
                        }
                    }
                }
            }
        }
    }
}
