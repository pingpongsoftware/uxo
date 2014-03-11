import QtQuick 2.0
import uxo.game 1.0
import uxo.board 1.0
import uxo.innerboard 1.0
import uxo.square 1.0

Item
{
	id: main;

	width: Vals.getSquareSize() * scale;
	height: width;

	property int gridIndex;
	property int squareIndex;

	property Game game: Tracker.getGame();
	property Board board: game.getBoard();
	property InnerBoard innerBoard: board.getInnerBoardAt(gridIndex);
	property Square square: innerBoard.getSquareAt(squareIndex);

	property double scale;

	state: "-";

	Component.onCompleted: setState();

	Connections
	{
		target: innerBoard;

		onStateChanged: fillRect.changeColor(innerBoard.getState());
	}

	Connections
	{
		target: game;

		onGameWon:
		{
			squareImage.opacity = 0;

			if (gridIndex != index1 && gridIndex != index2 && gridIndex != index3)
				fillRect.changeColor("-")
		}
	}

	Rectangle
	{
		id: fillRect;
		anchors.fill: parent;

		property color emptyColor:
		{
			if (Vals.getTheme() === "light")
				emptyColor = "black";

			else if (Vals.getTheme() === "dark")
				emptyColor = "white";
		}

		color: changeColor(innerBoard.getState());
		opacity: .15;

		function changeColor(winner)
		{
			if (winner === "x")
			{
				color = "steelblue";
				opacity = .5;
			}
			else if (winner === "o")
			{
				color = "firebrick";
				opacity = .5;
			}

			else
			{
				color = emptyColor;
				opacity = .15;
			}
		}
	}

	MouseArea
	{
		anchors.fill: parent;
		onClicked:
		{
			main.game.click(main.gridIndex, main.squareIndex);
			main.setState();
		}

		onPressAndHold:
		{
			if (board.isZoomed())
				board.zoomOut(main.gridIndex);
			else
				board.zoomIn(main.gridIndex);
		}
	}

	Image  // this will be an x if the square was won by x, o if square was won by o, blank if neither.
	{
		id: squareImage;
		anchors.fill: parent;
		sourceSize.width: main.width*1.5;
		sourceSize.height: main.width*1.5;
		smooth: true;
		asynchronous: true;
		opacity: 1;

		Behavior on opacity { PropertyAnimation { duration: 600; } }
	}

	function setState()
	{
		main.state = main.square.getState();
	}

	states:
	[
		State
		{
			name: "-";  //square has not been clicked yet.
			PropertyChanges{ target: squareImage; enabled: false}
		},
		State
		{
			name: "x";   //the square was clicked on by player x.
			PropertyChanges { target: squareImage; enabled: true; source: "Images/" + Vals.getTheme() + "/x.png" }
		},
		State
		{
			name: "o";   //the square was clicked on by player o.
			PropertyChanges { target: squareImage; enabled: true; source: "Images/" + Vals.getTheme() + "/o.png" }
		}
	]

}
