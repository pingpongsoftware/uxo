import QtQuick 2.0

Rectangle
{
	id: main;

	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();

	signal cancelButtonClicked();
	signal createGameButtonClicked(string gameName);

	color: "transparent";


	Item
	{
		id: clipRect;
		width: parent.width;
		height: parent.height;
		y: Vals.getTopToolbarHeight();
		clip: true;
	}

	Flickable
	{
		id: listFlick;

		contentWidth: width;
		contentHeight: main.height - Vals.getTopToolbarHeight()*6;

		width: main.width;
		height: main.height/4;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.top: parent.top;
		anchors.topMargin: Vals.getTopToolbarHeight();

		parent: clipRect;
	}

	Rectangle
	{
		id: flowRect;

		parent: listFlick.contentItem;

		height: parent.height;
		width: parent.width/2;
		anchors.centerIn: parent;

		color: "transparent";
	}

	Flow
	{
		id: listFlow;

		anchors.fill: parent;
		spacing: Vals.getBasicUnit()*10;

		parent: flowRect;

		PlayerNameInput
		{
			id: playerXInput;
			startingText: "Player X";
			headerText: "Player X Name:"
			width: parent.width;
			height: totalHeight;
		}

		PlayerNameInput
		{
			id: playerOInput;
			startingText: "Player O";
			headerText: "Player O Name:"
			width: playerXInput.width;
			height: totalHeight;
		}

		Flow
		{
			id: gameNameFlow;
			width: parent.width;

			spacing: Vals.getBasicUnit();


			Rectangle
			{
				id: centerRect; //allows the gameNameInputRect to center into the flow;
				width: parent.width;
				height: playerXInput.height;
				color: "transparent";

				PlayerNameInput
				{
					id: gameName;
					headerText: "Game Name";
					startingText: playerXInput.inputText + " vs " + playerOInput.inputText;
					width: parent.width*1.6;
					height: totalHeight;
					anchors.centerIn: parent;
					maximumLength: startingText.length;
				}
			}
		}


		Flow
		{
			id: buttonFlow;

			width: parent.width;
			height: Vals.getBasicUnit()*7;
			spacing: Vals.getBasicUnit()*5;

			MyButton
			{
				id: cancelButton;
				width: parent.width/2 - parent.spacing/2;
				height: parent.height;

				buttonText: "Cancel";
				fontSize:  Vals.getSmallFontSize();
				buttonOpacity: .7;

				buttonColor:
				{
					if (Vals.getTheme() === "dark")
						"lightgray";
					else if (Vals.getTheme() === "light")
						"#444444";
				}

				textColor:
				{
					if (Vals.getTheme() === "dark")
						"black"
					else
						"white"
				}

				Component.onCompleted:
				{
					setClickableSize(width, height);
				}

				onClick:
				{
					cancelButtonClicked();
				}
			}

			MyButton
			{
				id: playButton;
				width: cancelButton.width;
				height: cancelButton.height;

				buttonText: "Start Game";
				fontSize: cancelButton.fontSize;
				buttonColor: cancelButton.buttonColor;
				buttonOpacity: cancelButton.buttonOpacity;
				textColor: cancelButton.textColor;

				Component.onCompleted:
				{
					setClickableSize(width, height);
				}

				onClick:
				{
					createGameButtonClicked(gameName.inputText);
				}
			}
		}
	}
}
