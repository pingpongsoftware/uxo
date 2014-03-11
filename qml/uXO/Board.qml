import QtQuick 2.0
import uxo.game 1.0
import uxo.board 1.0


Rectangle
{
	id: main;

	width: Vals.getBoardSize()*scale;
	height: width;

	Behavior on width { PropertyAnimation { duration: 300; } }
	Behavior on opacity { PropertyAnimation { duration: 300; } }


	property Game game;
	property Board board;

	property double scale: gridFlick.scale;

	color: "transparent";

	Component.onCompleted:
	{
		game = Tracker.getGame();
		board = game.getBoard();
	}

	PinchZoom
	{
		id: gridPinch;
		anchors.fill: parent;

		Flicker
		{
			id: gridFlick;

			width: Vals.getBoardSize();
			height: width;
			anchors.centerIn: parent;
		}

		Grid
		{
			id: grid;

			parent: gridFlick.contentItem;

			rows: 3;
			columns: rows;
			spacing: Vals.getOuterGridSpacing()*main.scale;

			width: Vals.getBoardSize()*main.scale;
			height: width;

			x: spacing/2;
			y: x;

			Repeater
			{
				id: repeater;
				model: 9;

				anchors.centerIn: parent;

				InnerBoard
				{
					gridIndex: index;
					scale: main.scale;
				}
			}
		}
	}


	Connections
	{
		target: game;

		onGameWonDelayed:
		{
			gameWonTimer.start();

			gameWonTimer.startIndex = index1;
			gameWonTimer.middleIndex = index2;
			gameWonTimer.endIndex = index3;

			gameWonTimer.popUpImage();
		}
	}

	Timer
	{
		id: gameWonTimer;
		interval: 1000/3;
		running: false;

		property int triggerCounter: 0;
		property int startIndex;
		property int middleIndex;
		property int endIndex;

		onTriggered:
		{
			triggerCounter++;
			popUpImage();
			restart();
		}

		function popUpImage()
		{
			if (triggerCounter === 0)
			{
				board.popUpInnerBoardImages(startIndex);
			}

			else if (triggerCounter === 1)
			{
				board.popUpInnerBoardImages(middleIndex);
			}

			else if (triggerCounter === 2)
			{
				board.popUpInnerBoardImages(endIndex);
			}

			else if (triggerCounter === 10)
			{
				Tracker.goBack();
				Tracker.deleteGame();
			}
		}
	}
}

