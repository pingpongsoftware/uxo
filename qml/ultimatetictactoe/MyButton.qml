import QtQuick 2.0
Rectangle
{
    id: main;
    color: "transparent";

    property color releasedColor: Qt.rgba(.2,.2,.2,.9);
    property color pressedColor: Qt.rgba(.2,.7,.8,.95);
    property color hoverColor: Qt.rgba(.2,.25,.3,.95);

    property string buttonText;
    property int fontSize: Vals.smallFontSize;
    property string fontLocation: prime_reg.name;
    property color textColor;


    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    signal click();

    Text
    {
        id: buttonTextBox
        //anchors.centerIn: parent;
        font.pixelSize: main.fontSize;
        font.family: fontLocation;
        text: main.buttonText;
        color: textColor;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.margins: parent.width/75;  //random ratio to get it perfectly centered
    }

    MouseArea
    {
        id: buttonMouseArea;
        anchors.fill: parent;
        hoverEnabled: true;

        onPressed: buttonTextBox.opacity = .5;

        onExited: textOpacityToOne();

        onCanceled: textOpacityToOne();

        onClicked:
        {
            textOpacityToOne();
            click();
        }

        function textOpacityToOne()
        {
            buttonTextBox.opacity = 1;
        }
    }
}
