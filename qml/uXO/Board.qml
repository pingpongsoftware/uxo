import QtQuick 2.0
import uxo.game 1.0
import uxo.board 1.0


Rectangle
{
	id: main;

	width: Vals.getBoardSize()*scale;
	height: width;

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
}

