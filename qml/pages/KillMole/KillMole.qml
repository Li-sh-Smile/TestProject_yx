import QtQuick
import QtQuick.Layouts
import Felgo

AppPage {
    id: game1

    width: parent.width
    height: parent.height

    title: "Don't let it run away"

    property int sceneSize: width > height ? height : width
    property var moleData: [0,0,0,0,0,0,0,0,0]
    property int score: 0



    Rectangle{
        anchors.fill: parent
        anchors.topMargin: 100
        anchors.bottomMargin: 100

        color: "#666666"

        Text {
            x: 10
            width: parent.width
            text: qsTr("得分：") + score
            color: "#ffffff"
            font.pixelSize: 30
        }


        GridLayout {
            // visible: false
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
                    onShowMoleChanged: console.log(index,showMole)

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

                            var _moleData = moleData
                            if(_moleData[index] === 1){
                                _moleData[index] = 0
                                moleData = _moleData
                                score += 1
                            }
                        }
                    }

                }
            }
        }
    }

    Rectangle{
        anchors.top: parent.top
        width: parent.width
        height: 100
        color: "#000000"
        Text {
            text: qsTr("广告区域")
            color: "blue"
            font.pixelSize: 32
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    Rectangle{
        anchors.bottom: parent.bottom
        width: parent.width
        height: 100
        color: "#000000"
        Text {
            text: qsTr("广告区域")
            color: "blue"
            font.pixelSize: 32
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        //插页广告
        AdMobInterstitial {
            id: interstitial
            adUnitId: Constants.admobInterstitialAdUnitId

            testDeviceIds: Constants.admobTestDeviceIds
        }
    }

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered:{
            var num = getRandomInt(0,8)

            var _moleData = moleData
            if(_moleData[num] === 0)
                _moleData[num] = 1
            else
                return
            moleData = _moleData
        }
    }

}
