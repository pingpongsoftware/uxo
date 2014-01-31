import QtQuick 2.2
import "GameTracker.js" as GameTracker_js

Rectangle
{
    id: main;

    width:
    {
        width = Vals.screenWidth;
    }
    height:
    {
        height = Vals.screenHeight;
    }

    property string previous: "Menu.qml";


    Image
    {
        id: background;
        anchors.fill: parent;
        source: "Images/" + Vals.theme + "/background.png";
    }

    Loader
    {
        id: loader;
        source: "Menu.qml";
    }

    //connects the loader with the qml files its loading.
    //uses signals to tell the loader what to do.
    Connections
    {
        target: loader.item;
        ignoreUnknownSignals: true;

        onPlayButtonClicked:
        {
            previous = loader.source;
            loader.source = "Game.qml"
        }

        onSettingsButtonClicked:
        {
            previous = loader.source;
            loader.source = "Settings.qml";
        }

        onHelpButtonClicked:
        {
            previous = loader.source;
            loader.source = "Tutorial.qml";
        }

        onTopToolbarBackButtonClicked:
        {
            loader.source = previous;
        }

        onExitButtonClicked:
        {
            loader.source = "Menu.qml"
        }

        onSwitchThemeButtonClicked:
        {
            background.source = "Images/" + Vals.theme + "/background.png";
        }
    }
}
