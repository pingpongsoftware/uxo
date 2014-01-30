import QtQuick 2.0

Rectangle
{
    id: main;
    width: Vals.SCREEN_WIDTH;
    height: Vals.SCREEN_HEIGHT;
    color: "transparent";

    signal playButtonClicked();
    signal tutorialButtonClicked();
    signal settingsButtonClicked();

    property color releasedColor: Qt.rgba(0,0,0,.5);
    property color enteredColor: Qt.rgba(0,0,0,.75);
    property color pressedColor: Qt.rgba(0,0,0,1);

    property color reallyDarkGray: "#444444";


    property string primeLiteFont: prime_lite.name;
    property string primeRegFont: prime_reg.name;


    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }
    FontLoader { id: prime_lite; source: "Fonts/Prime Light.ttf" }
    FontLoader { id: nexa_bold; source: "Fonts/Nexa Bold.ttf" }
    FontLoader { id: nexa_lite; source: "Fonts/Nexa Light.ttf" }

    Text
    {
        id: title;

        text: "  Ultimate\nTic Tac Toe";
        font.capitalization: Font.SmallCaps;
        font.bold: true;
        //elide: Text.ElideMiddle;
        font.pixelSize: Vals.LARGE_FONT_SIZE;
        //font.letterSpacing: 2;
        //font.wordSpacing: 0;
        font.family: main.primeRegFont;
        color:
        {
            if (Vals.THEME === "dark")
                color = "gray";

            else if (Vals.THEME === "light")
                color = "#444444"
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
            fontSize: Vals.MEDIUM_FONT_SIZE;
            textColor:
            {
                if (Vals.THEME === "light")
                    "firebrick";
                else if (Vals.THEME === "dark")
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
            fontSize: Vals.MEDIUM_FONT_SIZE;
            textColor:
            {
                if (Vals.THEME === "light")
                    "steelblue";
                else if (Vals.THEME === "dark")
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
            fontSize: Vals.MEDIUM_FONT_SIZE;
            textColor:
            {
                if (Vals.THEME === "light")
                    "forestgreen";
                else if (Vals.THEME === "dark")
                {
                    textColor = "#33aadd"
                    opacity = .6;
                }
            }

            onClick:(settingsButtonClicked());
        }
    }
}
