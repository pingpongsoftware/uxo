import QtQuick 2.0
import uxo.game 1.0
import uxo.board 1.0
import uxo.innerboard 1.0


Rectangle
{
	id: main;

	width: Vals.getInnerBoardSize()*scale;
	height: width;

	color: "transparent";

	property int gridIndex;	

	property double scale;

	property Game game: Tracker.getGame();
	property Board board: game.getBoard();
	property InnerBoard innerBoard: board.getInnerBoardAt(gridIndex);

	property bool isValid;

	Component.onCompleted:
	{
		setState();
		setValidity();
	}

	Connections
	{
		target: board;

		onClicked: main.setValidity();
	}

	Connections
	{
		target: innerBoard;

		onStateChanged: main.setState();
	}

	function setValidity()
	{
		main.isValid = innerBoard.isValid();
		outline.setVisibility(main.isValid);
		main.setState();
	}

	Rectangle
	{
		id: outline;
		color: "transparent";
		anchors.centerIn: parent;
		width: (Vals.getInnerBoardSize() + Vals.getInnerGridSpacing()*3) * main.scale;
		height: width;
		border.width: Vals.getInnerGridSpacing()*.8 * main.scale;
		border.color: setVisibility();

		function setVisibility()
		{
			if (main.isValid)
				border.color = "green";
			else
				border.color = "transparent"
		}
	}

	Image
	{
		id: playerWinImage;
		anchors.fill: parent;
		sourceSize.width: width*main.scale;
		sourceSize.height: height*main.scale;
		asynchronous: true;
		opacity: .5;
	}

	Grid
	{
		id: grid;
		rows: 3;
		columns: rows;
		spacing: Vals.getInnerGridSpacing()*main.scale;

		width: parent.width*main.scale;
		height: width;
		x: spacing/2;
		y: x;

		layer.enabled: true;

		Repeater
		{
			id: repeater;
			model: 9;

			anchors.centerIn: parent;

			Square
			{
				gridIndex: main.gridIndex;
				squareIndex: index;
				scale: main.scale;
			}
		}
	}

	function setState()
	{
		main.state = innerBoard.getState();
	}

	states:
	[
		State
		{
			name: "-";
			PropertyChanges{ target: playerWinImage;}
		},
		State
		{
			name: "x";
			PropertyChanges{ target: playerWinImage; source: "Images/" + Vals.getTheme() + "/x.png" }
		},
		State
		{
			name: "o";
			PropertyChanges{ target: playerWinImage; source: "Images/" + Vals.getTheme() + "/o.png"  }
		}

	]
}

