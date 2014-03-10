import QtQuick 2.0

Item
{
    id: main;
	property string name;
    property double rectOpacity: 1;

	signal buttonClicked(var gameName);


    MyButton
    {
		buttonText: main.name;
		fontBold: false;
		fontSize: Vals.getMediumFontSize();
        anchors.fill: parent;
		buttonColor:
        {
			if (Vals.getTheme() === "dark")
				"#222222";
            else
                "white"
        }

        textColor:
        {
			if (Vals.getTheme() === "dark")
				"lightgray";
            else
				"#444444"
        }

		onClick:
		{
			Vals.setTopToolbarText(name)
			buttonClicked(name);
		}

		buttonOpacity: 1
        showColorWhenClicked: true;

        Component.onCompleted: setClickableSize(width, height)
    }
}
