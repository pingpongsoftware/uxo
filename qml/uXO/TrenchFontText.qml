import QtQuick 2.0

Text
{
    id:  main;

    property int fontSize;
    property bool fontBold: true

    //load fonts from a file
    FontLoader { id: trenchFont; source: "Fonts/trench.ttf" }

    font.family: trenchFont.name;
    font.capitalization: Font.SmallCaps;
    horizontalAlignment: Text.AlignHCenter;
    verticalAlignment: Text.AlignVCenter
    font.bold: fontBold;
    font.pixelSize: fontSize;
    text: "NO TEXT SET!!!";

    color:
    {
        // sets the text color based on the theme if the color is not manually set.
        if (Vals.theme === "dark")
            "lightgray";
        else
            "darkgray"
    }
}
