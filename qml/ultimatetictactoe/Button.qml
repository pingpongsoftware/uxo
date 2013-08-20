import QtQuick 2.0

Rectangle
{
    id: main;
    color: releasedColor;

    property color releasedColor: Qt.rgba(.2,.2,.2,.9);
    property color pressedColor: Qt.rgba(.2,.7,.8,.95);
    property color hoverColor: Qt.rgba(.2,.25,.3,.95);

    property string buttonText;

    signal click();

    Text
    {
        id: buttonTextBox
        anchors.centerIn: parent;
        font.pixelSize: 24;
        text: main.buttonText;
    }

    MouseArea
    {
        id: buttonMouseArea;
        anchors.fill: parent;
        hoverEnabled: true;

        onEntered: parent.color = parent.hoverColor;
        onExited: parent.color = parent.releasedColor;
        onPressed: parent.color = parent.pressedColor;
        onReleased:
        {
            parent.color = parent.releasedColor;
            click();
        }
    }
}
