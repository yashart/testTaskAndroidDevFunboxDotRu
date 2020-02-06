import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.4
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    visible: true
    id: mainWindow
    width: 320
    height: 480
    title: qsTr("Hello World")

    TabView {
        id: tabView
        anchors.fill: parent
        tabPosition: Qt.BottomEdge
        style: tabViewStyle

        Tab {
            title: "Store-Front"
            StoreFront {

            }
        }
        Tab {
            title: "Back-End"
            Backend {
                id: backend
            }
        }
    }

    onClosing: {
        if (tabView.getTab(1).item.backendStackAlias.depth > 1) {
            close.accepted = false
            tabView.getTab(1).item.backendStackAlias.pop()
        }else {
            return;
        }
    }

    Component {
        id: tabViewStyle
        CustomStyleTab {}
    }
}
