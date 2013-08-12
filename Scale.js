.pragma library

//Generic
var screenWidth = 700;
var screenHeight = screenWidth;

var rows = 3;
var columns = 3;

//Outer Grid
var bigGridSpacing = screenWidth/50;

var outerGridWidth = screenWidth - (bigGridSpacing*columns) - bigGridSpacing;
var outerGridHeight = screenHeight - (bigGridSpacing*rows) - bigGridSpacing;

//Inner Grid
var smallGridSpacing = screenWidth/120;

var innerRectWidth = outerGridWidth/columns;
var innerRectHeight = outerGridHeight/rows;

    //for the grid inside the rectangle
    var innerGridWidth = innerRectWidth - (smallGridSpacing*columns) - smallGridSpacing;
    var innerGridHeight = innerRectHeight - (smallGridSpacing*rows) - smallGridSpacing;

//Tic Tac Toe Square
var squareWidth = innerGridWidth/columns - 7;
var squareHeight = innerGridHeight/rows - 7;

//Toolbar
var toolbarWidth = screenWidth;
var toolbarHeight = 55;


//Game Title
var titleHeight = 50;
var titleWidth = screenWidth;

//makes the screen large enough to fit the toolbar and title
screenHeight += toolbarHeight + titleHeight;
