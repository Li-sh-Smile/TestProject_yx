import Felgo
import QtQuick
import "../helper"

ListPage {
    title: "AdMob Plugin"
    listView.header: Column {
        width: parent.width

        SectionDescription { text: "Integrate with AdMob to monetize and promote your apps & games with ads on Android and iOS." }
        SectionContent {
            contentItem: AppImage {
                width: sourceSize.width * dp(1) * 0.75
                height: width / sourceSize.width * sourceSize.height
                source: Qt.resolvedUrl("../../assets/code-admob.png")
            }
        }
        SectionContent {
            contentItem: AppImage {
                anchors.horizontalCenter: parent.horizontalCenter
                width: sourceSize.width * dp(1) * 0.5
                height: width / sourceSize.width * sourceSize.height
                source: Qt.resolvedUrl("../../assets/logo-admob.png")
            }
        }

        SectionHeader { text: "Example" }
    }

    model: ListModel {
        id: listModel

        ListElement { section: "Visibility"; current: false; name: "Display banner" }
        ListElement { section: "Visibility"; current: false; name: "Hide banner" }

        ListElement { section: "Banner Type"; current: false; name: "Standard (320 x 50)" }
        ListElement { section: "Banner Type"; current: false; name: "Medium Rectangle (300x250)" }
        ListElement { section: "Banner Type"; current: false; name: "Large (320x100)" }
        ListElement { section: "Banner Type"; current: false; name: "Leaderboard (728x90) - Tablet Only" }
        ListElement { section: "Banner Type"; current: true; name: "Smart (auto-size)" }

        ListElement { section: "Interstitial"; active: false; name: "Load and show" }
    }

    delegate: SimpleRow {
        id: row

        text: name
        property bool isSelected: current || (index === 0 && adMobBanner.visible || index === 1 && !adMobBanner.visible)

        AppIcon {
            anchors.right: parent.right
            anchors.rightMargin: dp(10)
            anchors.verticalCenter: parent.verticalCenter
            iconType: IconType.check
            size: dp(14)
            color: row.style.textColor
            visible: isSelected
        }

        style.showDisclosure: false

        onSelected: {

            // Set selection
            if (index >= 2 && index <= 6) {
                for(var i = 0; i < listModel.count; i++) {
                    listModel.setProperty(i, "current", i === index ? true : false)
                }
            }

            // Visibility
            if (index === 0) {
                adMobBanner.visible = true
            }
            else if (index === 1) {
                adMobBanner.visible = false
            }
            // Banner types
            else if (index === 2) {
                adMobBanner.banner = AdMobBanner.Standard
            }
            else if (index === 3) {
                adMobBanner.banner = AdMobBanner.Medium
            }
            else if (index === 4) {
                adMobBanner.banner = AdMobBanner.Large
            }
            else if (index === 5) {
                adMobBanner.banner = AdMobBanner.LeaderBoard
            }
            else if (index === 6) {
                adMobBanner.banner = AdMobBanner.Smart
            }
            // Interstitial
            else if (index === 7) {
                interstitial.showInterstitialIfLoaded()
                console.debug("showInterstitialIfLoaded",Qt.platform.os)
            }
        }
    }

    section.property: "section"
    section.delegate: SimpleSection { }

    Component.onCompleted: {
        // Cache interstitial
        interstitial.loadInterstitial()
    }

    //横幅广告
    AdMobBanner {
        id: adMobBanner
        adUnitId: Constants.admobBannerAdUnitId
        banner: AdMobBanner.Smart

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        testDeviceIds: Constants.admobTestDeviceIds
    }

    //插页广告
    AdMobInterstitial {
        id: interstitial
        adUnitId: Constants.admobInterstitialAdUnitId

        testDeviceIds: Constants.admobTestDeviceIds
    }
}
