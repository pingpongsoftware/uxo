import QtQuick 2.0;
import "Scale.js" as Vals;
import "GameTracker.js" as GameTracker;

Rectangle
{
    id: main;
    color: "transparent";
    state: "xTurn";

    signal resetButtonClicked();
    signal backButtonClicked();
    signal confirmButtonClicked();

    property color releasedColor: Qt.rgba(0,0,0,.5);
    property color enteredColor: Qt.rgba(0,0,0,.8);
    property color pressedColor: Qt.rgba(0,0,0,1);


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
            source: "Images/x.png";
            x: parent.leftRightMargin;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Image
        {
            id: oImage;
            source: "Images/o.png";
            x: main.width - parent.leftRightMargin - width;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Rectangle
        {
            id: confirmRect;
            width: Vals.mediumButtonWidth*1.2;
            height: Vals.mediumButtonHeight;
            anchors.centerIn: parent;
            color: main.releasedColor;
            radius: 10;

            Text
            {
                text: "Confirm Move";

                color: //the text will be gray if the player has not made a move yet
                {
                    GameTracker.canConfirmedButtonBeClicked = true;

                    if (GameTracker.canConfirmedButtonBeClicked)
                        "white";
                    else
                        "gray";
                }

                opacity: .5;
                font.family: prime_reg.name;
                font.pixelSize: Vals.mediumFontSize;
                anchors.centerIn: parent;
            }

            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered:
                {
                    if (GameTracker.canConfirmedButtonBeClicked)
                        parent.color = main.enteredColor;
                }
                onExited:
                {
                    if (GameTracker.canConfirmedButtonBeClicked)
                        parent.color = main.releasedColor;
                }
                onPressed:
                {
                    if (GameTracker.canConfirmedButtonBeClicked)
                        parent.color = main.pressedColor;
                }

                onReleased:
                {
                    parent.color = main.enteredColor;
                    confirmButtonClicked();
                }
            }
        }

//        Rectangle // back button
//        {
//            id: backRect

//            width: 90;
//            height: parent.height - 10;
//            color: main.releasedColor;
//            radius: 7;

//            Image
//            {
//                id: backImage;
//                anchors.fill: parent;
//                source: "Images/backArrow.png";
//                fillMode: Image.PreserveAspectFit;
//            }

////            Text
////            {
////                text: "Menu";
////                color: "white";
////                opacity: .4;
////                font.family: prime_reg.name;
////                font.pixelSize: 20;
////                anchors.centerIn: parent;
////            }

//            MouseArea
//            {
//                anchors.fill: parent;
//                hoverEnabled: true;

//                onEntered: parent.color = main.enteredColor;
//                onExited: parent.color = main.releasedColor;
//                onPressed: parent.color = main.pressedColor;

//                onReleased:
//                {
//                    parent.color = main.releasedColor;
//                    backButtonClicked();
//                }
//            }
//        }




    }

    function setTurn()
    {
        //sets the state of the toolbar
        if(GameTracker.xTurn) toolbar.state = "xTurn";
        else toolbar.state = "oTurn";
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
