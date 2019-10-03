import java.text.DecimalFormat;

class GamePlay {

  //GLOBALS
  Ball balls[];
  BallPop bp;
  float time;
  int ballsDestroyed;
  int destroyedPrevious;
  long startTime;

  /*
    CONSTRUCTOR
   Deals with creating the GamePlay object.
   */
  GamePlay(BallPop bp) {
    balls = new Ball[30];

    for (int i = 0; i < balls.length; i++) {
      balls[i] = new Ball(false, 800, 800);
    }

    this.bp = bp;
  }

  /*
    draw()
   Deals with drawing the current game state on screen.
   */
  void draw() {
    //Wait 10 seconds
    if (0 > frameCount) {
      displayInstructions();
    } else {
      playGame();
    }
  }

  /*
    startGame()
   Does what it says, starts the game. An easy method call to have the game take control that makes more sense than reading
   than just calling draw.
   */
  void startGame() {
    if (bp.currentWindow == 1) {
      frameCount = -600;
      draw();
    }
  }

  /*
    displayInstructions()
   Will display the basic instructions of the game before a player will play the game. This is displayed
   for 10 seconds.
   */
  void displayInstructions() {
    //Display smaller logo
    background(#f0f0f0);
    PImage logo = loadImage("logo.png");
    logo.resize(400, 0);
    imageMode(CORNER);
    image(logo, 50, 50);

    //Display instructions
    textAlign(LEFT);
    textSize(32);
    fill(0);
    text("THE AIM OF THE GAME IS SIMPLE. 30 BALLS WILL APPEAR ON YOUR SCREEN, HIT ONE WITH YOUR MOUSE TO POP IT. TRY TO POP THEM ALL IN THE FASTEST TIME. GOOD LUCK!", 50, 150, width - 100, height - 50);
  }

  /*
    playGame()
   Deals with the actual game. This includes drawing all the balls on the screen, along with checking if
   any of the balls have been hit. It also deals with drawing the timer to the screen.
   */

  void playGame() {
    background(#f0f0f0);

    if (ballsDestroyed == balls.length) {
      if (frameCount > (time * 60) + 300) {
        bp.currentWindow = 2;
      }
      //Set the top global variable to the time that all balls were popped
      bp.timeCompleted = time;

      //Draw text "game completed" with the final time.
      textAlign(CENTER);
      textSize(48);

      fill(0);
      text("GAME FINISHED", width / 2, (height / 2) - 50);
      text("TIME:", (width / 2) - 100, (height / 2) + 50);

      fill(redValue, greenValue, blueValue);
      text(df.format(time), (width / 2) + 75, (height / 2) + 50);
    } else {
      destroyedPrevious = ballsDestroyed;
      ballsDestroyed = 0;

      //Draw all the balls on screen
      for (Ball ball : balls) {
        ball.draw();
        ball.move();
        ball.checkIfHit();
      }

      //Check to see if all balls have been destroyed or not
      for (Ball ball : balls) {
        if (ball.colour == color(#ffffff, 0)) ballsDestroyed++;
      }

      //Play pop sound
      if (ballsDestroyed > destroyedPrevious) {
        if (random(0, 1) < 0.5) {
          bubble1.play();
        } else {
          bubble2.play();
        }
      }
      
      //Display timer
      float millis = ((float) (frameCount) % 60F) / 60F;
      float seconds = frameCount / 60;

      time = seconds + millis;

      textSize(18);
      fill(0);
      text(time, 0, 20);
    }
  }

  void mouseClicked() {
  }
}
