import QtQuick
import Felgo

AppPage {
    width: parent.width
    height: parent.height

    title: "选择游戏关卡"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            page.navigationStack.push(Qt.resolvedUrl("KillMole.qml"))
            // lockAllLevels()
        }
    }

    function lockAllLevels() {
        var levelInit = settings.getValue("levelsInit")

        console.debug(levelInit)
        if(levelInit === undefined){
            settings.setValue("levelsInit", true)
        }
        else{
            settings.setValue("levelsInit", !levelInit)
        }

        // if(levelInit === undefined) {
        //     settings.setValue("levelsInit", true)
        //     settings.setValue(3863, true) // 2
        //     settings.setValue(7335, true) // 3
        //     settings.setValue(6849, true) // 4
        //     settings.setValue(1805, true) // 5
        //     settings.setValue(7612, true) // 6
        //     settings.setValue(130, true) // 7
        //     settings.setValue(8646, true) // 8
        //     settings.setValue(9201, true) // 9
        //     settings.setValue(5840, true) // 10
        // }
    }
}
