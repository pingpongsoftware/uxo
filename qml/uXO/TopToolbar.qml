import QtQuick 2.0

Item
{
    id: main;

	width: Vals.getScreenWidth();
	height: Vals.getTopToolbarHeight();

    signal backButtonPressed();
	opacity: .8;

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
			backImage.updateTheme();
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
				color = "lightgray";
			else if (Vals.getTheme() === "light")
				color = "#444444";
		}

		Behavior on color { PropertyAnimation { duration: 200; } }
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
		source: { updateTheme(); }
        width: backRect.width;
        height: backRect.height;
        sourceSize.height: width;
        sourceSize.width: width;
        anchors.centerIn: backRect;

		function updateTheme()
		{
			source = "Images/" + Vals.getTheme() + "/backArrow.png";
		}
    }

	Rectangle
	{
		id: separatorLineRect;
		height: main.height;
		width: Vals.getBasicUnit()/8;
		anchors.left: backRect.right;
		anchors.leftMargin: Vals.getBasicUnit()/5;
		color: titleText.color;
	}

	TrenchFontText
    {
        id: titleText;

		anchors.verticalCenter: main.verticalCenter;
//		anchors.left: separatorLineRect.right;
//		anchors.leftMargin: Vals.getBasicUnit()*4;
		anchors.centerIn: parent;
		fontSize: Vals.getMediumSmallFontSize();

		darkThemeColor: "black";
		lightThemeColor:  "white";

		Component.onCompleted: updateColor();

		text: main.titleString;
    }
}
