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
        id: lightBackground;
        anchors.fill: parent;
        source: "Images/light/background.png";
    }

    Image  //the theme depends on the opacity of this image (dark background)
    {
        id: darkBackground;
        anchors.fill: parent;
        source: "Images/dark/background.png";

        state: Vals.theme;
        states: //changes the opacity of the dark background depending on which theme is selected;
        [
            State
            {
                name: "dark";
                PropertyChanges
                {
                    target: darkBackground;
                    opacity: 1;
                }
            },

            State
            {
                name: "light";
                PropertyChanges
                {
                    target: darkBackground;
                    opacity: 0;
                }
            }
        ]

        transitions:
        [
            Transition
            {
                from: "*"
                to: "*"

                PropertyAnimation
                {
                    target: darkBackground;
                    property: "opacity";
                    duration: 150;
                }
            }
        ]
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
            darkBackground.state = Vals.theme;
        }
    }
}
