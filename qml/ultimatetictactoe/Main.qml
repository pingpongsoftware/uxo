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

    Keys.onReleased: {
        console.log("KEY_PRESSED: " + event.key)
        if (event.key === Qt.Key_Back    ) {
            event.accepted = true;
            console.log("Back Button Pressed!!!");
            backButtonPressed();  //--TODO: implement function that will exit app if back button is pressed in the menu.  Have a pop up that asks if they really want to exit.
        }
    }

//    Keys.onReleased:
//    {
//        console.log("KEY: " + event.key)
//        for (var i = 0; i < 1000000000000; i++)
//        {

//        }

////        if (event.key === Qt.Key)  //android back button???
////        {
////
////        }
//    }

    function backButtonPressed()
    {
        GameTracker_js.currentFile = GameTracker_js.previousFile;
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
            backImage.source = "Images/" + Vals.theme + "/backArrow.png";  //updates the back button for the new theme
        }
    }

    Rectangle  //for the back button
    {
        id: backRect;
        color: "transparent"
        width: Vals.backButtonWidth;
        height: Vals.backButtonHeight;
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
            visible:
            {
                if (main.backButtonEnabled)
                    true;
                else
                    false;
            }

            function changeOpacityToOne()
            {
                backImage.opacity = 1;
            }
        }

        MouseArea
        {
            anchors.fill: parent;

            onPressed: backImage.opacity = .5;
            onExited: backImage.changeOpacityToOne();
            onCanceled: backImage.changeOpacityToOne();

            onClicked:
            {
                backImage.changeOpacityToOne();

                if (main.backButtonEnabled)
                {
                    backButtonPressed();
                    GameTracker_js.resetGame();
                }

                if (GameTracker_js.previousFile === "Menu.qml")
                    main.backButtonEnabled = false;
            }
        }

    }

}
