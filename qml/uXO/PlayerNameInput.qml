import QtQuick 2.0

Flow
{
	id: main;

	property string startingText;
	property string headerText;

	property string inputText: input.text;

	signal textChanged();

	property int totalHeight: spacing;  //added onto later

	clip: true;

	spacing: Vals.getBasicUnit();

	TrenchFontText
	{
		id: header;
		horizontalAlignment: Text.AlignHCenter;
		width: parent.width;
		fontSize: Vals.getMediumFontSize();

		text: main.headerText;

		Component.onCompleted: main.totalHeight += height;
	}

	Rectangle
	{
		id: rect;

		width: parent.width;
		height: Vals.getMediumFontSize();

		Component.onCompleted: main.totalHeight += height;

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
			id: input;
			anchors.centerIn: parent;
			font.pixelSize: Vals.getMediumSmallFontSize();

			font.weight: Font.Light;
			font.family: "Helvetica";

			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment:  Text.AlignVCenter;

			onFocusChanged:
			{
				if (focus === true)
				{
					if (text === main.startingText)
						text = "";
					else
						selectAll();
				}
			}

			selectByMouse: true;
			text: main.startingText;
			maximumLength: 12;

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
