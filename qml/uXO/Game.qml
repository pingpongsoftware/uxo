import QtQuick 2.0
import uxo.game 1.0

Rectangle
{
	id: main;

	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();

	color: "transparent";

	property Game game;
	property string winner;

	Component.onCompleted:
	{
		game = Tracker.getGame();
	}

	signal gameWon(var winner);

	Connections
	{
		target: game;

		onGameWon:
		{
			delayTimer.winner = winner;
			delayTimer.i1 = index1;
			delayTimer.i2 = index2;
			delayTimer.i3 = index3;

			delayTimer.start();
		}

		onGameWonDelayed:
		{
			main.winner = winner;
			winnerRect.setStartPos(index1, index3);
		}
	}

	Timer
	{
		id: delayTimer
		interval: 400;

		property string winner;
		property int i1;
		property int i2;
		property int i3;

		onTriggered:
		{
			game.callGameWonDelayed(winner, i1, i2, i3);
		}
	}


	Rectangle  //allows the board to be centered in between the top and bottom toolbars.
	{
		id: boardCenterRect;

		width: main.width;
		height: main.height - Vals.getTopToolbarHeight() - bottomToolbar.height;
		color: "transparent";
		y: Vals.getTopToolbarHeight();

		clip: true;

		Board
		{
			id: gameBoard;
			anchors.centerIn: parent;
		}
	}

	BottomToolbar
	{
		id: bottomToolbar;
		anchors.bottom: main.bottom;
		anchors.horizontalCenter: main.horizontalCenter;
	}

	Rectangle
	{
		id: winnerRect;
		width: 0;
		height: Vals.getBasicUnit()*2;

		gradient: Gradient
		{
			GradientStop
			{
				position: 0.0;
				color:
				{
					if (Vals.getTheme() === "dark")
						"lightgray";
					else
						"#444444";
				}
			}
			GradientStop
			{
				position: 1.0;
				color: "gray";
			}
		}

		opacity: .7;

		radius: height;

		transformOrigin: Item.Left;

		y: (boardCenterRect.height/2 + boardCenterRect.y) - (height/2);
		x: (boardCenterRect.width/2) - (width/2);

		function setStartPos(startIndex, endIndex)
		{
			var bigChange = Vals.getInnerBoardSize()*1.4 + Vals.getOuterGridSpacing();
			var smallChange = Vals.getInnerBoardSize() + Vals.getOuterGridSpacing();

			var acrossWidth = Vals.getInnerBoardSize()*2.8 + Vals.getOuterGridSpacing()*2;
			var diagonalWidth = Vals.getInnerBoardSize()*4 + Vals.getOuterGridSpacing()*2;

			if (startIndex === 0 && endIndex === 2)
			{
				x -= bigChange;
				y -= smallChange
				width = acrossWidth;
			}

			else if (startIndex === 0 && endIndex === 6)
			{
				rotation = 90;
				x -= smallChange;
				y -= bigChange
				width = acrossWidth;
			}

			else if (startIndex === 0 && endIndex === 8)
			{
				rotation = 45;
				x -= bigChange
				y -= bigChange
				width = diagonalWidth;
			}

			else if (startIndex === 1 && endIndex === 7)
			{
				rotation = 90;
				y -= bigChange;
				x += 0;
				width = acrossWidth;
			}

			else if (startIndex === 2 && endIndex === 6)
			{
				rotation = 90+45;
				y -= bigChange;
				x += bigChange;
				width = diagonalWidth;
			}

			else if (startIndex === 2 && endIndex === 8)
			{
				rotation = 90;
				y -= bigChange;
				x += smallChange;
				width = acrossWidth;
			}

			else if (startIndex === 3 && endIndex === 5)
			{
				x -= bigChange;
				y += 0;
				width = acrossWidth;
			}

			else if (startIndex === 6 && endIndex === 8)
			{
				x -= bigChange;
				y += smallChange;
				width = acrossWidth;
			}
		}

		Behavior on width { PropertyAnimation { duration: 1000; } }
	}

	DropDownMenu
	{
		id: dropDown;
		anchors.right: main.right;
		anchors.rightMargin: Vals.getBasicUnit()*4;
		y: Vals.getTopToolbarHeight()+1;

		width: 0;
		height: 0;

		Behavior on width { PropertyAnimation { duration: 200; } }
		Behavior on height { PropertyAnimation { duration: 200; } }

		Component.onCompleted:
		{
			dropDown.addToList("Help");
			dropDown.addToList("Options");
			dropDown.addToList("Resign");
		}

		Connections
		{
			target: Tracker;

			onDropDownButtonClicked:
			{
				if (dropDown.width === 0)
				{
					dropDown.width = dropDown.listContentWidth;
					console.log(dropDown.listContentWidth)

					dropDown.height = dropDown.listContentHeight;
				}

				else
				{
					dropDown.width = 0
					dropDown.height = 0;
				}
			}
		}

		onItemClicked:
		{
			if (buttonString === "Help")
			{
				Tracker.goToHelp();
			}

			else if (buttonString === "Options")
			{
				Tracker.goToOptions();
			}

			if (buttonString === "Resign")
			{
				Tracker.deleteGame();
				Tracker.goBack();
			}
		}
	}
}
