import QtQuick 2.0

Rectangle
{
    //-----------------

    // The clickable button's size is dependent on the width and height of the text, not on the size of "main"
    // main's width and height can be changed in order to make it easier to center, but the clickable area of the
    // button will not change.  To change the size of the clickable button, use functions setClickableWidth and
    // setClickableHeight

    //---------------

    id: main;
    color: "transparent";

    width: getClickableWidth();
    height: getClickableHeight();

    property string buttonText;
    property int fontSize;
    property color textColor;
    property bool fontBold: true;
    property color buttonColor: "transparent";
    property double buttonOpacity: 1.0;

	property bool showColorWhenClicked:
	{
		if (buttonColor !== "transparent")
			true;
		else
			false;
	}

    function getClickableX() { return bRect.x; }
    function getClickableY() { return bRect.y; }
    function getClickableWidth() { return bRect.width; }
    function getClickableHeight() { return bRect.height; }
    function getRelativeClickableX() { return main.x - bRect.x; }
    function getRelativeClickableY() { return main.y - bRect.y; }

    function setClickablePos(x1, x2)
    {
        bRect.x = x1
        bRect.y = x2
    }

    function setClickableSize(w, h)
    {
        bRect.width = w;
        bRect.height = h;
    }

    //load fonts from a file
    FontLoader { id: trenchFont; source: "Fonts/trench.ttf" }

    signal click();


    Rectangle
    {
        id: bRect;
		width: bText.width;  //Automatically sizes the usable button to the size of the text.
        height: bText.height;
        x: (main.width/2) - (width/2);   //I'm manually centering this so that it can be changed from outside
        y: (main.height/2) - (height/2);
        color: main.buttonColor;
        opacity: main.buttonOpacity;

        MouseArea
        {
            id: buttonMouseArea;
            anchors.fill: parent;
            //hoverEnabled: true;

            onPressed:
            {
                if (showColorWhenClicked)
                    bRect.opacity = .5;
                else
                    bText.opacity = .5;
            }

            onReleased: opacityToNormal();

            onExited: opacityToNormal();

            onCanceled: opacityToNormal();

            onClicked:
            {
                click();
            }

            function opacityToNormal()
            {
                bText.opacity = 1;
                bRect.opacity = main.buttonOpacity;
            }
        }
    }

    TrenchFontText
    {
        id: bText
		color: textColor;
        anchors.centerIn: bRect;
        fontSize: main.fontSize;
        fontBold: main.fontBold;
        text: main.buttonText;

		opacity: bRect.opacity;

		useThemeColors: false;
    }
}
