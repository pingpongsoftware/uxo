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
        height: main.height - Vals.topToolbarHeight - bottomToolbar.height - bottomToolbar.anchors.bottomMargin;
        color: "transparent";
        y: Vals.topToolbarHeight;
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
                pinch.maximumScale: 1.7;
                focus: false;

                property double oldScale: 1.0;

                property double xPoint;
                property double yPoint;

                onPinchUpdated:
                {
                    if (pinch.scale > oldScale)  //if they are zooming in
                    {
                        bigGrid.transformOrigin = getTransformOrigin(getIndex(pinch.center.x, pinch.center.y));
                        bigGrid.state = "zoomedOut";
                    }
                    else if (pinch.scale < oldScale) //if they are zooming out
                    {
                        bigGrid.state = "zoomedIn";
                    }

                    oldScale = scale;
                }

                function getIndex(x, y) //returns the index of the grid that the pinch occurs in
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


                function getTransformOrigin(index)
                {
                    if (index % 3 === 0)
                        xPoint = 0;
                    else if (index % 3 === 1)
                        xPoint = Vals.outerGridSize*1.5;
                    else
                        xPoint = Vals.outerGridSize*3;

                    if (index < 3)
                        yPoint = 0;
                    else if (index < 6)
                        yPoint = Vals.outerGridSize*1.5;
                    else
                        yPoint = Vals.outerGridSize*3;


                    if (index === 0)
                        return Item.TopLeft;
                    if (index === 1)
                        return Item.Top;
                    if (index === 2)
                        return Item.TopRight;
                    if (index === 3)
                        return Item.Left;
                    if (index === 4)
                        return Item.Center;
                    if (index === 5)
                        return Item.Right;
                    if (index === 6)
                        return Item.BottomLeft;
                    if (index === 7)
                        return Item.Bottom;
                    if (index === 8)
                        return Item.BottomRight;

                    console.log("Grid Index: " + gridIndexOfPinch);
                    return Item.Center;
                }


                Flickable
                {
                    id: gridFlick;
                    anchors.fill: parent;

                    flickableDirection: Flickable.AutoFlickDirection

                    Grid
                    {
                        id: bigGrid;
                        rows: Vals.rows;
                        columns: rows;
                        anchors.fill: parent;
                        state: "zoomedOut";

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

//                                onDoubleClicked:
//                                {
//                                    if (bigGrid.state === "zoomedIn")
//                                        bigGrid.state = "zoomedOut";
//                                    else
//                                    {
//                                        bigGrid.transformOrigin = gridPinch.getTransformOrigin(index);
//                                        bigGrid.state = "zoomedIn";
//                                    }

//                                    gridFlick.returnToBounds();
//                                    gridFlick.resizeContent(bigGrid.width, bigGrid.height, Qt.point(bigGrid.width/2, bigGrid.height/2))
//                                }
                            }
                        }


                        states:  //States for the big grid
                        [
                            State
                            {
                                name: "zoomedIn";
                                PropertyChanges { target: bigGrid; scale: gridPinch.pinch.maximumScale; }
                                PropertyChanges { target: gridFlick; contentWidth: Vals.outerGridSize*gridPinch.pinch.maximumScale; contentHeight: contentWidth; }
                            },
                            State
                            {
                                name: "zoomedOut";
                                PropertyChanges { target: bigGrid; scale: gridPinch.pinch.minimumScale; }
                                PropertyChanges { target: gridFlick; contentWidth: Vals.outerGridSize; contentHeight: contentWidth; }
                            }
                        ]

                        transitions:
                        [
                            Transition
                            {
                                from: "*"; to: "*";
                                NumberAnimation { target: bigGrid; property: "scale"; duration: 200; }
                            }

                        ]
                    }
                }
            }


            Rectangle
            {
                id: fcr
                width: gridFlick.contentItem.width;
                height: gridFlick.contentItem.height;
                x: gridFlick.contentItem.x;
                y: gridFlick.contentItem.y;
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
