class Enemy extends Entity {
  final float MOVESPEED = 2f;
  boolean glowing = false;
  int glow = 0;
  
  Enemy (float x, float y, float w, float h) {
    super(x, y, w, h);
  }  
  
  void display() {
    fill(220+glow, 53+glow, 34+glow);
    rect(x, y, w, h);  
  }
  
  void update() {
    y += MOVESPEED;
    glow();
  }
  
  void die() {
    //Make particles
    for (int i = 0; i < 3; i++) {
      Particle particle = new Particle(x, y, 10, 10);
      particles.add(particle);  
    }
  }
  
  void glow() {
    if (glowing) {
      glow++;
    } else {
      glow--;
    }
    if (glow >= 40) {
      glowing = !glowing;
    } else if (glow <= -40) {
      glowing = !glowing;  
    }
  }
}
