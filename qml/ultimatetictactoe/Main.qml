import QtQuick 2.2
import "GameTracker.js" as GameTracker_js

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;


    property string previous: "Menu.qml";
    property bool backButtonEnabled: false;

    Keys.onReleased:
    {
        if (event.key === Qt.BackButton)  //android back button???
        {
            console.log(previous);
            backButtonPressed();
        }
    }

    function backButtonPressed()
    {
        console.log("success")
        loader.source = GameTracker_js.previousFile;
    }

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

        onHelpButtonClicked:
        {
            backButtonEnabled = true;
            GameTracker_js.previousFile = GameTracker_js.currentFile;
            GameTracker_js.currentFile = "Settings.qml";
            loader.source = "Settings.qml"
        }

        onExitButtonClicked:
        {
            loader.source = "Menu.qml"
            GameTracker_js = loader.source;
        }

        onSwitchThemeButtonClicked:
        {
            darkBackground.state = Vals.theme;  //switches the background image
            backImage.source = "Images/" + Vals.theme + "/backArrow.png";  //updates the back button for the new theme
        }
    }

    Rectangle  //for the back button
    {
        id: backRect;
        color: "transparent"
        width: Vals.buttonSize/1.5;
        height: width*1.2;
        anchors.top: parent.top;
        anchors.left: parent.left
        anchors.margins: 10

        Image
        {
            id: backImage;
            source: "Images/" + Vals.theme + "/backArrow.png";
            sourceSize.height: parent.width;
            sourceSize.width: parent.width;
            anchors.centerIn: parent;
            opacity:
            {
                if (main.backButtonEnabled)
                    1;
                else
                    0;
            }
        }

        MouseArea
        {
            anchors.fill: parent;

            onReleased:
            {
                console.log(backButtonEnabled)
                if (main.backButtonEnabled)
                {
                    console.log("back button pressed")
                    backButtonPressed();
                    GameTracker_js.resetGame();
                }

                console.log(GameTracker_js.previousFile)
                if (GameTracker_js.previousFile === "Menu.qml")
                    main.backButtonEnabled = false;
            }
        }
    }

}
