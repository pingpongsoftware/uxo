import QtQuick 2.0

Item
{
    id: main;

	width: Vals.getScreenWidth();
	height: Vals.getTopToolbarHeight();

    signal backButtonPressed();

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
			toolbarImageDark.updateOpacity();
		}
	}

    states:
    [
        State { name: "dark" },
        State { name: "light" }
    ]

    onStateChanged: toolbarImageDark.state = state;

    Image
    {
        id: toolbarImageLight;
        anchors.fill: parent;
        sourceSize.width: width;
        sourceSize.height: height;
        source: "Images/light/topToolbar.png"
    }

    Image
    {
        id: toolbarImageDark;
        anchors.fill: parent;
        sourceSize.width: parent.width;
        sourceSize.height: parent.height;
		source: "Images/dark/topToolbar.png"

		function updateOpacity()
		{
			if (Vals.getTheme() === "dark")
				opacity = 1;
			else if (Vals.getTheme() === "light")
				opacity = 0;
		}

		Behavior on opacity { NumberAnimation { duration: 200; } }
    }

    Rectangle  //for the back button
    {
        id: backRect;
        color: "black";
        height: parent.height;
		width: height;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left
        opacity: 0;

        function changeOpacity()
        {
            backImage.opacity = 1;
            backRect.opacity = 0;
        }

        MouseArea
        {
            id: backMouse;
            anchors.fill: parent;

            onPressed: { backImage.opacity = .5; backRect.opacity = .5 }
            onExited: parent.changeOpacity();
            onCanceled: parent.changeOpacity();

            onClicked:
            {
                backRect.changeOpacity();

                backButtonPressed();
            }
        }
    }


    Image
    {
        id: backImage;
        source: "Images/backArrow.png";
        width: backRect.width;
        height: backRect.height;
        sourceSize.height: width;
        sourceSize.width: width;
        anchors.centerIn: backRect;
    }

	Rectangle
	{
		id: separatorLineRect;
		height: main.height;
		width: Vals.getBasicUnit()/8;
		anchors.left: backRect.right;
		anchors.leftMargin: Vals.getBasicUnit()/5;
		color:
		{
			if (Vals.getTheme() === "dark")
				"white";
			else if (Vals.getTheme() === "light")
				"black";
		}
	}

	TrenchFontText
    {
        id: titleText;

		anchors.verticalCenter: main.verticalCenter;
		anchors.left: separatorLineRect.right;
		anchors.leftMargin: Vals.getBasicUnit()*4;
		fontSize: Vals.getMediumSmallFontSize();

		darkThemeColor: "white";
		lightThemeColor:  "white";

		Component.onCompleted: updateColor();

		text: main.titleString;
    }
}
