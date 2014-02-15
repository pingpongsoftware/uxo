import QtQuick 2.0

Item
{
    clip: true;
    id: main;

    Rectangle
    {
        id: headerRect;
        width: parent.width;
        height: width/10;
        color: "firebrick"

        z: 1000; // so it is in front of everything else

        TrenchFontText
        {
            fontSize: Vals.mediumLargeFontSize;
            text: "Saved Games";
            color: "lightgray";
            fontBold: true;
            anchors.centerIn: parent;
        }
    }

    Component
    {
        id: listDelegate
        GameListItem
        {
            width: main.width
            height: width/9;
            text: name;
            rectOpacity: .5;

            Rectangle  //this is the thin line in between buttons
            {
                color:
                {
                    if (Vals.theme === "light")
                        "black";
                    else
                        "gray";
                }
                width: main.width;
                height: listView.spacing;
                anchors.top: parent.bottom;
            }
        }

    }

    ListModel
    {
         id: listModel

         Component.onCompleted:
         {
             for (var i = 1; i < 21; i++)
                 append( { name: "Game " + i} );
         }
     }

    ListView
    {
          id: listView
          width: main.width;
          height: main.height - headerRect.height;
          y: headerRect.height
          anchors.horizontalCenter: main.horizontalCenter;
          model: listModel
          delegate: listDelegate
          focus: true
          spacing: 1
          boundsBehavior: Flickable.StopAtBounds
          pressDelay: 50;
    }
}
