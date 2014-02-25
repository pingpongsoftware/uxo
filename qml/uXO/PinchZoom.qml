import QtQuick 2.0
import uxo.game 1.0
import uxo.board 1.0

PinchArea
{
	id: pinchZoom;
	pinch.target: pinchRect;
	pinch.minimumScale: 1.0;
	pinch.maximumScale: 1.5;
	anchors.fill: parent;

	property Game game;
	property Board board;

	Component.onCompleted:
	{
		game = Tracker.getGame();
		board = game.getBoard();
	}

	property double oldScale: 1.0;
	property int counter: 0;

	property int gridIndex;

	onPinchStarted:
	{
		gridIndex = getGridIndexAtPoint(pinch.center.x, pinch.center.y);
	}

	onPinchUpdated:
	{
		if (counter < 3 && counter > 0)
		{
			if (pinch.scale > oldScale)
				board.zoomIn(gridIndex)
			else if (pinch.scale < oldScale)
				board.zoomOut(gridIndex);
		}

		oldScale = pinch.scale;
		counter++;
	}

	onPinchFinished:
	{
		counter = 0;
		oldScale = 1.0;
	}

	function getGridIndexAtPoint(x, y) //returns the index of the grid that the pinch occurs in
	{
		if (x < Vals.getInnerBoardSize())
		{
			if (y < Vals.getInnerBoardSize())
				return 0;
			if (y < Vals.getInnerBoardSize()*2)
				return 3;
			if (y < Vals.getInnerBoardSize()*3)
				return 6;
		}
		if (x < Vals.getInnerBoardSize()*2)
		{
			if (y < Vals.getInnerBoardSize())
				return 1;
			if (y < Vals.getInnerBoardSize()*2)
				return 4;
			if (y < Vals.getInnerBoardSize()*3)
				return 7;
		}
		if (x < Vals.getInnerBoardSize()*3)
		{
			if (y < Vals.getInnerBoardSize())
				return 2;
			if (y < Vals.getInnerBoardSize()*2)
				return 5;
			if (y < Vals.getInnerBoardSize()*3)
				return 8;
		}

		return -1;
	}

	Rectangle
	{
		id: pinchRect;
		color: "transparent";
		width: 100;
		height: width;
	}

}
