import QtQuick 2.0

Rectangle
{
	id: main;

	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();

	signal cancelButtonClicked();
	signal createGameButtonClicked(string gameName);

	color: "transparent";

	Flickable
	{
		id: listFlick;

		contentWidth: width;
		contentHeight: main.height - Vals.getTopToolbarHeight()*6;

		width: main.width/2;
		height: contentHeight/2;
		anchors.horizontalCenter: parent.horizontalCenter;
		anchors.top: main.top;
		anchors.topMargin: Vals.getTopToolbarHeight()*2;
	}

	Flow
	{
		id: listFlow;

		anchors.fill: listFlick;
		spacing: Vals.getBasicUnit()*2;

		parent: listFlick.contentItem;

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

		Item
		{
			id: spacingItem;
			height: parent.spacing*2;
			width: parent.width;
		}

		Flow
		{
			id: gameNameFlow;
			width: parent.width;

			spacing: Vals.getBasicUnit();

			TrenchFontText
			{
				id: gameNameText;
				horizontalAlignment: Text.AlignHCenter;
				width: parent.width;
				fontSize: Vals.getMediumFontSize();

				text: "Game Name:"
			}

			Rectangle
			{
				id: centerRect; //allows the gameNameInputRect to center into the flow;
				width: parent.width;
				height: Vals.getMediumFontSize();
				color: "transparent";
			}

			Rectangle
			{
				id: gameNameInputRect;

				parent: centerRect;
				width: parent.width*1.6;
				height: parent.height;
				anchors.centerIn: parent;

				clip: true;

				color:
				{
					if (Vals.getTheme() === "dark")
						"white";
					else if (Vals.getTheme() === "light")
						"black"
				}

				opacity: .3;

				TextInput
				{
					id: gameNameInput;
					anchors.fill: parent;
					font.pixelSize: Vals.getMediumSmallFontSize();

					font.weight: Font.Light;
					font.family: "Helvetica";

					horizontalAlignment: Text.AlignHCenter;
					verticalAlignment:  Text.AlignVCenter;

					onFocusChanged:
					{
						if (focus === true)
							selectAll();
						else
							select(0,0);
					}


					text: playerXInput.inputText + " vs " + playerOInput.inputText;
					selectByMouse: true;
					maximumLength: playerXInput.maximumLength + playerOInput.maximumLength + 5;


					color:
					{
						if (Vals.getTheme() === "dark")
							"black";
						else if (Vals.getTheme() === "light")
							"white";
					}
				}
			}
		}



		Item
		{
			id: spacingItem2;
			height: spacingItem.height*2
			width: parent.width;
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
						"darkgray";
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

				Component.onCompleted:
				{
					setClickableSize(width, height);
				}

				onClick:
				{
					createGameButtonClicked(gameNameInput.text);
				}
			}
		}
	}
}
