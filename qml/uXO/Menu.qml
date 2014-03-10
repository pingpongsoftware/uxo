import QtQuick 2.0

Rectangle
{
    id: main;
	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();

	color: "transparent";

    signal playButtonClicked();
	signal helpButtonClicked();
    signal settingsButtonClicked();
	signal newGameButtonClicked();

	property int dragMinY: listRect.y;
	property int dragMaxY: main.height - savedGameList.getHeaderHeight() - savedGameList.anchors.topMargin;

    Image
    {
        id: titleImage;

        width: parent.width;
        height: width/2;

        sourceSize.width: width;
        sourceSize.height: height;

        smooth: true;

        anchors.top: main.top;
		anchors.topMargin: Vals.getBasicUnit();
        anchors.horizontalCenter: parent.horizontalCenter;
		source: "Images/" + Vals.getTheme() + "/title.png";

    }

    MouseArea
    {
        id: swipeRect;

        anchors.fill: parent;

        property bool isPressed: false;
        property bool hasPositionChanged: false;
        property int pressedY;
        property int frameCounter: 0;

        onPressed:
        {
            isPressed = true;
            pressedY = mouse.y
        }

        onPositionChanged:
        {
            frameCounter++;

            if (isPressed)
            {
                hasPositionChanged = true;

                if (frameCounter === 3)
                {
                    if (pressedY > mouse.y)  //if they are dragging up
                        littleButton.y = main.dragMinY;
                    else if (pressedY < mouse.y)
                        littleButton.y = main.dragMaxY;
                }
            }
        }

        onReleased:
        {
            frameCounter = 0;
            isPressed = false;
            hasPositionChanged = false;
        }
    }

    Rectangle
    {
        id: listRect;
        color: "transparent"
        width: main.width/2;
        height: littleButton.y - y;
        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: titleImage.bottom;
        anchors.topMargin: 0;
        clip: true;
    }

    // Sets the layout for the menu buttons
    Flow
    {
        id: menuFlow;
        parent: listRect
		width: Vals.getBasicUnit()*40; //the flow is the same width as the buttons so the buttons are centered in the flow
		spacing: Vals.getBasicUnit()*8;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
		anchors.topMargin: Vals.getBasicUnit()*3;

		MyButton //new game button
        {
            id: newGameButton;
            buttonText: "New Game";
            width: parent.width;
			fontSize: Vals.getMediumFontSize();
            textColor: "steelblue";
			onClick:
			{
				(newGameButtonClicked());
			}
        }

        MyButton //help button
        {
            id: tutorialButton;
            buttonText: "How to Play";
            width: parent.width;
			fontSize: newGameButton.fontSize;
            textColor: "steelblue";
			onClick: (helpButtonClicked());
        }

        MyButton //settings button
        {
            id: settingsButton;
            buttonText: "Options";
            width: parent.width;
			fontSize: newGameButton.fontSize;
            textColor: "steelblue";
            onClick: (settingsButtonClicked());
        }
    }


    Rectangle
    {
        id: littleButton;
		color: "transparent";
		width: Vals.getBasicUnit()*3;
		height: width/3;

		y: main.height;

        Component.onCompleted: y = main.dragMaxY

        anchors.horizontalCenter: main.horizontalCenter;

        Behavior on y
        {
			NumberAnimation { duration: 600; easing.type: Easing.OutBack }
        }

        MouseArea
        {
            id: littleButtonMouse
            anchors.fill: parent;

            property bool isPressed: false;
            property bool hasPositionChanged: false;
            property int pressedY;
            property int frameCounter: 0;

            onPressed:
            {
                isPressed = true;
                pressedY = mouse.y
            }

            onPositionChanged:
            {
                frameCounter++;

                if (isPressed)
                {
                    hasPositionChanged = true;

                    if (frameCounter === 3)
                    {
                        if (pressedY > mouse.y)  //if they are dragging up
                            littleButton.y = main.dragMinY;
                        else if (pressedY < mouse.y)
                            littleButton.y = main.dragMaxY;
                    }
                }
            }

            onReleased:
            {
                frameCounter = 0;
                isPressed = false;
                hasPositionChanged = false;
            }

            onClicked:
            {
                if (!hasPositionChanged)
                {
                    if (littleButton.y === main.dragMinY)
                        littleButton.y = main.dragMaxY;
                    else if (littleButton.y === main.dragMaxY)
                        littleButton.y = main.dragMinY;
                }
            }
        }
    }

    Repeater  //the three little rectangles below the menu list
    {
		model: 2

        Rectangle
        {
            anchors.horizontalCenter: littleButton.horizontalCenter;
			anchors.top: littleButton.top;
			anchors.topMargin: height*index*2;  // spreads them apart and centers them

			height: littleButton.height/3;
			width: littleButton.width;

            color: "gray";
        }

    }


	GameList
	{
		id: savedGameList;

		anchors.horizontalCenter: main.horizontalCenter;
		anchors.top: littleButton.bottom;
		anchors.topMargin: Vals.getBasicUnit();

		width: main.width;
		height: main.height - main.dragMinY;

		onItemButtonClicked:
		{
			Tracker.loadGame(gameName);
			(playButtonClicked());
		}
	}
}
