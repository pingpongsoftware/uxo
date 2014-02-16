import QtQuick 2.0

Item
{
    id: main;
    property string text;
    property double rectOpacity: 1;

	signal buttonClicked(var gameName);


    MyButton
    {
        buttonText: main.text;
        fontBold: false;
        fontSize: Vals.mediumSmallFontSize;
        anchors.fill: parent;
        buttonColor:
        {
            if (Vals.theme === "light")
                "black";
            else
                "white"
        }

        textColor:
        {
            if (Vals.theme === "light")
                "black";
            else
                "white"
        }

		onClick:
		{
			buttonClicked("Test Game 8");
		}

        buttonOpacity: .2
        showColorWhenClicked: true;

        Component.onCompleted: setClickableSize(width, height)
    }
}
