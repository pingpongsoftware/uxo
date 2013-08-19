import QtQuick 2.0
import "GameTracker.js" as GameTracker_js;

Rectangle
{
    id: main;
    color: Qt.rgba(0,0,0,.7);

    signal invalidSquareButtonClicked();  //not currently used
    signal gameOverButtonClicked();

    Rectangle
    {
        anchors.centerIn: parent;
        width: 300;
        height: 130;
        color: Qt.rgba(0,0,0,.95);
        radius:5;

        Text
        {
            id: messageText;
            anchors.centerIn: parent
            width: parent.width - 10;
            height: parent.height - 10;
            color: "white"
            font.pixelSize: 20;
            wrapMode: Text.WordWrap;
        }

        Rectangle
        {
            id: button;
            width: parent.width;
            height: 40;
            radius: parent.radius;
            color: releasedColor;

            anchors.bottom: parent.bottom;
           // y: parent.height;

            property color releasedColor: Qt.rgba(.2,.2,.2,.9);
            property color pressedColor: Qt.rgba(.2,.7,.8,.95);
            property color hoverColor: Qt.rgba(.2,.25,.3,.95);

            Text
            {
                id: buttonText
                anchors.centerIn: parent;
                font.pixelSize: 24;
            }

            MouseArea
            {
                id: buttonMouseArea;
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: parent.color = parent.hoverColor;
                onExited: parent.color = parent.releasedColor;
                onPressed: parent.color = parent.pressedColor;
                onReleased:
                {
                    parent.color = parent.releasedColor;
                    main.visible = false;
                }
            }
        }   
    }

    states:
    [
        State
        {
            name: "invalidSquareClickedMessage"

            PropertyChanges
            {
                target: messageText;
                text: "Hint: you can only play in a small tic tac toe board that is highlighted green."
            }

            PropertyChanges
            {
                target: buttonText;
                text: "OK";
            }

            PropertyChanges
            {
                target: buttonMouseArea;
                onReleased:
                {
                    parent.color = parent.releasedColor;
                    main.visible = false;
                    invalidSquareButtonClicked();
                }
            }
        },

        State
        {
            name: "gameOverMessage"

            PropertyChanges
            {
                target: messageText;
                text: "Congratulations! " + GameTracker_js.winningPlayer + " has won the game!"
            }

            PropertyChanges
            {
                target: buttonText;
                text: "Play Again?";
            }

            PropertyChanges
            {
                target: buttonMouseArea;
                onReleased:
                {
                    parent.color = parent.releasedColor;
                    main.visible = false;
                    gameOverButtonClicked();
                }
            }
        }

    ]
}
