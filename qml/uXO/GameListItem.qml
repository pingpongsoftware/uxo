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
			if (Vals.getTheme() === "light")
                "black";
            else
                "white"
        }

        textColor:
        {
			if (Vals.getTheme() === "light")
                "black";
            else
                "white"
        }

		onClick:
		{
			buttonClicked(name);
		}

        buttonOpacity: .2
        showColorWhenClicked: true;

        Component.onCompleted: setClickableSize(width, height)
    }
}
