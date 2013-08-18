import QtQuick 2.0
import "GameTracker.js" as GameTracker

Rectangle
{
    id: main;

    width:
    {
        width = Vals.SCREEN_WIDTH;
    }
    height:
    {
        height = Vals.SCREEN_HEIGHT;
    }

    property string previous: "Menu.qml";

    Image
    {
        id: background;
        anchors.fill: parent;
        source: "Images/background.png";
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

        onTutorialButtonClicked:
        {
            previous = loader.source;
            loader.source = "Tutorial.qml";
        }


//        onResetButtonClicked:
//        {
//            console.log("works!")
//            GameTracker.resetGame();
//        }
    }
}
