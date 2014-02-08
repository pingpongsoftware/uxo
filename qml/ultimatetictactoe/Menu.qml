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
                "white";

            else if (Vals.theme === "light")
                "firebrick"
        }

        opacity: .6;

        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: main.top;
        anchors.margins: Vals.topMargin;
    }

    // Sets the layout for the menu buttons
    Flow
    {
        width: Vals.buttonWidth; //the flow is the same width as the buttons so the buttons are centered in the flow
        spacing: Vals.menuSpacing;
        anchors.centerIn: parent;

        MyButton //new game button
        {
            id: newGameButton;
            width: Vals.buttonWidth;
            height: Vals.buttonHeight;
            buttonText: "New Game";
            fontSize: Vals.mediumFontSize;
            textColor: "steelblue";
            opacity: .8;

            onClick: (playButtonClicked());

        }

        MyButton //how to play button
        {
            id: tutorialButton;
            width: Vals.buttonWidth;
            height: Vals.buttonHeight;
            buttonText: "How To Play";
            fontSize: Vals.mediumFontSize;
            textColor: "steelblue";
            opacity: .8;

            onClick:(tutorialButtonClicked());
        }

        MyButton //settings button
        {
            id: settingsButton;
            width: Vals.buttonWidth;
            height: Vals.buttonHeight;
            buttonText: "Settings";
            fontSize: Vals.mediumFontSize;
            textColor: "steelblue";
            opacity: .8;

            onClick:(settingsButtonClicked());
        }
    }
}
