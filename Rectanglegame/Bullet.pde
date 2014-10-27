class Bullet {
  final int w = 10;
  final int h = w;
  float x, y;
  float xSpeed, ySpeed;

  Bullet (float x, float y, float xSpeed, float ySpeed) {
    this.x = x;
    this.y = y;
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }

  // ---------- DISPLAY METHOD ---------------------------------
  void display() {
    fill(220);

    rect(x - w/2, y - w/2, w, w);
  }

  // ---------- UPDATE VARIABLES AND POSITION --------------------
  void update() {
    x += xSpeed;
    y += ySpeed;
  }
}
