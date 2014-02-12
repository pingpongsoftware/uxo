import QtQuick 2.0
import "GameTracker.js" as GameTracker_js

Item
{
    id: main;
    state: Vals.theme;

    width: Vals.screenWidth;
    height: Vals.topToolbarHeight;

    signal backButtonPressed();

    states:
    [
        State { name: "dark" },
        State { name: "light" }
    ]

    onStateChanged: toolbarRect.state = state;

    Rectangle
    {
        id: toolbarRect;
        state: Vals.theme;
        anchors.fill: parent;
        opacity: 1;

        states:
        [
            State { name: "dark"; PropertyChanges { target: toolbarRect; color: "gray"; } },
            State { name: "light"; PropertyChanges { target: toolbarRect; color: "#cc0000"; } }
        ]

        transitions:
        [
            Transition
            {
                from: "*"; to: "*";
                PropertyAnimation { target: toolbarRect; properties: "color"; duration: Vals.transitionTime; }
            }
        ]

        Rectangle
        {
            id: toolbarLine;
            anchors.top: parent.bottom;
            width: parent.width;
            height: parent.height/40;
            color:
            {
                if (parent.state === "light")
                    "black";
                else
                    "lightgray";
            }
        }

    }

    Rectangle  //for the back button
    {
        id: backRect;
        color: "black";
        height: parent.height;
        width: height;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left
        opacity: 0;

        function changeOpacity()
        {
            backImage.opacity = 1;
            backRect.opacity = 0;
        }

        MouseArea
        {
            anchors.fill: parent;

            onPressed: { backImage.opacity = .5; backRect.opacity = .5 }
            onExited: parent.changeOpacity();
            onCanceled: parent.changeOpacity();

            onClicked:
            {
                backRect.changeOpacity();

                backButtonPressed();
                GameTracker_js.resetGame();
            }
        }
    }

    Image
    {
        id: backImage;
        source: "Images/backArrow.png";
        width: backRect.width;
        height: backRect.height;
        sourceSize.height: width;
        sourceSize.width: width;
        anchors.centerIn: backRect;
    }

    Text
    {
        id: titleText;

        anchors.left: backRect.right;
        anchors.leftMargin: backRect.width/2;
        anchors.verticalCenter: main.verticalCenter;
        font.pixelSize: Vals.extraSmallFontSize;
        color: "white";

        text: "uXO:  Ultimate Tic-Tac-Toe";
    }
}
