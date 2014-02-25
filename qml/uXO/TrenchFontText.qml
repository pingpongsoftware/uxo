import QtQuick 2.0

Text
{
    id:  main;

    property int fontSize;
	property bool fontBold: true;

	property color darkThemeColor: "steelblue";
	property color lightThemeColor: "firebrick";

	property bool useThemeColors: true;

    //load fonts from a file
    FontLoader { id: trenchFont; source: "Fonts/trench.ttf" }

    font.family: trenchFont.name;
    font.capitalization: Font.SmallCaps;
    horizontalAlignment: Text.AlignHCenter;
    verticalAlignment: Text.AlignVCenter
    font.bold: fontBold;
    font.pixelSize: fontSize;
    text: "NO TEXT SET!!!";

	color: updateColor;

	function updateColor()
	{
		if (main.useThemeColors)
		{
			if (Vals.getTheme() === "dark")
				color = darkThemeColor;
			else
				color = lightThemeColor;
		}
	}

	Behavior on color { PropertyAnimation { duration: 200; } }

	Component.onCompleted: updateColor();
}
