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

    onStateChanged: toolbarImageDark.state = state;

    Image
    {
        id: toolbarImageLight;
        anchors.fill: parent;
        sourceSize.width: width;
        sourceSize.height: height;
        source: "Images/light/topToolbar.png"
    }

    Image
    {
        id: toolbarImageDark;
        state: Vals.theme;
        anchors.fill: parent;
        sourceSize.width: parent.width;
        sourceSize.height: parent.height;
        source: "Images/dark/topToolbar.png"

        states:
        [
            State { name: "dark"; PropertyChanges { target: toolbarImageDark; opacity: 1; } },
            State { name: "light"; PropertyChanges { target: toolbarImageDark; opacity: 0; } }
        ]

        transitions:
        [
            Transition
            {
                from: "*"; to: "*";
                PropertyAnimation { target: toolbarImage; properties: "opacity"; duration: Vals.transitionTime; }
            }
        ]

    }

    Rectangle
    {
        id: toolbarLine;
        anchors.top: toolbarImageDark.bottom;
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
        font.pixelSize: Vals.mediumSmallFontSize;
        color: "white";

        text: "uXO:  Ultimate Tic-Tac-Toe";
    }
}
