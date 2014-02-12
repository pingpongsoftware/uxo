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
    FontLoader { id: trenchFont; source: "Fonts/Trench.ttf" }

    Image
    {
        id: titleImage;

        width: parent.width;
        height: width/2;

        sourceSize.width: width;
        sourceSize.height: height;

        smooth: true;

        anchors.top: main.top;
        anchors.topMargin: height/10;
        anchors.horizontalCenter: parent.horizontalCenter;
        source: "Images/" + Vals.theme + "/title.png";
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
