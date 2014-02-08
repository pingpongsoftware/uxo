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

    function zoomGame()
    {
        if (zStates.state === "z1")
            zStates.state = "z2"
        else if (zStates.state === "z2")
            zStates.state = "z1"

        bigGrid.state = zStates.state;

        for (var i = 0; i < bigGridRepeater.model; i++)
            bigGridRepeater.itemAt(i).zoomGame();
    }

    Rectangle  //this item is solely for the purpose of having a place to put the states for the zoom function
    {
        id: zStates;
        state: "z1";
        opacity: .3

        states:  //I have two identical states because I need it to update when the variables in Vals update.
        [
            State
            {
                name: "z1";
                PropertyChanges { target: gameFlickable; contentWidth: Vals.outerGridSize; contentHeight: Vals.outerGridSize; }
            },
            State
            {
                name: "z2";
                PropertyChanges { target: gameFlickable; contentWidth: Vals.outerGridSize; contentHeight: Vals.outerGridSize; }
            }
        ]
    }


    Rectangle
    {
        id: gameRect;
        //centers the grid in the middle of the toolbars.
        width: parent.width;
        height: parent.width;
        anchors.horizontalCenter: main.horizontalCenter;
        y: (Vals.backButtonHeight + bottomToolbar.y)/2 - height/2; //this algorithm centers the grid between the back button and the bottom toolbar
        color: "transparent";
        //opacity: .5;  //for debugging purposes

        Flickable  //allows user to move around the board when zoomed in
        {
            id: gameFlickable;
            width: parent.width;
            height: parent.height;
            anchors.centerIn: parent;            

            contentWidth: Vals.outerGridSize;
            contentHeight: Vals.outerGridSize;

            flickableDirection:
            {
                if (Vals.isGameZoomedIn)
                    Flickable.HorizontalAndVerticalFlick
            }

            Rectangle  // this rectangle is so you can see how big the gameRect is (if it is set to not transparent)
            {
                anchors.fill: parent;
                color: "transparent";
                opacity: .3;
            }


            Grid
            {
                id: bigGrid;
                rows: Vals.rows;
                columns: rows;
                state: "z1";

                states:  //I have two identical states because I need it to update when the variables in Vals update.
                [
                    State
                    {
                        name: "z1";
                        PropertyChanges { target: bigGrid; width: Vals.outerGridSize; height: Vals.outerGridSize; }
                    },
                    State
                    {
                        name: "z2";
                        PropertyChanges { target: bigGrid; width: Vals.outerGridSize; height: Vals.outerGridSize; }
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
                boardAtIndex.setIbStates("wonByX");
            }
            else if(GameTracker_js.boardWon[i] === -1)
            {
                boardAtIndex.setIbStates("wonByO");
            }
            else
            {
                boardAtIndex.setIbStates("default");
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

