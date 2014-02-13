import QtQuick 2.0

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    TrenchFontText
    {
        id: title;

        width: parent.width;
        height: main.menuTitleHeight;

        anchors.top: main.top;
        anchors.topMargin: Vals.topMargin;

        text: "How to Play";
        font.pixelSize: Vals.largeFontSize;
        font.letterSpacing: 2;
        font.wordSpacing: 0;

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

