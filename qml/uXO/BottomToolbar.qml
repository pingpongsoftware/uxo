import QtQuick 2.0
import uxo.game 1.0;

Rectangle
{
    id: main;

	property Game game;

    signal resetButtonClicked();
    signal backButtonClicked();
    signal resizeGame();
	color: "transparent";

	width: Vals.getScreenWidth();
	height: Vals.getBasicUnit()*20;

	Component.onCompleted:
	{
		game = Tracker.getGame();
		setState();
	}
	Connections
	{
		target: game;

		onClicked: main.setState();
	}

    Rectangle
    {
        id: visibleRect;
		color: "black";
        anchors.fill: parent;
		opacity: .4
    }

    Rectangle // automatically formats the toolbar in a flow layout
    {
        id: rect;
        width: parent.width;
        height: parent.height;
        anchors.margins: 50;
        color: "transparent";

		property int leftRightMargin: Vals.getBasicUnit()*3;

        Image
        {
            id: xImage;
			source: "Images/" + Vals.getTheme() + "/x.png";
            x: parent.leftRightMargin;

			width: main.height;
			height: width;

			sourceSize.height: main.height;
			sourceSize.width: main.height;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Image
        {
            id: oImage;
			source: "Images/" + Vals.getTheme() + "/o.png";
            x: main.width - parent.leftRightMargin - width;

			width: main.height;
			height: width;

			sourceSize.height: main.height;
			sourceSize.width: main.height
            anchors.verticalCenter: parent.verticalCenter;
        }

	}

	function setState() //sets the state of the toolbar
    {        
		if (game.xTurn)
			main.state = "x";
		else
			main.state = "o";
    }

    states:
    [
        //This changes the size and the opacity of the x and o on the toolbar depending on who's turn it is.

        State
        {
			name: "x";
            PropertyChanges
            {
                target: xImage;
				height: main.height/1.2;
                width: height
                opacity: 1;
            }
            PropertyChanges
            {
                target: oImage;
				height: main.height/2;
                width: height
				opacity: .4;
            }
        },

        State
        {
			name: "o";
            PropertyChanges
            {
                target: oImage;
                height: main.height/1.2;
                width: height
                opacity: 1;
            }
            PropertyChanges
            {
                target: xImage;
				height: main.height/2;
                width: height
				opacity: .4;
            }
        }
    ]

    transitions:
    [
        Transition
        {
            from: "*";
            to: "*";

            PropertyAnimation
            {
				properties: "width";
				duration: 200;
            }
            PropertyAnimation
            {
                properties: "height";
				duration: 200;
            }
            PropertyAnimation
            {
                properties: "opacity";
				duration: 200;
            }
        }

    ]

}
