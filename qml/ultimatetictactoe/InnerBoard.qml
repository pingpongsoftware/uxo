import QtQuick 2.0
import "GameTracker.js" as GameTracker

Rectangle
{
    id: main;
    width: Vals.INNER_RECT_SIZE;
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
            if (main.canClick)
                "Images/greenOutline.png"
            else
                "Images/transparent.png"
        }
    }

    Image
    {
        id: playerWinImage;
        width: main.width;
        height: main.height;
        sourceSize.width: main.width*1.5;
        sourceSize.height: main.width*1.5;
    }

    Grid
    {
        id: littleGrid;
        rows: Vals.ROWS;
        columns: rows;
        spacing: Vals.SMALL_GRID_SPACING;
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

            if(GameTracker.squareWon[GameTracker.bigIndex][i] === 1)
            {
                smallSquareAtIndex.state = "wonByX";
            }
            else if(GameTracker.squareWon[GameTracker.bigIndex][i] === -1)
            {
                smallSquareAtIndex.state = "wonByO";
            }
            else
            {
                smallSquareAtIndex.state = "default";
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
            PropertyChanges{ target: playerWinImage; source: "Images/x.png" }
            PropertyChanges{ target: littleGridRepeater.itemAt(0); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(1); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(2); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(3); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(4); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(5); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(6); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(7); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(8); smallSquareOpacity: .5; smallSquareColor: "#9999ff"; }
        },

        State
        {
            name: "wonByO";
            PropertyChanges{ target: playerWinImage; source: "Images/o.png" }
            PropertyChanges{ target: littleGridRepeater.itemAt(0); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(1); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(2); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(3); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(4); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(5); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(6); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(7); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
            PropertyChanges{ target: littleGridRepeater.itemAt(8); smallSquareOpacity: .5; smallSquareColor: "#f88b8b"; }
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
                target: littleGrid;
                properties: "opacity";
                duration: 1000
            }
        }
    ]
}

