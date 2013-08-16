import QtQuick 2.0
import "Scale.js" as Vals


Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    Text
    {
        id: title;

        text: "Settings";
        //font.capitalization: Font.SmallCaps;
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

}
