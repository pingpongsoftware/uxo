import QtQuick 2.0

Rectangle
{
    id: main;

	width: Vals.getScreenWidth();
	height: Vals.getScreenHeight();
    color: "transparent";

    signal switchThemeButtonClicked();

	Flow  //This makes all of the settings easier to position
	{
		id: flow;

		width: parent.width/2.5;
		height: parent.height;
		anchors.horizontalCenter: parent.horizontalCenter;
		y: Vals.getTopToolbarHeight()*1.2;

		spacing: Vals.getBasicUnit()*5;

		TrenchFontText
		{
			id: title;

			width: parent.width;

			text: "Options";
			font.pixelSize: Vals.getExtraLargeFontSize();
			font.letterSpacing: 2;
			font.wordSpacing: 0;

			darkThemeColor: "lightgray"

			Component.onCompleted: updateColor();
		}

		TrenchFontText
		{
			id: setThemeText;

			width: parent.width;
			height: main.buttonHeight;

			text: "Select Theme";
			fontSize: Vals.getMediumLargeFontSize();
			fontBold: false;

			Component.onCompleted: updateColor();
		}

		Flow //to easier format the theme buttons
		{
			id: themeFlow
			width: parent.width;
			spacing: 0;
			height: Vals.smallButtonHeight;

			MyButton
			{
				id: lightThemeButton;

				width: parent.width/2;
				height: getClickableHeight()*1.5;

				buttonText: "Light"
				fontBold: false;

				fontSize: Vals.getMediumSmallFontSize();
				textColor: "white"

				onClick: switchTheme("light");
			}

			MyButton
			{
				id: darkThemeButton;

				width: lightThemeButton.width;
				height: lightThemeButton.height;

				buttonText: "Dark"
				fontBold: lightThemeButton.fontBold;

				fontSize: lightThemeButton.fontSize;
				textColor: "black"

				onClick: switchTheme("dark");
			}

		}

	}

	Rectangle
	{
		id: themeRect;
		width: lightThemeButton.getClickableWidth()*1.8;
		height: lightThemeButton.getClickableHeight();
		radius: height;
		color: "steelblue";
		//opacity: .8;
		z: -5; //so it is behind the other objects

		property int lightX: (lightThemeButton.x + (lightThemeButton.width-themeRect.width)/2) + flow.x + themeFlow.x;
		property int darkX: (darkThemeButton.x + (darkThemeButton.width-themeRect.width)/2) + flow.x + themeFlow.x;

		y: lightThemeButton.getRelativeClickableY() + lightThemeButton.getClickableHeight()/2 + flow.y + themeFlow.y;
		state:
		{
			state = Vals.getTheme();
		}

		states:  //the state its in determines its location
		[
			State
			{
				name: "dark";
				PropertyChanges { target: themeRect; x: themeRect.darkX; }
			},
			State
			{
				name: "light";
				PropertyChanges { target: themeRect; x: themeRect.lightX; }
			}
		]

		transitions:  //makes the themeRect move between locations instead of jump between locations
		[
			Transition { from: "*"; to: "*"; PropertyAnimation { properties: "x"; duration: 200; } }

		]

	}

    function switchTheme(theme)
    {
		if (theme !== themeRect.state)
			Vals.switchTheme();

		themeRect.state = Vals.getTheme();

        switchThemeButtonClicked(); //sends signal to the main.qml file so the background image will change

		title.updateColor();
		setThemeText.updateColor();
    }
}
