import java.util.regex.*;   //<>// //<>//

class HighScores { //<>// //<>// //<>//

  //GLOBALS
  BallPop bp;
  ArrayList<String[]> leaderboard = new ArrayList();
  Ball[] balls;
  String username = "";

  HighScores(BallPop bp) {
    this.bp = bp;
  }

  void draw() {
    drawHighScores();
  }

  void drawHighScores() {
    background(#f0f0f0);

    //Draw balls in the background
    for (Ball menuBall : balls) {
      menuBall.draw();
      menuBall.move();
    }

    fill(0);
    textSize(48);
    printLeaderboard();

    if (checkIfCanAddToLeaderboard()) {
      //Print using rainbow
      fill(bp.redValue, bp.greenValue, bp.blueValue);
      textAlign(CENTER);
      text("NEW HIGH SCORE: " + df.format(bp.timeCompleted), width / 2, 50);

      fill(0);
      text("PRESS ENTER TO SAVE", width / 2, height - 50);

      textAlign(LEFT);
      text("ENTER NAME: " + username, 100, 150);
    } else {
      fill(bp.redValue, bp.greenValue, bp.blueValue);
      textAlign(CENTER);
      text("HIGH SCORE LEADERBOARD", width / 2, 100);

      fill(0);
      text("PRESS ENTER TO EXIT", width / 2, height - 50);
    }
  }

  void setupHighScoreBalls() {
    balls = new Ball[50];

    for (int i = 0; i < balls.length; i++) {
      balls[i] = new Ball(true, width, height);
    }
  }

  void readLeaderboard() {
    leaderboard.clear();
    String[] rows = loadStrings("leaderboard.csv");

    for (int i = 0; i < rows.length; i++) {
      String[] values = rows[i].split(","); 
      leaderboard.add(values);
    }
  }

  void saveToLeaderboard(String username, float time) {
    String[] newRecord = new String[2];

    newRecord[0] = username;
    newRecord[1] = df.format(time);

    for (int i = 0; i < leaderboard.size(); i++) {
      String[] row = leaderboard.get(i);
      if (bp.timeCompleted < Float.parseFloat(row[1])) {
        leaderboard.add(i, newRecord);
        break;
      }
    }

    //Remove the 6th entry, as leaderboard only has top 5.
    leaderboard.remove(5);

    //Write to file
    String[] newLeaderboard = new String[5];

    for (int i = 0; i < leaderboard.size(); i++) {
      String[] record = leaderboard.get(i);
      newLeaderboard[i] = record[0] + "," + record[1];
    }

    saveStrings(dataPath("leaderboard.csv"), newLeaderboard);
  }

  void printLeaderboard() {
    //Print current high score leaderboard
    int yChange = 0;

    for (int i = 0; i < leaderboard.size(); i++) {
      String[] row = leaderboard.get(i);

      textAlign(LEFT);
      text(row[0], 150, 300 + yChange);

      textAlign(RIGHT);
      text(row[1], 650, 300 + yChange);

      yChange += 75;
    }
  }

  boolean checkIfCanAddToLeaderboard() {
    if (bp.timeCompleted == 0) return false;

    for (int i = 0; i < leaderboard.size(); i++) {
      String[] row = leaderboard.get(i);
      if (bp.timeCompleted < Float.parseFloat(row[1])) return true;
    }

    return false;
  }

  void mouseClicked() {
  }

  void keyPressed() {
    if (checkIfCanAddToLeaderboard()) {

      //Allow maximum of 8 characters
      if (!Pattern.matches("^.{0,8}$", username)) {
        username = username.substring(0, 8);
      } else {
        switch (key) {
        case BACKSPACE:
          if (username.length() > 0) {
            username = username.substring(0, max(0, username.length() - 1));
          }
          break;
        case ENTER:
        case RETURN:
          println("this does in fact get called");
          saveToLeaderboard(username, bp.timeCompleted);
          try {
            Thread.sleep(3000);
          } 
          catch (Exception ex) {
          }
          bp.currentWindow = 0;
          break;
        //case SHIFT:
        //case CONTROL:
        //case TAB:
        //  break;
        default:
          username += key;
          break;
        }
      }
    } else {
      if (key == ENTER || key == RETURN) {
        bp.currentWindow = 0;
      }
    }
  }
}
