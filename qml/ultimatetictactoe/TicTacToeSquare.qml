import QtQuick 2.0

Rectangle
{
    id: main;
    width: Vals.SQUARE_SIZE
    height: Vals.SQUARE_SIZE;
    color: "transparent";

    property int smallSquareIndex;  //index, 0-8, of each cell in the tic tac toe grid
    property bool smallSquareCanClick: true;
    property double smallSquareOpacity: .7;
    property color smallSquareColor: "gray";

    signal squareClicked();
    signal invalidSquareClicked();

    Rectangle
    {
        id: visibleRect; //this is the rect that actually shows up

        color: main.smallSquareColor;

        anchors.fill: parent;
        opacity: main.smallSquareOpacity;

        MouseArea
        {
            id: squareMouseArea;
            anchors.fill: parent;

            onClicked:
            {
                if (smallSquareCanClick)
                    squareClicked();

                else
                    invalidSquareClicked();
            }
        }
    }

    Image
    {
        id: playerWinImage;
        anchors.fill: parent;
    }

    states:
    [
        State
        {
            name: "default"

            PropertyChanges
            {
                target: main;
            }
        },

        State
        {
            name: "wonByX";

            PropertyChanges
            {
                target: playerWinImage;
                source: "Images/x.png"
            }
            PropertyChanges
            {
                target: main;
                smallSquareCanClick: false;
            }
        },

        State
        {
            name: "wonByO";

            PropertyChanges
            {
                target: playerWinImage;
                source: "Images/o.png"
            }
            PropertyChanges
            {
                target: main;
                smallSquareCanClick: false;
            }
        }
    ]
}


