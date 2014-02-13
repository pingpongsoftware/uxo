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

    property int dragMinY;
    property int dragMaxY;

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
        height: littleButton.y - y;
        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: titleImage.bottom;
        anchors.topMargin: 0;
        clip: true;

        contentWidth: width;
        contentHeight: contentItem.childrenRect.height;

        Component.onCompleted:
        {
            main.dragMinY = y*1.42;
            main.dragMaxY = y + contentHeight*1.1;
        }
    }

//    Item
//    {
//        anchors.fill: listFlick
//        Rectangle
//        {
//            x: 0-listFlick.contentX;
//            y: 0-listFlick.contentY;
//            width: listFlick.contentWidth;
//            height: listFlick.contentHeight;
//            opacity: .5
//        }
//    }



    // Sets the layout for the menu buttons
    Flow
    {
        parent: listFlick.contentItem;
        width: Vals.buttonWidth; //the flow is the same width as the buttons so the buttons are centered in the flow
        spacing: Vals.menuSpacing;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;

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


    Rectangle
    {
        id: littleButton;
        color: "transparent";
        width: main.height/5;
        height: width;

        y: (main.dragMinY + main.dragMaxY)/2;
        anchors.horizontalCenter: main.horizontalCenter;

        MouseArea
        {
            id: littleButtonMouse
            anchors.fill: parent;

            drag.target: parent;
            drag.axis: Drag.YAxis;
            drag.minimumY: main.dragMinY;
            drag.maximumY: main.dragMaxY;

            onPressed: console.log(parent.y)
        }
    }

    Repeater
    {
        model: 3

        Rectangle
        {
            anchors.horizontalCenter: littleButton.horizontalCenter;
            anchors.top: littleButton.top;
            anchors.topMargin: height*3*index + height*6;  // spreads them apart and centers them

            width: Math.round(littleButton.width/8);
            height: Math.round(width/10);

            color: "gray";
        }

    }
}
