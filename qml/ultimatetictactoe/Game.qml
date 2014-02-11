import QtQuick 2.0
import "GameTracker.js" as GameTracker_js


Item
{
    id: main;
    width: Vals.screenWidth;
    height: Vals.screenHeight;

    property int numInvalidPresses: 0;

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    signal exitButtonClicked();
    signal resetButtonClicked();
    signal helpButtonClicked();

    property int gridFlickContentSize: Vals.outerGridSize;


    Rectangle
    {
        id: zoomBounds; //the grid will only appear inside this rect;
        width: main.width;
        height: main.height - Vals.backButtonHeight - bottomToolbar.height - bottomToolbar.anchors.bottomMargin;
        color: "transparent";
        y: Vals.backButtonHeight;
        //clip: true;

        Rectangle
        {
            id: gameRect;
            width: main.width;
            height: main.width;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            color: "transparent";
            //opacity: .5;  //for debugging purposes


            PinchArea
            {
                id: gridPinch;
                pinch.target: bigGrid;
                pinch.dragAxis: Pinch.NoDrag;
                anchors.fill: parent;
                pinch.minimumScale: 1.0;
                pinch.maximumScale: 2.2;
                focus: false;

                onPinchUpdated:
                {
                    console.log(pinch.scale);

                    if (pinch.scale < 1.15 && pinch.scale > .85)
                        setTransformOrigin(getGridIndex(pinch.center.x, pinch.center.y));
                }

//                onPinchFinished:
//                {
//                    realScale *= pinch.scale;

//                    if (realScale < 1)
//                        realScale = 1;
//                    else if (realScale > 2)
//                        realScale = 2;

//                    main.gridFlickContentSize = Vals.outerGridSize*realScale;

//                    console.log(xPoint + "   " + yPoint);

//                    if (realScale != oldScale) //prevents the grid from recentering if you try to zoom while its already zoomed in
//                    {
//                        gridFlick.contentX = gridFlick.contentWidth*(xPoint/gridFlick.width) - xPoint;
//                        gridFlick.contentY = gridFlick.contentHeight*(yPoint/gridFlick.height) - yPoint;
//                    }

//                    console.log(gridFlick.contentX + "   " + gridFlick.contentY);

//                    oldScale = realScale;

//                }

                function setTransformOrigin(index)
                {
                    if (index === 0)
                        bigGrid.transformOrigin = Item.TopLeft;
                    else if (index === 1)
                        bigGrid.transformOrigin = Item.Top;
                    else if (index === 2)
                        bigGrid.transformOrigin = Item.TopRight;
                    else if (index === 3)
                        bigGrid.transformOrigin = Item.Left;
                    else if (index === 4)
                        bigGrid.transformOrigin = Item.Center;
                    else if (index === 5)
                        bigGrid.transformOrigin = Item.Right;
                    else if (index === 6)
                        bigGrid.transformOrigin = Item.BottomLeft;
                    else if (index === 7)
                        bigGrid.transformOrigin = Item.Bottom;
                    else if (index === 8)
                        bigGrid.transformOrigin = Item.BottomRight;
                    else
                        console.log("Grid Index: " + gridIndexOfPinch);
                }


                Grid
                {
                    id: bigGrid;
                    rows: Vals.rows;
                    columns: rows;
                    width: Vals.outerGridSize;
                    height: width;
                    anchors.centerIn: parent;

                    Repeater
                    {
                        anchors.centerIn: parent;
                        id: bigGridRepeater;
                        model: 9;

                        InnerBoard
                        {
                            onBoardClicked:
                            {
                                if (isValid)
                                {
                                    GameTracker_js.makeMove(smallIndex, index);
                                    highlightPlayableBoards(smallIndex, GameTracker_js.checkForDeadSquare())

        //                            GameTracker.makeMove(smallIndex, index);
        //                            highlightPlayableBoards(smallIndex, GameTracker.checkForDeadSquare());

                                    assignSquares(); //method in InnerBoard
                                    assignBoards();
                                    bottomToolbar.setTurn();

                                    invalidPressesMessage.visible = false;
                                    numInvalidPresses = 0;
                                }
                                else
                                {
                                    numInvalidPresses++;

                                    if (numInvalidPresses >= 5)
                                    {
                                        invalidPressesMessage.visible = true;
                                    }
                                }

                                //shows the message when the game is over.
                                if (GameTracker_js.gameWon) //(GameTracker.gameWon)
                                {
                                    gameOverMessage.visible = true;
                                }
                            }
                        }
                    }
                }
            }


            Rectangle  // this rectangle is so you can see how big the bigGrid is (if it is set to not transparent)
            {
                id: testRect
                width: bigGrid.width;
                height: bigGrid.height;
                x: bigGrid.x;
                y: bigGrid.y;
                color: "transparent";
                opacity: .3;
            }

        }
    }


    BottomToolbar
    {
        id: bottomToolbar;

        height: main.height / 7;
        width: main.width;

        anchors.bottom: main.bottom;
        anchors.bottomMargin: height/4;
        anchors.horizontalCenter: main.horizontalCenter;

        onResizeGame: zoomGame(); //signals Main.qml that the game has been resized

//        onResetButtonClicked:
//        {
//            resetGame();
//        }


    }

    Message
    {
        id: invalidPressesMessage;
        anchors.fill: parent;
        visible: false;

        messageText: "Remember, you can only play in a board that is highlighted green.";
        buttonOneText: "OK";
        buttonTwoText: "Help";

        onButtonOneClicked:
        {
            destroy();
        }

        onButtonTwoClicked:
        {
            helpButtonClicked();
            destroy();
        }
    }

    Message
    {
        id: gameOverMessage;
        anchors.fill: parent;
        visible: false;

        messageText: "Congratulations! " + GameTracker_js.winningPlayer + " has won the game!"
        buttonOneText: "Exit";
        buttonTwoText: "Rematch";

        onButtonOneClicked:
        {
            resetGame();
            destroy();
            exitButtonClicked();
        }

        onButtonTwoClicked:
        {
            resetGame();
            destroy();
        }
    }

    function getGridIndex(x, y) //returns the index of the grid that the pinch occurs in
    {
        if (x < Vals.innerRectSize)
        {
            if (y < Vals.innerRectSize)
                return 0;
            if (y < Vals.innerRectSize*2)
                return 3;
            if (y < Vals.innerRectSize*3)
                return 6;
        }
        if (x < Vals.innerRectSize*2)
        {
            if (y < Vals.innerRectSize)
                return 1;
            if (y < Vals.innerRectSize*2)
                return 4;
            if (y < Vals.innerRectSize*3)
                return 7;
        }
        if (x < Vals.innerRectSize*3)
        {
            if (y < Vals.innerRectSize)
                return 2;
            if (y < Vals.innerRectSize*2)
                return 5;
            if (y < Vals.innerRectSize*3)
                return 8;
        }

        return -1;
    }

    /*recieves the index of the small tic tac square that was clicked,
    and sets the corresponding large square to be clickable, unless
    the large square is already full, then it makes the rest of the
    squares clickable*/
    function highlightPlayableBoards(index, deadSquare)
    {
        for(var i=0; i < 9; i++)
        {
            bigGridRepeater.itemAt(i).canClick = deadSquare;
        }

        bigGridRepeater.itemAt(index).canClick = !deadSquare;
    }

    function assignBoards()
    {
        for(var i=0; i<bigGridRepeater.count; i++)
        {
            var boardAtIndex = bigGridRepeater.itemAt(i);

            if (GameTracker_js.boardWon[i] === 1) //(GameTracker.getVal(GameTracker.boardsWon, i) === 1)
            {
                boardAtIndex.setStates("wonByX");
            }
            else if(GameTracker_js.boardWon[i] === -1)
            {
                boardAtIndex.setStates("wonByO");
            }
            else
            {
                boardAtIndex.setStates("default");
            }
        }
    }

    function resetGame()
    {
        GameTracker_js.resetGame();
        //GameTracker.resetGame();

        for(var i=0; i<bigGridRepeater.count; i++)
        {
            bigGridRepeater.itemAt(i).assignSquares();
            bigGridRepeater.itemAt(i).canClick = true;
        }
        assignBoards();
        bottomToolbar.setTurn();
    }


}
