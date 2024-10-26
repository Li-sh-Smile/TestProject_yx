import Felgo
import QtQuick
import "pages"
import "helper"
import "pages/KillMole"

/*/////////////////////////////////////
  NOTE:
  Additional integration steps are needed to use Felgo Plugins, for example to add and link required libraries for Android and iOS.
  Please follow the integration steps described in the plugin documentation of your chosen plugins:
  - AdMob: https://felgo.com/doc/plugin-admob/

  To open the documentation of a plugin item in Qt Creator, place your cursor on the item in your QML code and press F1.
  This allows to view the properties, methods and signals of Felgo Plugins directly in Qt Creator.

/////////////////////////////////////*/

App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"
    licenseKey: "89B87BD0900D72697EC8B2259D87B62F8090F22A0AB50CD06DA90B29C7770DFACFD89226B4878F50B8014C39CE6234AA5C984E7D1D480D7272645E17F324FF8EAD391C6D54C7D27697B6BF04161875CFEEB217B6636BD94993016C95460B5AF5DFAA8586ECB38959AB12A8A47E57B085AA78883F39BD831CC815D82D3575593F95C86B6D2F7336E893C6FA74B2FF0395B17F8D24A3DA75B7C92EB933BD631AD59FF423490F0F75914499E09C84B84482B875168FF7559DCEDE08BD0B3495A8524A68B209037F992CF1B65497B2956C73ECAFC7704751274D59B0779EA5DC8DEDC974E7C874497F06FAB3C8595B202422456D69B3C8BCB0873CD7DB537DE85E087A675756E79689144B2C04FFA8C062D2B23A8C0E39ECD91C55A953E743F6DBEC77F31378FB1F8C91685D4199A914C57AD32B74292CE33A4CA397A22121C84CD5346DF015C8FC2FDD27497AFD2394F5E8"

    // This item contains example code for the chosen Felgo Plugins
    // It is hidden by default and will overlay the QML items below if shown
    PluginMainItem {
        id: pluginMainItem
        z: 1           // display the plugin example above other items in the QML code below
        visible: false // set this to true to show the plugin example
    }

    NavigationStack {
        anchors.fill: parent

        // initial page contains list if plugins and opens pages for each plugin when selected
        ListPage {
            id: page
            title: qsTr("选择游戏 ")

            model: ListModel {
                ListElement { type: "Advertising"; name: "AdMob";
                    detailText: "Ad Monetization and Promotion"; image: "../assets/logo-admob.png" }
                ListElement { type: "游戏"; name: "Don't let it run away";
                    detailText: "这是一个打地鼠游戏"; image: "../assets/mole.png" }
            }

            delegate: PluginListItem {
                visible: name !== "GameCenter" || Theme.isIos
                opacity: enabled ? 1.0 : 0.3

                onSelected: {
                    switch (name) {
                    case "AdMob":
                        page.navigationStack.push(Qt.resolvedUrl("pages/AdMobPage.qml"))
                        break
                    case qsTr("Don't let it run away"):
                        page.navigationStack.push(Qt.resolvedUrl("pages/KillMole/KillMoleLevel.qml"))
                        break
                    }
                }
            }

            section.property: "type"
            section.delegate: SimpleSection { }
        }

    }
}
