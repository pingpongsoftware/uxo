import QtQuick 2.0

Rectangle
{
    id: main;
    color: "transparent";
    state: "z";
    width: Vals.squareSize*scale;
    height: width;

    property double scale;

    property string imageSource: "tttsquare.png";

    property int smallSquareIndex;  //index, 0-8, of each cell in the tic tac toe grid
    property bool smallSquareCanClick: true;
    property int gridIndex;  //Which grid it is located in, 0-8.

    signal squareClicked();
    signal invalidSquareClicked();
    signal pressedAndHeld(var x,  var y);

    property string winningPlayer: "";

    property bool clickEnabled: true;


    function changeColor(player)
    {
        winningPlayer = player;
    }


	Component.onCompleted:
	{
		if (GameTracker.squareWon(main.gridIndex, main.smallSquareIndex) === "x")
		{
			main.setTTTStates("wonByX");
			main.winningPlayer = "x";
		}

		else if (GameTracker.squareWon(main.gridIndex, main.smallSquareIndex) === "o")
		{
			main.setTTTStates("wonByO");
			main.winningPlayer = "o"
		}
	}

    Rectangle
    {
        id: fillRect;
        anchors.fill: parent;
        property color emptyColor:
        {
            if (Vals.theme === "dark")
                "white";
            else
                "black";
        }

        color:
        {
            if (winningPlayer == "x")
            {
                color = "steelblue";
                opacity = .5;
            }
            else if (winningPlayer == "o")
            {
                color = "firebrick"
                opacity = .5;
            }
            else
                emptyColor;
        }

        opacity: .1
    }

    MouseArea
    {
        id: squareMouseArea;
        anchors.fill: parent;

        onPressAndHold:
        {
            main.pressedAndHeld(mouse.x, mouse.y);
        }

        onClicked:
        {
            if (clickEnabled)
            {
                if (smallSquareCanClick)
                    squareClicked();

                else
                    invalidSquareClicked();
            }
        }
    }

    Image
    {
        id: playerWinImage;
        anchors.fill: parent;
        sourceSize.width: main.width;
        sourceSize.height: main.height;
        smooth: true;
        asynchronous: true;
    }


    function setTTTStates(str)
    {
        tttStates.state = str;
    }

    Item
    {
        id: tttStates;

        states:
        [
            State
            {
                name: "default"

                PropertyChanges
                {
                    target: main;
                }
            },

            State
            {
                name: "wonByX";

                PropertyChanges
                {
                    target: playerWinImage;
                    source: "Images/" + Vals.theme + "/x.png";
                }
                PropertyChanges
                {
                    target: main;
                    smallSquareCanClick: false;
                }

            },

            State
            {
                name: "wonByO";

                PropertyChanges
                {
                    target: playerWinImage;
                    source: "Images/" + Vals.theme + "/o.png";
                }
                PropertyChanges
                {
                    target: main;
                    smallSquareCanClick: false;
                }
            }
        ]
    }


}
