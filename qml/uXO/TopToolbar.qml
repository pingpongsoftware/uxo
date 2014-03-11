import QtQuick 2.0

Item
{
    id: main;

    signal backButtonPressed();

	opacity: 1;

	property string titleString: "uXO:  Ultimate Tic-Tac-Toe"

    function updateBackButtonEnabled(b)
    {
        backMouse.enabled = b;
        backImage.visible = b;
    }

	Connections
	{
		target: Vals;

		onThemeSwitched:
		{
			toolbarRect.updateTheme();
			darkBackImage.updateTheme();
		}
	}

    states:
    [
        State { name: "dark" },
        State { name: "light" }
    ]

    onStateChanged: toolbarImageDark.state = state;

	Rectangle
	{
		id: toolbarRect;
		anchors.fill: parent;
		color: { updateTheme(); }

		function updateTheme()
		{
			if (Vals.getTheme() === "dark")
			{
				color = "lightgray";
				backRect.color = "lightgray";
				dropDownButton.color = "lightgray";
			}
			else if (Vals.getTheme() === "light")
			{
				color = "#444444";
				backRect.color = "#444444";
				dropDownButton.color = "#444444";
			}
		}

		Behavior on color { PropertyAnimation { duration: 200; } }
	}

    Rectangle  //for the back button
    {
        id: backRect;
		color: toolbarRect.color;
        height: parent.height;
		width: height;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left

		Behavior on color { PropertyAnimation { duration: 200; } }

        MouseArea
        {
            id: backMouse;
            anchors.fill: parent;

			onPressed: parent.color = "gray"
			onExited: parent.color = toolbarRect.color;
			onCanceled: parent.color = toolbarRect.color;

            onClicked:
			{
                backButtonPressed();
            }
        }
    }


	Image
	{
		id: lightBackImage;
		source: "Images/light/backArrow.png";
		width: backRect.width;
		height: backRect.height;
		sourceSize.height: width;
		sourceSize.width: width;
		anchors.centerIn: backRect;
	}

    Image
    {
		id: darkBackImage;
		source: "Images/dark/backArrow.png";
        width: backRect.width;
        height: backRect.height;
        sourceSize.height: width;
        sourceSize.width: width;
        anchors.centerIn: backRect;

		opacity: { updateTheme(); }

		Behavior on opacity { PropertyAnimation { duration: 200; } }

		function updateTheme()
		{
			if (Vals.getTheme() === "dark")
				opacity = 1;
			else
				opacity = 0;
		}
    }

	TrenchFontText
    {
        id: titleText;

		anchors.verticalCenter: main.verticalCenter;
//		anchors.left: separatorLineRect.right;
//		anchors.leftMargin: Vals.getBasicUnit()*4;
		anchors.centerIn: parent;
		fontSize: Vals.getMediumFontSize();

		darkThemeColor: "black";
		lightThemeColor:  "white";

		Component.onCompleted: updateColor();

		text: main.titleString;
    }

	Rectangle
	{
		id: dropDownButton;
		height: Vals.getTopToolbarHeight();
		width: height;
		anchors.top: main.top;
		anchors.right: main.right;
		color: toolbarRect.color;

		Behavior on color { PropertyAnimation { duration: 200; } }

		Rectangle
		{
			id: repeaterCenterRect;

			width: Vals.getBasicUnit();
			anchors.centerIn: parent;
			color: "transparent";
		}

		Repeater
		{
			parent: repeaterCenterRect;
			model: 3;
			anchors.centerIn: parent;

			Rectangle
			{
				width: Vals.getBasicUnit();
				height: width;

				color: titleText.color;
				anchors.horizontalCenter: repeaterCenterRect;
				y: index*width*2;
				opacity: .8;

				Component.onCompleted: repeaterCenterRect.height += height*1.6666666667;
			}
		}

		MouseArea
		{
			anchors.fill: parent;

			onPressed: parent.color = "gray";
			onExited: parent.color = toolbarRect.color;
			onReleased: parent.color = toolbarRect.color;
			onCanceled: parent.color = toolbarRect.color;
			onClicked:
			{
				Tracker.clickDropDownButton()
			}
		}
	}
}
