import QtQuick 2.2

Rectangle
{
    id: main;

    property color releasedColor: Qt.rgba(0,0,0,.5);
    property color enteredColor: Qt.rgba(0,0,0,.55);
    property color pressedColor: Qt.rgba(0,0,0,1);

    signal backButtonClicked();

    Rectangle
    {
        id: backRect;
        color: Qt.rgba(0,0,0,.2);
        width: main.height / 1.3;
        height: width;
        anchors.verticalCenter: parent.verticalCenter;
        x: (parent.height - height)/2
        radius: 10;

        Image
        {
            id: backImage;
            source: "Images/" + Vals.theme + "/backArrow.png";
            sourceSize.height: parent.height;
            sourceSize.width: parent.height;
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
                backButtonClicked();
                GameTracker_js.resetGame();

            }
        }
    }
}
