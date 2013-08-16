import QtQuick 2.0
import "Scale.js" as Vals
import "GameTracker.js" as GameTracker

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


    Grid
    {
        id: bigGrid;
        //spacing: Vals.bigGridSpacing;
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
                        GameTracker.makeMove(smallIndex, index);
                        highlightPlayableBoards(smallIndex, GameTracker.checkForDeadSquare())
                        assignSquares(); //method in InnerBoard
                        assignBoards();
                        toolbar.setTurn();

                        message.visible = false;
                        numInvalidPresses = 0;
                    }
                    else
                    {
                        numInvalidPresses++;

                        if (numInvalidPresses >= 5)
                        {
                            message.visible = true;
                            message.state = "invalidSquareClickedMessage";
                        }
                    }

                    //shows the message when the game is over.
                    if (GameTracker.gameWon)
                    {
                        message.visible = true;
                        message.state = "gameOverMessage";
                    }
                }
            }
        }
    }

    Toolbar
    {
        id: toolbar;

        height: Vals.toolbarHeight;
        width: main.width;

        anchors.bottom: main.bottom;
        anchors.bottomMargin: Vals.bigGridSpacing/2;
        anchors.horizontalCenter: main.horizontalCenter;

//        onResetButtonClicked:
//        {
//            resetGame();
//        }

        onBackButtonClicked:
        {

        }
    }

    Message
    {
        id: message;
        anchors.fill: parent;
        visible: false;

        onGameOverButtonClicked:
        {
            resetGame();
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

            if(GameTracker.boardWon[i] === 1)
            {
                boardAtIndex.state = "wonByX";
            }
            else if(GameTracker.boardWon[i] === -1)
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
        GameTracker.resetGame();

        for(var i=0; i<bigGridRepeater.count; i++)
        {
            bigGridRepeater.itemAt(i).assignSquares();
            bigGridRepeater.itemAt(i).canClick = true;
        }
        assignBoards();
        toolbar.setTurn();
    }
}

