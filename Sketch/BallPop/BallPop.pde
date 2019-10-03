import java.io.FileReader;
import java.io.FileNotFoundException;
import processing.sound.*;

//GLOBALS
GamePlay gamePlay = new GamePlay(this);
MainMenu mainMenu = new MainMenu(this, gamePlay);
HighScores highScores = new HighScores(this);
DecimalFormat df = new DecimalFormat("0.000");

SoundFile bubble1, bubble2;

float timeCompleted;

int redValue = 255;
int blueValue = 0;
int greenValue = 0;

/*If value is 0, it's main menu screen
 If value is 1, it's main game screen
 If value is 2, it's high scores screen
 */
int currentWindow = 0;

void setup() {
  size(800, 800);
  noStroke();
  mainMenu.setupMainMenuBalls();
  highScores.readLeaderboard();
  highScores.setupHighScoreBalls();
  mainMenu.font = createFont("Courier New Bold", 48);

  bubble1 = new SoundFile(this, "bubble1.wav");
  bubble2 = new SoundFile(this, "bubble2.wav");
}

void draw() {
  gradientRainbow();

  if (currentWindow == 0) {
    mainMenu.draw();
    gamePlay = new GamePlay(this);
  } else if (currentWindow == 1) gamePlay.draw();
  else if (currentWindow == 2) highScores.draw();
}

void mouseClicked() {
  if (currentWindow == 0) {
    mainMenu.mouseClicked();
    highScores.username = "";
    timeCompleted = 0;
  } else if (currentWindow == 1) gamePlay.mouseClicked();
  else if (currentWindow == 2) highScores.mouseClicked();
}

void keyPressed() {
  if (currentWindow == 2) highScores.keyPressed();
  highScores.readLeaderboard();
}

/*
  gradientRainbow()
 Controls the rainbow gradient that happens when hovering over text.
 */
void gradientRainbow() {
  if ( greenValue<250 && redValue>=250 && blueValue==0) {
    greenValue+=2;
  }

  //go from yellow to pure green
  if (greenValue >= 250 && redValue>0) {
    //redToGreen = false;
    redValue-=2;
  }

  //go from green to cyan/bluish-green
  if (redValue<0 && greenValue>=250 && blueValue<250) {

    blueValue+=2;
  }

  //go from bluish-green to blue
  if (blueValue>= 250 && greenValue>0) {
    greenValue-=2;
  }
  // go from blue to violet
  if (redValue < 250 && greenValue==0 && blueValue>= 250) {
    redValue+=2;
  }
  //go from violet to red
  if (redValue >= 250 && blueValue>0) {
    blueValue-=2;
  }
}
