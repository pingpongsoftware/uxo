import QtQuick 2.0
import "GameTracker.js" as GameTracker_js

Item
{
    id: main;
    width: Vals.SCREEN_WIDTH;
    height: Vals.SCREEN_HEIGHT;

    property int numInvalidPresses: 0;

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    signal topToolbarBackButtonClicked();


    Rectangle
    {
        id: titleRect;
        width: main.width;
        height: 35;
        color: Qt.rgba(0,0,0,.2);

        Text
        {
            id: titleText;
            font.family: prime_lite.name;
            font.pixelSize: Vals.SMALL_FONT_SIZE;
            text: "Ultimate Tic Tac Toe";
            color: "gray";
            anchors.centerIn: parent;
        }
    }

    Rectangle
    {
        id: topToolbarGradient;
        anchors.top: topToolbar.top;
        width: main.width;
        height:topToolbar.height * 1.6;
        gradient: Gradient
        {
            //GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.18); }
            GradientStop { position: 0.31; color: Qt.rgba(1, 1, 1, 0.15); }
            GradientStop { position: 0.59; color: Qt.rgba(1, 1, 1, 0.1); }
            GradientStop { position: .85; color: Qt.rgba(1, 1, 1, 0.015); }
            GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.0); }
        }
    }

    TopToolbar
    {
        id: topToolbar;

        width: main.width;
        //makes the toolbar fill the space between the board and the top of the screen
        height: main.height / 12;
        color: "transparent";

        onBackButtonClicked:
        {
            topToolbarBackButtonClicked();
        }

        anchors.top: titleRect.bottom;
    }

    Rectangle
    {
        //centers the grid in the middle of the toolbars.
        width: parent.width;
        height: parent.height - topToolbar.height - titleRect.height - bottomToolbar.height;
        anchors.horizontalCenter: parent.horizontalCenter;
        y: titleRect.height + topToolbar.height;
        color: "transparent";

        Grid
        {
            id: bigGrid;
            rows: Vals.ROWS;
            columns: rows;
            anchors.centerIn: parent;
            width: Vals.OUTER_GRID_SIZE;
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
                            assignSquares(); //method in InnerBoard
                            assignBoards();
                            bottomToolbar.setTurn();

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
                        if (GameTracker_js.gameWon)
                        {
                            message.visible = true;
                            message.state = "gameOverMessage";
                        }
                    }
                }
            }
        }
    }


    Rectangle
    {
        id: bottomToolbarGradient;
        anchors.bottom: bottomToolbar.bottom;
        width: main.width;
        height:bottomToolbar.height * 1.6;
        gradient: Gradient
        {
            GradientStop { position: 0.0; color: Qt.rgba(1, 1, 1, 0.0); }
            GradientStop { position: 0.15; color: Qt.rgba(1, 1, 1, 0.015); }
            GradientStop { position: 0.40; color: Qt.rgba(1, 1, 1, 0.1); }
            GradientStop { position: .69; color: Qt.rgba(1, 1, 1, 0.15); }
            //GradientStop { position: 1.0; color: Qt.rgba(1, 1, 1, 0.18); }
        }
    }

    BottomToolbar
    {
        id: bottomToolbar;

        height: main.height / 7;
        width: main.width;



        anchors.bottom: main.bottom;
        anchors.horizontalCenter: main.horizontalCenter;

//        onResetButtonClicked:
//        {
//            resetGame();
//        }
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

            if(GameTracker_js.boardWon[i] === 1)
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

        for(var i=0; i<bigGridRepeater.count; i++)
        {
            bigGridRepeater.itemAt(i).assignSquares();
            bigGridRepeater.itemAt(i).canClick = true;
        }
        assignBoards();
        bottomToolbar.setTurn();
    }


}

