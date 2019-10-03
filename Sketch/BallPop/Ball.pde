class Ball {

  float x, y;
  float size;
  color colour;
  float dy, dx;

  /*
    CONSTRUCTOR
   Deals with setting up a Ball object. Takes in a boolean that determines whether or not the balls are being
   used on the main menu or not. If set to TRUE, the balls are set to have an opacity of around 25%, if FALSE, 
   opacity is set to 100%.
   */
  Ball(boolean mainMenu, float w, float h) {
    size = random(10, 100);
    x = random(w - size);
    y = random(h - size);

    if (mainMenu) {
      colour = color(random(255), random(255), random(255), 75);
    } else {
      colour = color(random(255), random(255), random(255));
    }
    dy = random(-2, 2);
    dx = random(-2, 2);
  }

  /*
    draw()
   Deals with drawing the balls on screen.
   */
  void draw() {
    noStroke();
    fill(colour);
    circle(x, y, size);
  }

  /*
    move()
   Deals with moving balls around the screen. Also deals with bouncing balls of the grid borders to ensure
   that they stay in the grid.
   */
  void move() {
    if (x <= size/2) dx = abs(dx);
    if (y <= size/2) dy = abs(dy);
    if (x >= width-size/2) dx = -abs(dx);
    if (y >= height-size/2) dy = -abs(dy);

    x += dx;
    y += dy;
  }

  /*
    checkIfHit()
   Checks to see if the mouse is within a circle object. If so, it returns TRUE, otherwise it returns FALSE.
   */
  boolean checkIfHit() {
    if (dist(x, y, mouseX, mouseY) < size / 2) {
      colour = color(#ffffff, 0);
      return true;
    } else {
      return false;
    }
  }
}
