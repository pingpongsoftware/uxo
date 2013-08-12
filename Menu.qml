import QtQuick 2.0
import "Scale.js" as Vals

Rectangle
{
    id: main;
    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    signal playButtonClicked();
    signal tutorialButtonClicked();
    signal settingsButtonClicked();

    property color releasedColor: Qt.rgba(0,0,0,.5);
    property color enteredColor: Qt.rgba(0,0,0,.75);
    property color pressedColor: Qt.rgba(0,0,0,1);


    property string exitedFont: prime_lite.name;
    property string enteredFont: prime_reg.name;


    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    Text
    {
        id: title;

        text: "  Ultimate\nTic Tac Toe";
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

    // Sets the layout for the menu buttons
    Flow
    {
        anchors.centerIn: parent;
        width: 250;
        spacing: 10;

        Rectangle // play game button
        {
            id: playGameRect;
            width: parent.width;
            height: 70;
            color: main.releasedColor;
            radius: 10;

            Text
            {
                id: playGameText;

                text: "Play Game";
                color: Qt.rgba(0,.3,.4,1);
                font.pointSize: parent.width/9;
                font.family: main.exitedFont;
                anchors.centerIn: parent;
            }

            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: parent.color = main.enteredColor;
                onExited: parent.color = main.releasedColor;
                onPressed: parent.color = main.pressedColor;

                onReleased:
                {
                    parent.color = main.releasedColor;
                    playButtonClicked();
                }
            }
        }

        Rectangle // how to play button
        {
            id: tutorialRect;
            width: parent.width;
            height: 70;
            color: main.releasedColor;
            radius: 10;

            Text
            {
                id: tutorialText;

                text: "How To Play";
                color: Qt.rgba(0,.3,.4,1);
                font.pointSize: parent.width/10;
                font.family: main.exitedFont;
                anchors.centerIn: parent;
            }

            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: parent.color = main.enteredColor;
                onExited: parent.color = main.releasedColor;
                onPressed: parent.color = main.pressedColor;

                onReleased:
                {
                    parent.color = main.releasedColor;
                    tutorialButtonClicked();
                }
            }
        }

        Rectangle // settings button
        {
            id: settingsRect;
            width: parent.width;
            height: 70;
            color: main.releasedColor;
            radius: 10;

            Text
            {
                id: settingsText;

                text: "Settings";
                color: Qt.rgba(0,.3,.4,1);
                font.pointSize: parent.width/9;
                font.family: main.exitedFont;
                anchors.centerIn: parent;
            }

            MouseArea
            {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: parent.color = main.enteredColor;
                onExited: parent.color = main.releasedColor;
                onPressed: parent.color = main.pressedColor;

                onReleased:
                {
                    parent.color = main.releasedColor;
                    settingsButtonClicked();
                }
            }
        }
    }
}
