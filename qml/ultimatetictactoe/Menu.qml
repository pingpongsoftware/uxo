import QtQuick 2.0

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

    property color reallyDarkGray: "#444444";


    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }

    Text
    {
        id: title;

        text: "  Ultimate\nTic Tac Toe";
        font.capitalization: Font.SmallCaps;
        font.bold: true;
        //elide: Text.ElideMiddle;
        font.pixelSize: Vals.largeFontSize;
        //font.letterSpacing: 2;
        //font.wordSpacing: 0;
        font.family: prime_reg.name;
        color:
        {
            if (Vals.theme === "dark")
                "gray";

            else if (Vals.theme === "light")
                "firebrick"
        }

        //opacity: .5;

        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: main.top;
        anchors.margins: 50;
    }

    // Sets the layout for the menu buttons
    Flow
    {
        anchors.centerIn: parent;
        width: 350;
        spacing: 20;

        property int buttonHeight: 100;


        Button //new game button
        {
            id: newGameButton;
            width: parent.width;
            height: parent.buttonHeight;
            buttonText: "New Game";
            fontSize: Vals.mediumFontSize;
            textColor:
            {
                if (Vals.theme === "light")
                    "steelblue";
                else if (Vals.theme === "dark")
                {
                    textColor = "#33aadd"
                    opacity = .6;
                }
            }

            onClick: (playButtonClicked());

        }

        Button //how to play button
        {
            id: tutorialButton;
            width: parent.width;
            height: parent.buttonHeight;
            buttonText: "How To Play";
            fontSize: Vals.mediumFontSize;
            textColor:
            {
                if (Vals.theme === "light")
                    "steelblue";
                else if (Vals.theme === "dark")
                {
                    textColor = "#33aadd"
                    opacity = .6;
                }
            }

            onClick:(tutorialButtonClicked());
        }

        Button //how to play button
        {
            id: settingsButton;
            width: parent.width;
            height: parent.buttonHeight;
            buttonText: "Settings";
            fontSize: Vals.mediumFontSize;
            textColor:
            {
                if (Vals.theme === "light")
                    "steelblue";
                else if (Vals.theme === "dark")
                {
                    textColor = "#33aadd"
                    opacity = .6;
                }
            }

            onClick:(settingsButtonClicked());
        }
    }
}
