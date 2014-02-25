import QtQuick 2.0
import uxo.game 1.0

Rectangle
{
	id: main;

	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();

	color: "transparent";

	property Game game;

	Component.onCompleted:
	{
		game = Tracker.getGame();
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

}
