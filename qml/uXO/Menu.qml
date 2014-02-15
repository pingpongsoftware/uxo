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

    property int dragMinY: listRect.y * 1.20;
    property int dragMaxY: main.height - Vals.topToolbarHeight*2

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

    MouseArea
    {
        id: swipeRect;

        anchors.fill: parent;

        property bool isPressed: false;
        property bool hasPositionChanged: false;
        property int pressedY;
        property int frameCounter: 0;

        onPressed:
        {
            isPressed = true;
            pressedY = mouse.y
        }

        onPositionChanged:
        {
            frameCounter++;

            if (isPressed)
            {
                hasPositionChanged = true;

                if (frameCounter === 3)
                {
                    if (pressedY > mouse.y)  //if they are dragging up
                        littleButton.y = main.dragMinY;
                    else if (pressedY < mouse.y)
                        littleButton.y = main.dragMaxY;
                }
            }
        }

        onReleased:
        {
            frameCounter = 0;
            isPressed = false;
            hasPositionChanged = false;
        }
    }

    Rectangle
    {
        id: listRect;
        color: "transparent"
        width: main.width/2;
        height: littleButton.y - y;
        anchors.horizontalCenter: main.horizontalCenter;
        anchors.top: titleImage.bottom;
        anchors.topMargin: 0;
        clip: true;
    }

    // Sets the layout for the menu buttons
    Flow
    {
        id: menuFlow;
        parent: listRect
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
        width: main.width;
        height: width/5;

        y: main.height //listFlick.y + listFlick.contentHeight*1.1;  //this is equal to main.dragMaxY, but if I explicitly set it to that to being, it does weird things

        Component.onCompleted: y = main.dragMaxY

        anchors.horizontalCenter: main.horizontalCenter;

        Behavior on y
        {
            NumberAnimation { duration: Vals.transitionTime*3; easing.type: Easing.OutBack }
        }

        MouseArea
        {
            id: littleButtonMouse
            anchors.fill: parent;

            property bool isPressed: false;
            property bool hasPositionChanged: false;
            property int pressedY;
            property int frameCounter: 0;

            onPressed:
            {
                isPressed = true;
                pressedY = mouse.y
            }

            onPositionChanged:
            {
                frameCounter++;

                if (isPressed)
                {
                    hasPositionChanged = true;

                    if (frameCounter === 3)
                    {
                        if (pressedY > mouse.y)  //if they are dragging up
                            littleButton.y = main.dragMinY;
                        else if (pressedY < mouse.y)
                            littleButton.y = main.dragMaxY;
                    }
                }
            }

            onReleased:
            {
                frameCounter = 0;
                isPressed = false;
                hasPositionChanged = false;
            }

            onClicked:
            {
                if (!hasPositionChanged)
                {
                    if (littleButton.y === main.dragMinY)
                        littleButton.y = main.dragMaxY;
                    else if (littleButton.y === main.dragMaxY)
                        littleButton.y = main.dragMinY;
                }
            }
        }
    }

    Repeater  //the three little rectangles below the menu list
    {
        model: 3

        Rectangle
        {
            anchors.horizontalCenter: littleButton.horizontalCenter;
            anchors.top: littleButton.top;
            anchors.topMargin: height*3*index + height*3;  // spreads them apart and centers them

            width: Math.round(littleButton.height/5);
            height: Math.round(width/12);

            color: "gray";
        }

    }

    GameList
    {
        anchors.horizontalCenter: main.horizontalCenter;
        y: littleButton.y + littleButton.height/4;
        width: main.width
        height: Math.round((main.height - y)*.931);
    }
}
