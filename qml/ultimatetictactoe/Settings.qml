import QtQuick 2.0

Rectangle
{
    id: main;

    width: Vals.screenWidth;
    height: Vals.screenHeight;
    color: "transparent";

    signal switchThemeButtonClicked();

    //load fonts from a file
    FontLoader { id: prime_reg; source: "Fonts/Prime Regular.ttf" }

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

            width: parent.width/2;
            height: parent.height;
            anchors.centerIn: parent;

            spacing: Vals.menuSpacing;

            Text
            {
                id: title;

                width: parent.width;
                height: Vals.menuTitleHeight;

                text: "Settings";
                font.capitalization: Font.SmallCaps;
                font.bold: true;
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Vals.largeFontSize;
                font.letterSpacing: 2;
                font.wordSpacing: 0;
                font.family: prime_reg.name;
                color: {changeColorsToMatchTheme();}
                opacity: .6;

            }

            Text
            {
                id: setThemeText;

                width: parent.width;
                height: main.buttonHeight;

                text: "Select Theme";
                font.capitalization: Font.SmallCaps;
                //font.bold: true;
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Vals.mediumFontSize;
                font.family: prime_reg.name;
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

                Rectangle //The rectangles containing the buttons make it easier to center the buttons appropriately
                {
                    id: lightThemeRect;
                    width: parent.width/2;
                    height: parent.height
                    color: "transparent";

                    MyButton
                    {
                        id: lightThemeButton;

                        width: Vals.smallButtonWidth;
                        height: Vals.smallButtonHeight;
                        anchors.centerIn: parent;

                        buttonText: "Light"

                        fontSize: Vals.smallFontSize;
                        textColor: "lightgray"

                        onClick: switchTheme("light");
                    }
                }

                Rectangle
                {
                    id: darkThemeRect;
                    width: parent.width/2;
                    height: parent.height
                    color: "transparent";

                    MyButton
                    {
                        id: darkThemeButton;

                        width: Vals.smallButtonWidth;
                        height: Vals.smallButtonHeight;
                        anchors.centerIn: parent;

                        buttonText: "Dark"

                        fontSize: Vals.smallFontSize;
                        textColor: "#333333"

                        onClick: switchTheme("dark");
                    }
                }

            }

        }

        //-----Everything inside this rectangle mirrors the Flow layouts above.  This is in order for the rectangles that indicate the selected settings are correctly located.

        Rectangle //this rect has same size and position as the flow in order for the themeRect to be correctly positioned
        {
            id: flowRect
            height: flow.height;
            width: flow.width;
            x: flow.x;
            y: flow.y;
            z: -5; //so it is behind the other objects
            color: "transparent"    //change if you want to see the dimensions and position of the flow layout
            //opacity: .3;

            Rectangle
            {
                x: themeFlow.x;
                y: themeFlow.y;
                width: themeFlow.width;
                height: themeFlow.height;
                color: "transparent";
                //opacity: .3;

                Rectangle
                {
                    id: themeRect;
                    width: lightThemeButton.width;
                    height: lightThemeButton.height;
                    radius: height;
                    color: "steelblue";
                    //opacity: .8;
                    z: -5; //so it is behind the other objects

                    y: lightThemeButton.y;//*.986;  //For some reason it wasn't quite centered on the text, so multiplying it by .986 fixes that problem
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
                            PropertyChanges
                            {
                                target: themeRect;
                                x: darkThemeRect.x + (darkThemeRect.width-themeRect.width)/2;
                            }
                        },
                        State
                        {
                            name: "lightState";
                            PropertyChanges
                            {
                                target: themeRect;
                                x: lightThemeRect.x + (lightThemeRect.width-themeRect.width)/2;
                            }
                        }
                    ]

                    transitions:  //makes the themeRect move between locations instead of jump between locations
                    [
                        Transition
                        {
                            from: "*";
                            to: "*";

                            PropertyAnimation
                            {
                                properties: "x";
                                duration: 150;  // if this is changed, be sure the duration of the animation in Main.qml is also changed.
                            }
//                            PropertyAnimation
//                            {
//                                properties: "height";
//                                duration: 150;
//                            }
                        }

                    ]

                }
            }



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
