import QtQuick 2.0


Rectangle
{
    id: main;
    width: Vals.innerRectSize*scale;
    height: width
    state: "z"
    radius: 10;
    color: "transparent";
    //layer.enabled: true;

    property double scale;

    property bool canClick: true;

    // passes the index of the small tic tac toe square into the main file when a small tile is clicked
    signal boardClicked(int smallIndex, bool isValid);
    signal pressedAndHeld(var x, var y);

    property int gridIndex; //the index, 0-8, of the grid

	Component.onCompleted: console.log(gridIndex);

    function printLoc()
    {
        var s = main.toString() + ":  " + main.x + ", " + main.y;
		//console.log(s)
        return s;
    }

    Rectangle
    {
        id: outlineRect;
        width: parent.width*.97;
        height: width;

        anchors.centerIn: parent;

        color: "transparent";
        border.width:
        {
            if (main.canClick === true)
                width/60;
            else
                0;
        }

        border.color: "green";
    }

    Image
    {
        id: playerBigWinImage;
        width: main.width*.95;
        height: main.height*.95;
        anchors.centerIn: parent;
        sourceSize.width: width;
        sourceSize.height: height;
        opacity: .6;
        asynchronous: true;
    }

    Grid
    {
        id: littleGrid;
        rows: Vals.rows;
        columns: rows;
        spacing: Vals.smallGridSpacing * main.scale;
        anchors.centerIn: parent;

        Repeater
        {
            id: littleGridRepeater;
            model: 9;

            TicTacToeSquare
            {
                scale: main.scale;
                //sets the index of each square to the index of the gridcell its placed in
                smallSquareIndex: index;
                smallSquareCanClick: canClick; //if the big square can't be clicked, the small square can't be clicked
                gridIndex: main.gridIndex;

                onInvalidSquareClicked:
                {
                    boardClicked(smallSquareIndex, false);
                }

                onSquareClicked:
                {
                    boardClicked(smallSquareIndex, true);
                }

                onPressedAndHeld:
                {
                    main.pressedAndHeld(x, y);  //x and y passed in TicTacToeSquare.qml
                }
            }
        }
    }

    function assignSquares()
    {
        for(var i=0; i<littleGridRepeater.count; i++)
        {
            var smallSquareAtIndex = littleGridRepeater.itemAt(i);

			if (GameTracker.squareWon(GameTracker.bigIndex, i) === "x") //if (GameTracker_js.squareWon[GameTracker_js.bigIndex][i] === 1)
            {
                smallSquareAtIndex.setTTTStates("wonByX"); //an individual square was won by x, so it will now have an x on it
            }
			else if(GameTracker.squareWon(GameTracker.bigIndex, i) === "o")
            {
                smallSquareAtIndex.setTTTStates("wonByO"); //same as wonByX, but for O.
            }
            else
            {
                smallSquareAtIndex.setTTTStates("default");  // no X or O on the corresponding square
            }
        }
    }


    function setStates(str)
    {
        innerBoardStates.state = str;
    }

    Item
    {
        id: innerBoardStates;
        state: "default";
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


}
