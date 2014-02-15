import QtQuick 2.0

Item
{
    id: main;
    property string text;
    property double rectOpacity: 1;


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

        buttonOpacity: .2
        showColorWhenClicked: true;

        Component.onCompleted: setClickableSize(width, height)
    }
}
