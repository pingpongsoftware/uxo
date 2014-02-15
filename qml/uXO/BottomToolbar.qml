import QtQuick 2.0

Rectangle
{
    id: main;
    state: "xTurn";
    signal resetButtonClicked();
    signal backButtonClicked();
    signal resizeGame();
    color: "transparent";

    Rectangle
    {
        id: visibleRect;
        color: "gray";
        anchors.fill: parent;
        opacity: .5
    }

    Rectangle // automatically formats the toolbar in a flow layout
    {
        id: rect;
        width: parent.width;
        height: parent.height;
        anchors.margins: 50;
        color: "transparent";

        property int leftRightMargin: 20;

        Image
        {
            id: xImage;
            source: "Images/" + Vals.theme + "/x.png";
            x: parent.leftRightMargin;
            anchors.verticalCenter: parent.verticalCenter;
        }

        Image
        {
            id: oImage;
            source: "Images/" + Vals.theme + "/o.png";
            x: main.width - parent.leftRightMargin - width;
            anchors.verticalCenter: parent.verticalCenter;
        }

    }

    function setTurn()
    {
        //sets the state of the toolbar
		if (GameTracker.xTurn)
            bottomToolbar.state = "xTurn";
        else bottomToolbar.state = "oTurn";
    }

    states:
    [
        //This changes the size and the opacity of the x and o on the toolbar depending on who's turn it is.

        State
        {
            name: "xTurn";
            PropertyChanges
            {
                target: xImage;
                height: main.height/1.2;
                width: height
                opacity: 1;
            }
            PropertyChanges
            {
                target: oImage;
                height: main.height/1.7;
                width: height
                opacity: .6;
            }
        },

        State
        {
            name: "oTurn";
            PropertyChanges
            {
                target: oImage;
                height: main.height/1.2;
                width: height
                opacity: 1;
            }
            PropertyChanges
            {
                target: xImage;
                height: main.height/1.7;
                width: height
                opacity: .6;
            }
        }
    ]

    transitions:
    [
        Transition
        {
            from: "*";
            to: "*";

            PropertyAnimation
            {
                properties: "width";
                duration: Vals.transitionTime;
            }
            PropertyAnimation
            {
                properties: "height";
                duration: Vals.transitionTime;
            }
            PropertyAnimation
            {
                properties: "opacity";
                duration: Vals.transitionTime;
            }
        }

    ]

}
