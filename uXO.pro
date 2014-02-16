# Add more folders to ship with the application, here
folder_01.source = qml/uXO
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    gametracker.cpp \
    scale.cpp \
    innerboard.cpp \
    winningcombo.cpp \
    loadsave.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    gametracker.h \
    scale.h \
    innerboard.h \
    winningcombo.h \
    writer.h \
    reader.h \
    loadsave.h

OTHER_FILES += \
    android/AndroidManifest.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
