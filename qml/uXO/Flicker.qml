import QtQuick 2.0
import uxo.game 1.0
import uxo.board 1.0

Flickable
{
	id: main;

	property Game game;
	property Board board;

	Component.onCompleted:
	{
		game = Tracker.getGame();
		board = game.getBoard();
	}

	flickableDirection: Flickable.AutoFlickDirection;

	contentWidth: Vals.getBoardSize()*scale;
	contentHeight: contentWidth;

	property double maxScale: 2.0;
	property double minScale: 1.0
	property double scale: minScale;

	property double xPoint;
	property double yPoint;

	Behavior on scale   { NumberAnimation { duration: 200; } }
	Behavior on contentX   { NumberAnimation { duration: 200; } }
	Behavior on contentY   { NumberAnimation { duration: 200; } }


	Connections
	{
		target: board;

		onZoomedIn:
		{
			zoomIn(getCenterX(gridIndex), getCenterY(gridIndex));  //gridIndex is passed in the signal
		}

		onZoomedOut:
		{
			zoomOut(getCenterX(gridIndex), getCenterY(gridIndex));
		}
	}

	function zoomIn(x, y)
	{
		if (scale === minScale)
		{
			main.setNewPos(x, y)
			scale = maxScale;
		}
	}

	function zoomOut(x, y)
	{
		if (scale === maxScale)
		{
			main.setNewPos(0, 0);
			scale = minScale;
		}
	}

	function setNewPos(centerX, centerY)
	{
		main.contentX = (centerX/width) * contentWidth;
		main.contentY = (centerY/height) * contentHeight;
	}

	function inBounds(val, min, max)
	{
		if (val < min)
			return min;
		else if (val > max)
			return max;

		return val;
	}

	function validContentX(val)
	{
		return inBounds(val, 0, contentWidth - width);
	}

	function validContentY(val)
	{
		return inBounds(val, 0, contentHeight - height);
	}

	function setCenter(centerX, centerY)
	{
		contentX = validContentX(centerX - Math.round(width * 0.5));
		contentY = validContentY(centerY - Math.round(height * 0.5));
	}


	function getCenterX(index)  // returns the center of the grid clicked
	{
		if (index % 3 === 0)
			return 0;
		if (index % 3 === 1)
			return Vals.getInnerBoardSize()*1.5;

		return Vals.getInnerBoardSize()*3;
	}

	function getCenterY(index)  // returns the center of the grid clicked
	{
		if (index < 3)
			return 0;
		if (index < 6)
			return Vals.getInnerBoardSize()*1.5;

		return Vals.getInnerBoardSize()*3;
	}

}
