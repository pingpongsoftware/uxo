import QtQuick 2.0
import "GameTracker.js" as GameTracker_js

Rectangle
{
    id: main;
    width: Vals.innerRectSize;
    height: width
    state: "default"
    radius: 10;
    color: "transparent";

    property bool canClick: true;

    // passes the index of the small tic tac toe square into the main file when a small tile is clicked
    signal boardClicked(int smallIndex, bool isValid);

    Image
    {
        id: greenOutline;
        anchors.fill: parent;
        smooth: true;
        sourceSize.width: main.width;
        sourceSize.height: main.height;

        source:
        {
            if (main.canClick === true)
                "Images/" + Vals.theme + "/outline.png";
            else
                "Images/transparent.png"
        }
    }

    Image
    {
        id: playerBigWinImage;
        width: main.width;
        height: main.height;
        sourceSize.width: main.width*1.5;
        sourceSize.height: main.width*1.5;
    }

    Grid
    {
        id: littleGrid;
        rows: Vals.rows;
        columns: rows;
        spacing: Vals.smallGridSpacing;
        anchors.centerIn: parent;

        Repeater
        {
            id: littleGridRepeater;
            model: 9;

            TicTacToeSquare
            {
                //sets the index of each square to the index of the gridcell its placed in
                smallSquareIndex: index;
                smallSquareCanClick: canClick; //if the big square can't be clicked, the small square can't be clicked

                onInvalidSquareClicked:
                {
                    boardClicked(smallSquareIndex, false);
                }

                onSquareClicked:
                {                    
                    boardClicked(smallSquareIndex, true);
                }   
            }
        }
    }

    function assignSquares()
    {
        for(var i=0; i<littleGridRepeater.count; i++)
        {
            var smallSquareAtIndex = littleGridRepeater.itemAt(i);

            if (GameTracker_js.squareWon[GameTracker_js.bigIndex][i] === 1)  //(GameTracker.get2DVal(GameTracker.squaresWon, GameTracker.bigIndex, i) === 1)
            {
                smallSquareAtIndex.state = "wonByX"; //an individual square was won by x, so it will now have an x on it
            }
            else if(GameTracker_js.squareWon[GameTracker_js.bigIndex][i] === -1)
            {
                smallSquareAtIndex.state = "wonByO"; //same as wonByX, but for O.
            }
            else
            {
                smallSquareAtIndex.state = "default";  // no X or O on the corresponding square
            }
        }
    }

    states:
    [
        State
        {
            name: "default";
        },

        State
        {
            name: "wonByX";
            PropertyChanges
            {
                target: playerBigWinImage; source: "Images/" + Vals.theme + "/x.png";
                opacity:  // I only used opacity because I needed somewhere to put a for loop.  The actual loop has nothing to do with opacity.
                {
                    for (var i = 0; i < littleGridRepeater.count; i++)
                        littleGridRepeater.itemAt(i).changeColor("x");
                }
            }
        },

        State
        {
            name: "wonByO";
            PropertyChanges
            {
                target: playerBigWinImage; source: "Images/" + Vals.theme + "/o.png";
                opacity:  // I only used opacity because I needed somewhere to put a for loop.  The actual loop has nothing to do with opacity.
                {
                    for (var i = 0; i < littleGridRepeater.count; i++)
                        littleGridRepeater.itemAt(i).changeColor("o");
                }
            }
        }
    ]
}

