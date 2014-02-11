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
    property int gridIndex;  //Which grid it is located in, 0-8.

    signal squareClicked();
    signal invalidSquareClicked();
    signal doubleClicked();

    property string winningPlayer: "";

    property bool clickEnabled: true;


    function changeColor(player)
    {
        winningPlayer = player;
    }


    //the MouseArea's mouse position is based on the tic tac toe square rather than the outer grid.
    //this function gets the real position of the mouse click based on the outer grid.
    function getRealClickLoc()
    {
        var xPos = squareMouseArea.mouseX;
        var yPos = squareMouseArea.mouseY;

        //----Adds to mouse position based on which grid it is in----------
        if (gridIndex % 3 === 0)
            xPos += 0;
        else if (gridIndex % 3 === 1)
            xPos += Vals.innerRectSize;
        else if (gridIndex % 3 === 2)
            xPos += Vals.innerRectSize*2;

        if (gridIndex < 3)
            yPos += 0;
        else if (gridIndex < 6)
            yPos += Vals.innerRectSize;
        else if (gridIndex < 9)
            yPos += Vals.innerRectSize*2;
        //-------------------------------------------------------------------

        //----Adds to mouse position based on which square it is in----------
        if (smallSquareIndex % 3 === 0)
            xPos += 0;
        else if (smallSquareIndex % 3 === 1)
            xPos += Vals.squareSize + Vals.smallGridSpacing;
        else if (smallSquareIndex % 3 === 2)
            xPos += Vals.squareSize*2 + Vals.smallGridSpacing*2;

        if (smallSquareIndex < 3)
            yPos += 0;
        else if (smallSquareIndex < 6)
            yPos += Vals.squareSize + Vals.smallGridSpacing;
        else if (smallSquareIndex < 9)
            yPos += Vals.squareSize*2 + Vals.smallGridSpacing*2;
        //-------------------------------------------------------------------

        console.log("Screen Size: " + Vals.screenWidth + ", " + Vals.screenHeight);
        return "Real Mouse Pos: " + xPos + ", " + yPos;

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

        onDoubleClicked:
        {
            main.doubleClicked();
        }

//        onClicked:
//        {
//            if (clickEnabled)
//            {
//                console.log("Touch Point: " + parent.mouseX + ", " + parent.mouseY);
//                console.log(main.getRealClickLoc());
//                console.log("grid index: " + main.gridIndex);

//                if (smallSquareCanClick)
//                    squareClicked();

//                else
//                    invalidSquareClicked();
//            }
//        }
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
