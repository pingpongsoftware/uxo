# Add more folders to ship with the application, here
folder_01.source = qml/uXO
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    innerboard.cpp \
    winningcombo.cpp \
    loadsave.cpp \
    board.cpp \
    game.cpp \
    square.cpp \
    tracker.cpp \
    values.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    innerboard.h \
    winningcombo.h \
    writer.h \
    reader.h \
    loadsave.h \
    board.h \
    game.h \
    square.h \
    tracker.h \
    values.h

OTHER_FILES += \
    android/AndroidManifest.xml \
    qml/uXO/Main.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
