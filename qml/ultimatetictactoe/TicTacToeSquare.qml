import QtQuick 2.0

Rectangle
{
    id: main;
    color: "transparent";
    state: "z1";

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

    function zoomGame()
    {
        if (main.state === "z1")
            main.state = "z2"
        else if (zStates.state === "z2")
            main.state = "z1"
    }


    states:  //I have two identical states because I need it to update when the variables in Vals update.
    [
        State
        {
            name: "z1";
            PropertyChanges { target: main; width: Vals.squareSize; height: Vals.squareSize; }
        },
        State
        {
            name: "z2";
            PropertyChanges { target: main; width: Vals.squareSize; height: Vals.squareSize; }
        }
    ]

    transitions:
    [
        Transition
        {
            from: "*"; to: "*";
            PropertyAnimation { properties: "width"; duration: Vals.transitionTime; }
            PropertyAnimation { properties: "height"; duration: Vals.transitionTime; }
        }
    ]

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


