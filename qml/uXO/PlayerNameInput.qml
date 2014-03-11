import QtQuick 2.0

Flow
{
	id: main;

	property string startingText;
	property string headerText;

	property string inputText: input.text;
	property int maximumLength: 12;  //defaults at 12

	property bool editable: true;

	signal textChanged();
	signal focusGained();

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
			font.pixelSize: Vals.getSmallFontSize();

			font.weight: Font.Light;

			horizontalAlignment: Text.AlignHCenter;
			verticalAlignment:  Text.AlignVCenter;

			selectByMouse: false;
			focus: activeFocus;
			text: main.startingText;
			maximumLength: main.maximumLength;

			readOnly: !main.editable;

			color:
			{
				if (Vals.getTheme() === "dark")
					"black";
				else if (Vals.getTheme() === "light")
					"white";
			}

			onFocusChanged:
			{
				if (focus && !readOnly)
				{
					selectAll();
					selectByMouse = true;
					textChanged(); //signals to update the text;
					focusGained();  //signals that the focus is gained;

					console.log(main.editable + "  " + readOnly)
				}

				else
				{
					select(0,0)
					selectByMouse = false;
					textChanged();  //signals to update the text
				}
			}

		}
	}
}
