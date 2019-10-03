class MainMenu { //<>// //<>// //<>//

  //GLOBALS
  Ball balls[];
  String ver = "v1.0.0";

  color startTextColour;
  PFont font;

  float startTextSize, highScoreTextSize;

  GamePlay mainGame;

  MainMenu(GamePlay gp) {
    this.mainGame = gp;
  }

  /*
  draw()
   Draws onto the grid every 60 seconds.
   */
  void draw() {
    if (currentWindow == 0) {
      background(#f0f0f0);
      drawMainMenu();
    }
  }

  /*
  setupMainMenuBalls()
   Sets up the background bouncing balls on the main menu
   */
  void setupMainMenuBalls() {
    balls = new Ball[50];

    for (int i = 0; i < balls.length; i++) {
      balls[i] = new Ball(true, width, height);
    }
  }

  /*
    drawMainMenu()
   Draws the main menu onto the grid. Also deals with drawing 50 transparent balls that
   bounce around in the background to make it more visually appealing.
   */
  void drawMainMenu() {
    //Draw balls in the background
    for (Ball menuBall : balls) {
      menuBall.draw();
      menuBall.move();
    }

    //Setup the image logo
    PImage logo = loadImage("logo.png");
    imageMode(CENTER);
    image(logo, width / 2, 200);

    //Draw menu options beneath
    String szStartButton = "START";
    String szHighScoreButton = "HIGH SCORES";

    startTextColour = 0;

    textAlign(CENTER);
    textFont(font, 48);

    fill(startTextColour);
    startTextSize = textWidth(szStartButton);
    highScoreTextSize = textWidth(szHighScoreButton);

    if (!checkMainMenuHover()) {
      text("START", width / 2, height / 2); 
      text("HIGH SCORES", width / 2, (height / 2) + 75);

      textFont(font, 16);
      textAlign(LEFT);
      text(ver, 5, height - 5);
    }

    //Draw current time
    fill(startTextColour);
    textAlign(RIGHT);
    textFont(font, 16);
    text(String.format("%02d:%02d:%02d", hour(), minute(), second()), width - 5, height - 5);
  }

  /*
 checkMainMenuHover()
   Checks to see if the mouse is hovering over one of the two options, and if so,
   starts to animate the text by having the fill a rainbow gradient to show it
   being highlighted.
   */
  boolean checkMainMenuHover() {  
    //Check if start button is being hovered over
    if (mouseY < (height / 2) && mouseY > ((height / 2) - 36)
      && mouseX > ((width / 2) - (startTextSize / 2)) && mouseX < ((width / 2) + (startTextSize / 2))) 
    {
      textAlign(CENTER);
      fill(redValue, greenValue, blueValue);
      textFont(font, 48);
      text("START", width / 2, height / 2);
      return true;
    }
    //Check if high score button is being hovered over
    else if (mouseY < ((height / 2) + 75) && mouseY > ((height / 2) + 75 - 36)
      && mouseX > ((width / 2) - (highScoreTextSize / 2)) && mouseX < ((width / 2) + (highScoreTextSize / 2))) 
    {
      textAlign(CENTER);
      fill(redValue, greenValue, blueValue);
      textFont(font, 48);
      text("HIGH SCORES", width / 2, (height / 2) + 75);
      return true;
      //Check if version number is being hovered over
    } else if (mouseY < height && mouseY > height - 20 && mouseX > 0 && mouseX < 68) {
      fill(redValue, greenValue, blueValue);
      textFont(font, 16);
      textAlign(LEFT);
      text(ver, 5, height - 5);
      return true;
    } else {
      return false;
    }
  }

  /*
  mouseClicked()
   Deals with handling mouse clicks. This is used to see what button has been pressed on the main menu.
   */
  void mouseClicked() {    
    //Check if start button has been clicked
    if (mouseY < (height / 2) && mouseY > ((height / 2) - 36)
      && mouseX > ((width / 2) - (startTextSize / 2)) && mouseX < ((width / 2) + (startTextSize / 2))) 
    {
      //Set current window to game mode
      currentWindow = 1;
      mainGame.startGame();
    }
    //Check if high score button has been clicked
    else if (mouseY < ((height / 2) + 75) && mouseY > ((height / 2) + 75 - 36)
      && mouseX > ((width / 2) - (highScoreTextSize / 2)) && mouseX < ((width / 2) + (highScoreTextSize / 2))) 
    {
      currentWindow = 2;
    }
    //Check if version number has been clicked
    else if (mouseY < height && mouseY > height - 20 && mouseX > 0 && mouseX < 68) {
      String about = "";

      for (String line : loadStrings("about.txt")) {
        about = about + "\r\n" + line;
      }

      javax.swing.JOptionPane.showMessageDialog(null, about, "About BubblePop", javax.swing.JOptionPane.PLAIN_MESSAGE);
    }
  }
}
