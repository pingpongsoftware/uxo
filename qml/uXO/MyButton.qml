import QtQuick 2.0
Rectangle
{
    id: main;
    color: "transparent";
    //opacity: .5;

    property color releasedColor: Qt.rgba(.2,.2,.2,.9);
    property color pressedColor: Qt.rgba(.2,.7,.8,.95);
    property color hoverColor: Qt.rgba(.2,.25,.3,.95);

    property string buttonText;
    property int fontSize: Vals.smallFontSize;
    property color textColor;

    property bool showColorWhenClicked: false;

    //load fonts from a file
    FontLoader { id: trenchFont; source: "Fonts/Trench.ttf" }

    signal click();

    Text
    {
        id: buttonTextBox
        //anchors.centerIn: parent;
        font.pixelSize: main.fontSize;
        font.family: trenchFont.name;
        font.capitalization: Font.SmallCaps;
        text: main.buttonText;
        color: textColor;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottom: parent.bottom;
        anchors.margins: parent.width/75;  //random ratio to get it perfectly centered
    }

    Rectangle
    {
        id: fillRect;
        anchors.centerIn: main;
        height: main.height;
        width: buttonTextBox.width * 1.3
        color: "#222222";
        radius: height;
        opacity: 0;
    }

    MouseArea
    {
        id: buttonMouseArea;
        anchors.fill: parent;
        //hoverEnabled: true;

        onPressed:
        {
            buttonTextBox.opacity = .5;
            if (showColorWhenClicked)
                fillRect.opacity = .2;
        }

        onReleased: textOpacityToOne();

        onExited: textOpacityToOne();

        onCanceled: textOpacityToOne();

        onClicked:
        {
            click();
        }

        function textOpacityToOne()
        {
            buttonTextBox.opacity = 1;
            fillRect.opacity = 0;
        }
    }
}
