import QtQuick 2.0

Rectangle
{
    id: main;
    width: Vals.squareSize;
    height: Vals.squareSize;
    color: "transparent";

    property string imageSource: "tttsquare.png";

    property int smallSquareIndex;  //index, 0-8, of each cell in the tic tac toe grid
    property bool smallSquareCanClick: true;


    signal squareClicked();
    signal invalidSquareClicked();

    function changeColor(player)
    {
        if (player === "x")
            main.imageSource = "tttsquare_x.png";
        else if (player === "o")
            main.imageSource = "tttsquare_o.png";
    }


    Image
    {
        id: fillImage;
        source: "Images/" + Vals.theme + "/" + imageSource;
        anchors.fill: parent;
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


