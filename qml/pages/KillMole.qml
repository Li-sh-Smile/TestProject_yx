import QtQuick
import QtQuick.Layouts
import Felgo

AppPage {
    id: game1

    title: "Don't let it run away"

    // width: parent.width
    // height: parent.height

    property int sceneSize: width > height ? height : width
    property var moleData: [1,1,1,1,1,1,1,1,1]
    onMoleDataChanged: {
        console.debug(moleData)
    }

    // Timer {
    //     interval: 2000
    //     running: true
    //     repeat: true
    //     onTriggered: {
    //         var randomNumber = Math.floor(Math.random() * 1000) % 9
    //         console.log(randomNumber)
    //         moleData[randomNumber] = true
    //     }
    // }

    Rectangle{
        anchors.fill: parent
        color: "#666666"

        GridLayout {
            width: sceneSize
            height: sceneSize
            anchors.centerIn: parent

            rows: 3
            columns: 3
            Repeater {
                model: 9

                Rectangle {
                    width: sceneSize/3
                    height: sceneSize/3
                    color: "green"
                    border.width: 5
                    border.color: "red"
                    property bool showMole: moleData[index]

                    Rectangle {

                        width: sceneSize/3/2
                        height: sceneSize/3/2
                        radius: sceneSize/3/2
                        anchors.centerIn: parent
                        color: "#009900"
                        border.width: 5
                        border.color: "red"
                        visible: showMole
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            if(moleData[index] === 1){
                                moleData[index] = 0
                                showMole = moleData[index]
                                console.debug("111",index)
                                moleData[index] = 1
                            }
                        }
                    }

                }
            }

        }

    }



}
