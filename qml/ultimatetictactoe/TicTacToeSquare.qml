import QtQuick 2.0

Rectangle
{
    id: main;
    color: "transparent";
    state: "z";
    width: Vals.squareSize;
    height: width;

    property string imageSource: "tttsquare.png";

    property int smallSquareIndex;  //index, 0-8, of each cell in the tic tac toe grid
    property bool smallSquareCanClick: true;


    signal squareClicked();
    signal invalidSquareClicked();

    property string winningPlayer: "";

    function changeColor(player)
    {
        winningPlayer = player;
    }

    Rectangle
    {
        id: fillRect;
        anchors.fill: parent;
        property color emptyColor:
        {
            if (Vals.theme === "dark")
                "white";
            else
                "black";
        }

        color:
        {
            if (winningPlayer == "x")
            {
                color = "steelblue";
                opacity = .5;
            }
            else if (winningPlayer == "o")
            {
                color = "firebrick"
                opacity = .5;
            }
            else
                emptyColor;
        }
        opacity: .1
    }

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

    Image
    {
        id: playerWinImage;
        anchors.fill: parent;
        sourceSize.width: main.width*2;
        sourceSize.height: main.height*2;
        smooth: true;
    }


    function setTTTStates(str)
    {
        tttStates.state = str;
    }

    Item
    {
        id: tttStates;

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
                    source: "Images/" + Vals.theme + "/x.png";
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
                    source: "Images/" + Vals.theme + "/o.png";
                }
                PropertyChanges
                {
                    target: main;
                    smallSquareCanClick: false;
                }
            }
        ]
    }


}
