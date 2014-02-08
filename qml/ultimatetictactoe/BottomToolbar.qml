import QtQuick 2.0
import "GameTracker.js" as GameTracker_js

Rectangle
{
    id: main;
    color: "transparent";
    state: "xTurn";
    signal resetButtonClicked();
    signal backButtonClicked();
    signal resizeGame();


    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    Rectangle // automatically formats the toolbar in a flow layout
    {
        id: rect;
        width: parent.width;
        height: parent.height;
        anchors.margins: 50;
        color: "transparent";

        property int leftRightMargin: 20;

        Image
        {
            id: xImage;
            source: "Images/" + Vals.theme + "/x.png";
            x: parent.leftRightMargin;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Flow
        {
            id: zoomFlow
            anchors.centerIn: parent;
            spacing: Vals.menuSpacing;

            MyButton
            {
                width: Vals.smallButtonWidth;
                height: Vals.smallButtonHeight;
                showColorWhenClicked: true;

                buttonText: "zoom in";

                onClick:
                {
                    Vals.zoomIn();
                    resizeGame();  //signals Game.qml which signals Main.qml that the game has been resized
                }

            }

            MyButton
            {
                width: Vals.smallButtonWidth;
                height: Vals.smallButtonHeight;
                showColorWhenClicked: true;

                buttonText: "zoom out";

                onClick:
                {
                    Vals.zoomOut();
                    resizeGame();  //signals Game.qml which signals Main.qml that the game has been resized
                }

            }
        }



        Image
        {
            id: oImage;
            source: "Images/" + Vals.theme + "/o.png";
            x: main.width - parent.leftRightMargin - width;
            anchors.verticalCenter: parent.verticalCenter;
        }

    }

    function setTurn()
    {
        //sets the state of the toolbar
        if (GameTracker_js.xTurn)  //if(GameTracker.xTurn)
            bottomToolbar.state = "xTurn";
        else bottomToolbar.state = "oTurn";
    }

    states:
    [
        //This changes the size and the opacity of the x and o on the toolbar depending on who's turn it is.

        State
        {
            name: "xTurn";
            PropertyChanges
            {
                target: xImage;
                height: main.height;
                width: height
                opacity: 1;
            }
            PropertyChanges
            {
                target: oImage;
                height: main.height/1.5;
                width: height
                opacity: .6;
            }
        },

        State
        {
            name: "oTurn";
            PropertyChanges
            {
                target: oImage;
                height: main.height;
                width: height
                opacity: 1;
            }
            PropertyChanges
            {
                target: xImage;
                height: main.height/1.5;
                width: height
                opacity: .6;
            }
        }
    ]

    transitions:
    [
        Transition
        {
            from: "*";
            to: "*";

            PropertyAnimation
            {
                properties: "width";
                duration: 150;
            }
            PropertyAnimation
            {
                properties: "height";
                duration: 150;
            }
            PropertyAnimation
            {
                properties: "opacity";
                duration: 150;
            }
        }

    ]

}
