import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property alias backendStackAlias: backendStack
    StackView {
        id: backendStack
        anchors.fill: parent
        initialItem: ColumnLayout {
            anchors.fill: parent
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: 60
                color: "gray"
                z: 2
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 8
                    Item {
                        Layout.fillWidth: true
                    }
                    Button {
                        text: qsTr("+")
                        onClicked: {
                            editGod.visible = true
                            editGod.godName = ""
                            editGod.godCount = ""
                            editGod.godPrice = ""
                            editGod.godIndex = -1
                            backendStack.push(editGod)
                        }
                    }
                }
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                ListView {
                    model: godList.objectsModel
                    anchors.fill: parent
                    //anchors.left: parent.left
                    //anchors.right: parent.right
                    //anchors.bottom: parent.bottom
                    topMargin: 20
                    spacing: 20
                    delegate: ColumnLayout {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 40
                        anchors.margins: 8
                        anchors.topMargin: 18
                        spacing: 10
                        RowLayout {
                            width: parent.width
                            Label {
                                width: parent.width * 0.8
                                text: edit.name
                                wrapMode: Text.Wrap
                            }
                            Item {
                                Layout.fillWidth: true
                            }
                            Label {
                                text: edit.count + qsTr(" шт.")
                            }
                            Label {
                                text: ">"
                            }
                        }
                        ToolSeparator {
                            orientation: Qt.Horizontal
                            Layout.fillWidth: true
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editGod.visible = true
                                editGod.godName = edit.name
                                editGod.godCount = edit.count
                                editGod.godPrice = Math.round(edit.price * 100) / 100
                                editGod.godIndex = edit.godId
                                backendStack.push(editGod)
                            }
                        }
                    }
                }
            }
        }
    }

    EditGod {
        id: editGod
        visible: false
    }
}
