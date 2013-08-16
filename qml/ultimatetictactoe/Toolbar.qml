import QtQuick 2.0;
import "Scale.js" as Vals;
import "GameTracker.js" as GameTracker;

Rectangle
{
    id: main;
    width: Vals.toolbarWidth;
    height: Vals.toolbarHeight;
    color: "transparent";
    state: "xTurn";

    signal resetButtonClicked();
    signal backButtonClicked();

    property color releasedColor: Qt.rgba(0,0,0,.5);
    property color enteredColor: Qt.rgba(0,0,0,.75);
    property color pressedColor: Qt.rgba(0,0,0,1);

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    Flow // automatically formats the toolbar in a flow layout
    {
        id: flowLayout;
        width: parent.width;
        height: parent.height;
        x: 14;
        anchors.margins: 5;
        spacing: 115;

        Image
        {
            id: xImage;
            source: "Images/x.png";
        }

        Rectangle // back button
        {
            id: backRect

            width: 90;
            height: parent.height - 10;
            color: main.releasedColor;
            radius: 7;

            Image
            {
                id: backImage;
                anchors.fill: parent;
                source: "Images/backArrow.png";
                fillMode: Image.PreserveAspectFit;
            }

//            Text
//            {
//                text: "Menu";
//                color: "white";
//                opacity: .4;
//                font.family: prime_reg.name;
//                font.pixelSize: 20;
//                anchors.centerIn: parent;
//            }

            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: parent.color = main.enteredColor;
                onExited: parent.color = main.releasedColor;
                onPressed: parent.color = main.pressedColor;

                onReleased:
                {
                    parent.color = main.releasedColor;
                    backButtonClicked();
                }
            }
        }

        Rectangle // reset button
        {
            id: resetButton

            width: 150;
            height: parent.height - 10;
            color: main.releasedColor;
            radius: 7;

            Text
            {
                text: "Reset Game";
                color: "white";
                opacity: .4;
                font.family: prime_reg.name;
                font.pixelSize: 20;
                anchors.centerIn: parent;
            }

            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: parent.color = main.enteredColor;
                onExited: parent.color = main.releasedColor;
                onPressed: parent.color = main.pressedColor;

                onReleased:
                {
                    GameTracker.resetGame();
                    resetButtonClicked();
                }
            }
        }

        Image
        {
            id: oImage;
            source: "Images/o.png";
        }

    }

    function setTurn()
    {
        //sets the state of the toolbar
        if(GameTracker.xTurn) toolbar.state = "xTurn";
        else toolbar.state = "oTurn";
    }

    states:
    [
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
                height: main.height - Vals.bigGridSpacing*1.5;
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
                height: main.height - Vals.bigGridSpacing*1.5;
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
