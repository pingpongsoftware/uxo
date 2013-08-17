import QtQuick 2.0

Rectangle
{
    id: main;

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
            source: "Images/backArrow.png";
            sourceSize.height: parent.height;
            sourceSize.width: parent.height;
            anchors.centerIn: parent;
        }
    }
}
