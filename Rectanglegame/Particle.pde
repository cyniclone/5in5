class Particle extends Entity {
  float xSpeed, ySpeed;
  boolean active = true;
  final float w = 10;
  final float h = 10;

  Particle (float x, float y, float w, float h) {
    super(x, y, w, h);
    xSpeed = random(-4, 4);
    ySpeed = random(3, 4);
    if (random(1) > 0.5f) {
      xSpeed *= -1;
    }
    ;
  }

  void update() {
    //    println(y);
    x += xSpeed;
    y += ySpeed;
  }

  void display() {
    fill(palette[5]);
    rect(x, y, w, h);
  }
}

