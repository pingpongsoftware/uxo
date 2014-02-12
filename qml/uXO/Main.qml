import QtQuick 2.0
import "GameTracker.js" as GameTracker_js

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    focus:true;

    property string previous: "Menu.qml";
    property bool backButtonEnabled: false;

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
            State { name: "dark"; PropertyChanges { target: darkBackground; opacity: 1; } },
            State { name: "light"; PropertyChanges { target: darkBackground; opacity: 0; } }
        ]

        transitions:
        [
            Transition
            {
                from: "*"; to: "*"
                PropertyAnimation { target: darkBackground; property: "opacity"; duration: Vals.transitionTime; }
            }
        ]
    }

    Loader
    {
        id: loader;
        source: source = "Menu.qml";
    }

    //connects the loader with the qml files its loading.
    //uses signals to tell the loader what to do.
    Connections
    {
        target: loader.item;
        ignoreUnknownSignals: true;

        onPlayButtonClicked:
        {
            backButtonEnabled = true;
            GameTracker_js.previousFile = GameTracker_js.currentFile;
            GameTracker_js.currentFile = "Game.qml";
            loader.source = "Game.qml"
        }

        onSettingsButtonClicked:
        {
            backButtonEnabled = true;
            GameTracker_js.previousFile = GameTracker_js.currentFile;
            GameTracker_js.currentFile = "Settings.qml";
            loader.source = "Settings.qml"
        }

        onTutorialButtonClicked:
        {
            backButtonEnabled = true;
            GameTracker_js.previousFile = GameTracker_js.currentFile;
            GameTracker_js.currentFile = "Tutorial.qml";
            loader.source = "Tutorial.qml"
        }

        onExitButtonClicked:
        {
            loader.source = "Menu.qml"
            GameTracker_js = loader.source;
        }

        onSwitchThemeButtonClicked:
        {
            darkBackground.state = Vals.theme;  //switches the background image
            topToolbar.state = Vals.theme;
        }
    }

    TopToolbar
    {
        id: topToolbar;
        anchors.top: main.top;
        anchors.horizontalCenter: main.horizontalCenter;
        state: Vals.theme;

        onBackButtonPressed:
        {
            main.backButtonPressed();
        }
    }

    Keys.onReleased: {
        console.log("KEY_PRESSED: " + event.key)
        if (event.key === Qt.Key_Back    ) {
            event.accepted = true;
            console.log("Back Button Pressed!!!");
            backButtonPressed();  //--TODO: implement function that will exit app if back button is pressed in the menu.  Have a pop up that asks if they really want to exit.
        }
    }

    function backButtonPressed()
    {
        GameTracker_js.resetGame();
        GameTracker_js.currentFile = GameTracker_js.previousFile;
        loader.source = GameTracker_js.previousFile;
        if (GameTracker_js.previousFile === "Main.qml");
            backButtonEnabled = false;
        Vals.zoomOut();
    }
}
