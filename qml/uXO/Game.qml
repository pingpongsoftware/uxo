import QtQuick 2.0
import "GameTracker.js" as GameTracker_js

Item
{
    id: main;
    width: Vals.screenWidth;
    height: Vals.screenHeight;

    property int numInvalidPresses: 0;

    signal exitButtonClicked();
    signal resetButtonClicked();
    signal helpButtonClicked();

    Rectangle
    {
        id: zoomBounds; //the grid will only appear inside this rect;
        width: main.width;
        height: main.height - Vals.topToolbarHeight - bottomToolbar.height - bottomToolbar.anchors.bottomMargin;
        color: "transparent";
        y: Vals.topToolbarHeight;
        clip: true;

        Rectangle
        {
            id: gameRect;
            width: main.width;
            height: main.width;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.verticalCenter: parent.verticalCenter;
            color: "transparent";
            //opacity: .5;  //for debugging purposes

            PinchArea  //I'm not actually using the pinch area how it was intended.  Instead I have a "dummy" target, so I can sense when the pinch occurs and use the zoom function in gridFlick to zoom it.
            {
                id: gridPinch;
                pinch.target: pinchRect;
                pinch.minimumScale: 1.0;
                pinch.maximumScale: 1.5;
                pinch.dragAxis: Pinch.NoDrag;
                anchors.fill: parent;

                property double oldScale: 1.0;

                property int frameCounter: 0;

                property int xPoint;
                property int yPoint;

                onPinchUpdated:
                {
                    if (frameCounter < 3 && frameCounter > 0)
                    {
                        //console.log("Scale: " + pinch.scale)
                        if (pinch.scale > oldScale)  //tests if they are zooming in
                            gridFlick.zoomIn(pinch.center.x, pinch.center.y)
                        else if (pinch.scale < oldScale)
                            gridFlick.zoomOut(pinch.center.x, pinch.center.y)

                        console.log("pinched: " + (pinch.scale > oldScale));
                        //console.log("oldScale: " + oldScale)
                    }

                    oldScale = pinch.scale;
                    frameCounter++;
                }

                onPinchFinished:
                {
                    frameCounter = 0;
                    oldScale = 1.0;
                }


                //---------------------------------------------------------------------------------------------------------
                // flickable and grid have to be in the pinch view or else the tic tac toe squares will not work
                Flickable
                {
                    id: gridFlick;
                    parent: gridPinch;
                    width: parent.width;
                    height: parent.height;
                    anchors.centerIn: parent;

                    flickableDirection: Flickable.AutoFlickDirection;

                    contentWidth: Vals.outerGridSize*scale;
                    contentHeight: contentWidth;

                    property double maxScale: 2.0;
                    property double minScale: 1.0
                    property double scale: minScale;

                    property double xPoint;
                    property double yPoint;

                    Behavior on scale   { NumberAnimation { duration: Vals.transitionTime; } }
                    Behavior on contentX   { NumberAnimation { duration: Vals.transitionTime; } }
                    Behavior on contentY   { NumberAnimation { duration: Vals.transitionTime; } }

                    function zoomIn(x, y)
                    {
                        console.log("In: " + scale)
                        if (scale === minScale)
                        {
                            console.log("Got In---");
                            gridFlick.setNewPos(x, y)
                            scale = maxScale;
                        }
                    }

                    function zoomOut(x, y)
                    {
                        console.log("Out: " + scale)
                        if (scale === maxScale)
                        {
                            gridFlick.setNewPos(0, 0);
                            scale = minScale;
                        }
                    }

                    function zoomInOrOut(x, y)  // if it not specified which way they are zooming
                    {
                        if (scale >= maxScale) // if they are already zoomed in
                            zoomOut(x, y);
                        else if (scale <= minScale)
                            zoomIn(x, y) //if they are zoomed out
                    }

                    function setNewPos(centerX, centerY)
                    {
                        contentX = (centerX/width) * contentWidth;
                        contentY = (centerY/height) * contentHeight;
                    }

                }

                Grid
                {
                    parent: gridFlick.contentItem;
                    id: bigGrid;
                    width: Vals.outerGridSize * gridFlick.scale;
                    height: width;
                    rows: Vals.rows;
                    columns: rows;
                    x: 0;
                    y: 0;

                    Repeater
                    {
                        anchors.centerIn: parent;
                        id: bigGridRepeater;
                        model: 9;

                        InnerBoard
                        {
                            scale: gridFlick.scale;
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

            //-------------------------------------------------------------------------------------------

            Rectangle { id: pinchRect; color: "transparent";} //this is here so the pinch area can have something as a target.
        }
    }


//    MouseArea
//    {
//        parent: gridFlick;
//        anchors.fill: parent;

//        onClicked:
//        {
//            gridFlick.zoom(mouse.x, mouse.y);
//            console.log("click")
//        }
//    }

    BottomToolbar
    {
        id: bottomToolbar;

        height: main.height / 7;
        width: main.width;

        anchors.bottom: main.bottom;
        anchors.bottomMargin: height/4;
        anchors.horizontalCenter: main.horizontalCenter;

        onResizeGame: zoomGame(); //signals Main.qml that the game has been resized
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
