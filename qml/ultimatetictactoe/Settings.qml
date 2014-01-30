import QtQuick 2.0

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }

    Text
    {
        id: title;

        text: "Settings";
        font.capitalization: Font.SmallCaps;
        font.bold: true;
        elide: Text.ElideMiddle;
        font.pixelSize: 68;
        font.letterSpacing: 2;
        font.wordSpacing: 0;
        font.family: prime_reg.name;
        color: "white";
        opacity: .5;

        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: main.top;
        anchors.margins: 50;
    }

    Text
    {
        id: setThemeText

        text: "Select Theme"


    }

}
