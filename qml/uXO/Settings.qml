import QtQuick 2.0

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    signal switchThemeButtonClicked();

    Flickable
    {
        id: flowListFLickable;
        width: main.width;
        height: Vals.menuTitleHeight + main.buttonHeight + main.smallButtonHeight + flow.spacing*2;  //this is the height of all the objects in the flow added together plus the spacing (20 is the spacing of the flow and the number multiplied by 20 is the number of objects in it)


        anchors.top: main.top;
        anchors.topMargin: Vals.topMargin;
        anchors.horizontalCenter: main.horizontalCenter;

        interactive: true;

        contentWidth: width;
        contentHeight: main.height;


        Flow  //This makes all of the settings easier to position
        {
            id: flow;

            width: parent.width/2.5;
            height: parent.height;
            anchors.centerIn: parent;

            spacing: Vals.menuSpacing/2;

            TrenchFontText
            {
                id: title;

                width: parent.width;
                height: Vals.menuTitleHeight;

                text: "Options";
                font.pixelSize: Vals.largeFontSize;
                font.letterSpacing: 2;
                font.wordSpacing: 0;
                color: {changeColorsToMatchTheme();}
                opacity: .6;

            }

            TrenchFontText
            {
                id: setThemeText;

                width: parent.width;
                height: main.buttonHeight;

                text: "Select Theme";
                fontSize: Vals.mediumLargeFontSize;
                color: {changeColorsToMatchTheme();}
                opacity: .7;

            }

            Flow //to easier format the theme buttons
            {
                id: themeFlow
                width: parent.width;
                spacing: 0;
                height: Vals.smallButtonHeight;
                //effectiveLayoutDirection: Flow.LeftToRight;

                MyButton
                {
                    id: lightThemeButton;

                    width: parent.width/2;
                    height: getClickableHeight()*1.5;

                    buttonText: "Light"
                    fontBold: false;

                    fontSize: Vals.mediumFontSize;
                    textColor: "lightgray"

                    onClick: switchTheme("light");
                }

                MyButton
                {
                    id: darkThemeButton;

                    width: lightThemeButton.width;
                    height: lightThemeButton.height;

                    buttonText: "Dark"
                    fontBold: lightThemeButton.fontBold;

                    fontSize: lightThemeButton.fontSize;
                    textColor: "#333333"

                    onClick: switchTheme("dark");
                }

            }

        }

        Rectangle
        {
            id: themeRect;
            width: lightThemeButton.getClickableWidth()*1.8;
            height: lightThemeButton.getClickableHeight();
            radius: height;
            color: "steelblue";
            //opacity: .8;
            z: -5; //so it is behind the other objects

            property int lightX: (lightThemeButton.x + (lightThemeButton.width-themeRect.width)/2) + flow.x + themeFlow.x;
            property int darkX: (darkThemeButton.x + (darkThemeButton.width-themeRect.width)/2) + flow.x + themeFlow.x;

            y: lightThemeButton.getRelativeClickableY() + lightThemeButton.getClickableHeight()/2 + flow.y + themeFlow.y;
            state:
            {
                if (Vals.theme === "dark")
                    "darkState";
                else if (Vals.theme === "light")
                    "lightState"
            }

            states:  //the state its in determines its location
            [
                State
                {
                    name: "darkState";
                    PropertyChanges { target: themeRect; x: themeRect.darkX; }
                },
                State
                {
                    name: "lightState";
                    PropertyChanges { target: themeRect; x: themeRect.lightX; }
                }
            ]

            transitions:  //makes the themeRect move between locations instead of jump between locations
            [
                Transition { from: "*"; to: "*"; PropertyAnimation { properties: "x"; duration: Vals.transitionTime; } }

            ]

        }

    }

    function switchTheme(theme)
    {
        Vals.setTheme(theme)

        if (theme === "dark")
            themeRect.state = "darkState";

        else if (theme === "light")
            themeRect.state = "lightState";

        switchThemeButtonClicked(); //sends signal to the main.qml file so the background image will change
        changeColorsToMatchTheme(); //calls the function that changes the colors of all the text and button, etc.

        console.log(Vals.theme);

    }

    function changeColorsToMatchTheme()
    {
        if (Vals.theme === "light")
        {
            title.color = "firebrick";
            setThemeText.color = "firebrick";
        }

        else if (Vals.theme === "dark")
        {
            title.color = "white"
            setThemeText.color = "steelblue";
        }

    }


}
