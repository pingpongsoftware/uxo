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


    Rectangle
    {
        id: gameRect;
        //centers the grid in the middle of the toolbars.
        width: parent.width;
        height: Vals.outerGridSize;
        anchors.horizontalCenter: parent.horizontalCenter;
        y: Vals.backButtonHeight; //puts the top of the grid at the bottom of the back button
        color: "transparent";
        //opacity: .5;

        Flickable  //allows user to move around the board when zoomed in
        {
            width: parent.width;
            height: parent.height;
            anchors.centerIn: parent;

            Rectangle  // this rectangle is so you can see how big the gameRect is (if it is set to not transparent)
            {
                anchors.fill: parent;
                color: "transparent";
                opacity: .5;
            }

            flickableDirection:
            {
                if (Vals.isGameZoomedIn)
                    Flickable.HorizontalAndVerticalFlick
            }


            Grid
            {
                id: bigGrid;
                rows: Vals.rows;
                columns: rows;
                anchors.centerIn: parent;
                width: Vals.outerGridSize;
                height: width;

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

            contentWidth: bigGrid.width;
            contentHeight: bigGrid.height;
        }


    }


    BottomToolbar
    {
        id: bottomToolbar;

        height: main.height / 7;
        width: main.width;

        //anchors.bottom: main.bottom;
        anchors.top: gameRect.bottom;
        anchors.horizontalCenter: main.horizontalCenter;
        //anchors.bottomMargin: height/2;

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
                boardAtIndex.state = "wonByX";
            }
            else if(GameTracker_js.boardWon[i] === -1)
            {
                boardAtIndex.state = "wonByO";
            }
            else
            {
                boardAtIndex.state = "default";
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

