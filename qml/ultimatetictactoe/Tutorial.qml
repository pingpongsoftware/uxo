import QtQuick 2.0
import "Scale.js" as Vals
import "GameTracker.js" as GameTracker

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    Text
    {
        id: title;

        text: "How to Play";
        //font.capitalization: Font.SmallCaps;
        font.bold: true;
        elide: Text.ElideMiddle;
        font.pixelSize: 48;
        font.letterSpacing: 2;
        font.wordSpacing: 0;
        font.family: prime_reg.name;
        color: "white";
        opacity: .5;

        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: main.top;
        anchors.margins: 25;
    }

    Grid
    {
        id: bigGrid;

        width:
        {
            Vals.outerGridHeight /= 1.5;
            Vals.outerGridWidth /= 1.5;
            Vals.innerGridHeight /= 1.5;
            Vals.innerGridWidth /= 1.5;
            Vals.innerRectHeight /= 1.5;
            Vals.innerRectWidth /= 1.5;
            Vals.squareHeight /= 1.5;
            Vals.squareWidth /= 1.5;
            Vals.bigGridSpacing *= 3;
        }

        spacing: Vals.bigGridSpacing;
        rows: Vals.rows;
        columns: Vals.columns;

        x: spacing*2;
        y: spacing*3.5;

        Component.onCompleted:
        {
            Vals.outerGridHeight *= 1.5;
            Vals.outerGridWidth *= 1.5;
            Vals.innerGridHeight *= 1.5;
            Vals.innerGridWidth *= 1.5;
            Vals.innerRectHeight *= 1.5;
            Vals.innerRectWidth *= 1.5;
            Vals.squareHeight *= 1.5;
            Vals.squareWidth *= 1.5;
            Vals.bigGridSpacing /= 3;
        }


        Repeater
        {
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

                    if (canClick)
                    {
                        console.log("can click");
                    }
                }
            }
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

    BottomToolbar
    {
        id: test;
        anchors.bottom: main.bottom;
        anchors.horizontalCenter: parent;
    }
}
