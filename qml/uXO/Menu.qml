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

    Image
    {
        id: titleImage;

        width: parent.width;
        height: width/2;

        sourceSize.width: width;
        sourceSize.height: height;

        smooth: true;

        anchors.top: main.top;
        anchors.topMargin: Vals.topMargin / 2;
        anchors.horizontalCenter: parent.horizontalCenter;
        source: "Images/" + Vals.theme + "/title.png";

    }

    Flickable
    {
        id: listFlick;
        width: main.width/2;
        height: (main.height - Vals.topToolbarHeight - titleImage.height)/1.85;
        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: titleImage.bottom;
        anchors.topMargin: 0-(main.height/30);
        clip: true;

        contentWidth: width;
        contentHeight: contentItem.childrenRect.height;

        Rectangle  //debugging
        {
            anchors.fill: parent;
            color: "transparent"
        }
    }

    Repeater
    {
        model: 3

        Rectangle
        {
            anchors.horizontalCenter: listFlick.horizontalCenter;
            anchors.top: listFlick.bottom;
            anchors.topMargin: height*3*index + width

            width: main.width/50;
            height: width/10;

            color: "steelblue";
        }

    }

    // Sets the layout for the menu buttons
    Flow
    {
        parent: listFlick.contentItem;
        width: Vals.buttonWidth; //the flow is the same width as the buttons so the buttons are centered in the flow
        spacing: Vals.menuSpacing;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        anchors.topMargin: Vals.topMargin/2;

        MyButton //new game button
        {
            id: newGameButton;
            buttonText: "New Game";
            width: parent.width;
            fontSize: Vals.mediumLargeFontSize;
            textColor: "steelblue";
            onClick: (playButtonClicked());
        }

        MyButton //load game button .... does not currently work
        {
            id: newGameButton1;
            buttonText: "Load Game";
            width: parent.width;
            fontSize: Vals.mediumLargeFontSize;
            textColor: "steelblue";
            onClick: (playButtonClicked());
        }

        MyButton //help button
        {
            id: tutorialButton;
            buttonText: "How to Play";
            width: parent.width;
            fontSize: Vals.mediumLargeFontSize;
            textColor: "steelblue";
            onClick: (tutorialButtonClicked());
        }

        MyButton //settings button
        {
            id: settingsButton;
            buttonText: "Options";
            width: parent.width;
            fontSize: Vals.mediumLargeFontSize;
            textColor: "steelblue";
            onClick: (settingsButtonClicked());
        }
    }
}
