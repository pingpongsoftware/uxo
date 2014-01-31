import QtQuick 2.2

Rectangle
{
    id: main;
    color: Qt.rgba(0,0,0,.7);

    property string messageText;
    property string buttonOneText;
    property string buttonTwoText;

    signal buttonOneClicked();
    signal buttonTwoClicked();

    Rectangle
    {
        anchors.centerIn: parent;
        width: 300;
        height: 130;
        color: Qt.rgba(0,0,0,.95);
        radius:5;

        Text
        {
            id: messageTextBox;
            anchors.centerIn: parent
            width: parent.width - 10;
            height: parent.height - 10;
            color: "white"
            font.pixelSize: 20;
            wrapMode: Text.WordWrap;
            text: main.messageText;
        }

        Button
        {
            id: button1;
            width: parent.width/2 - anchors.margins*2;
            height: 40;
            radius: parent.radius;
            color: releasedColor;

            anchors.left: parent.left;
            anchors.bottom: parent.bottom;
            anchors.margins: 5;

            buttonText: main.buttonOneText;

            onClick:
            {
                buttonOneClicked();
            }
        }   

        Button
        {
            id: button2;
            width: parent.width/2 - anchors.margins*2;
            height: 40;
            radius: parent.radius;
            color: releasedColor;

            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            anchors.margins: button1.anchors.margins;

            buttonText: main.buttonTwoText;

            onClick:
            {
                buttonTwoClicked();
            }
        }
    }

    function destroy()
    {
        parent.color = parent.releasedColor;
        main.visible = false;
    }
}
