cmake_minimum_required(VERSION 3.16)

project(untitled3 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Felgo REQUIRED)

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
set(PRODUCT_IDENTIFIER "smile.test.iphone.app.yx.li")
set(PRODUCT_VERSION_NAME "1.0.0")
set(PRODUCT_VERSION_CODE 1)

# Set either "test" or "publish" stage:
set(PRODUCT_STAGE "test")

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Developer App
set(PRODUCT_LICENSE_KEY "89B87BD0900D72697EC8B2259D87B62F8090F22A0AB50CD06DA90B29C7770DFACFD89226B4878F50B8014C39CE6234AA5C984E7D1D480D7272645E17F324FF8EAD391C6D54C7D27697B6BF04161875CFEEB217B6636BD94993016C95460B5AF5DFAA8586ECB38959AB12A8A47E57B085AA78883F39BD831CC815D82D3575593F95C86B6D2F7336E893C6FA74B2FF0395B17F8D24A3DA75B7C92EB933BD631AD59FF423490F0F75914499E09C84B84482B875168FF7559DCEDE08BD0B3495A8524A68B209037F992CF1B65497B2956C73ECAFC7704751274D59B0779EA5DC8DEDC974E7C874497F06FAB3C8595B202422456D69B3C8BCB0873CD7DB537DE85E087A675756E79689144B2C04FFA8C062D2B23A8C0E39ECD91C55A953E743F6DBEC77F31378FB1F8C91685D4199A914C57AD32B74292CE33A4CA397A22121C84CD5346DF015C8FC2FDD27497AFD2394F5E8")

set(FELGO_PLUGINS
    admob
)

# Find all QML/JS files for the QML compiler:
file(GLOB_RECURSE QmlFiles RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} qml/*.qml qml/*.js)

# Find all non-QML/JS files in the qml and assets folder to add as resources:
file(GLOB_RECURSE AssetsFiles RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} assets/* qml/*)
list(REMOVE_ITEM AssetsFiles ${QmlFiles})

qt_add_executable(appuntitled3
    main.cpp
    ${QmlFiles}
    ${AssetsFiles}
)

felgo_configure_executable(appuntitled3)

# Deploy resources to build folder/package directly
# comment for publishing
deploy_resources("${QmlFiles};${AssetsFiles}")

# Add QML files and resources to QML module to included them via QRC automatically:
qt_add_qml_module(appuntitled3
    URI untitled3
    VERSION 1.0
# uncomment for publishing:
#    QML_FILES ${QmlFiles}
#    RESOURCES ${AssetsFiles}
    NO_RESOURCE_TARGET_PATH
)

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the deploy_resources line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the QML_FILES and RESOURCES above; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the deploy_resources because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted

target_compile_definitions(appuntitled3
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

target_link_libraries(appuntitled3 PRIVATE Felgo)

# uncomment this line to add Felgo Hot Reload and use hot reloading with your custom C++ code
# for the remaining steps see here: https://felgo.com/custom-code-reload-app/
# find_package(FelgoHotReload REQUIRED)
# target_link_libraries(appuntitled3 PRIVATE FelgoHotReload)
