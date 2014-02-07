import QtQuick 2.0

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

        width: parent.width;
        height: main.menuTitleHeight;

        anchors.top: main.top;
        anchors.topMargin: Vals.topMargin;

        text: "How to Play";
        font.capitalization: Font.SmallCaps;
        font.bold: true;
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: Vals.largeFontSize;
        font.letterSpacing: 2;
        font.wordSpacing: 0;
        font.family: prime_reg.name;
        color:
        {
            if (Vals.theme === "light")
                "firebrick"
            else if (Vals.theme === "dark")
                "white"
        }

        opacity: .6;

    }


}

