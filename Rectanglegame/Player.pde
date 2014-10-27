class Player extends Entity {
  //final float MOVESPEED = 3.5f;
  final float BULLET_SPEED = 8;
  final float CONSTRAINBOTTOM = THRESHOLD;
  final float CONSTRAINTOP = THRESHOLD + 20;

  ArrayList<Bullet> bullets; 
  ArrayList<Particle> particles;

  Player (float x, float y, float w, float h) {
    super(x, y, w, h);
    bullets = new ArrayList<Bullet>();
  }  

  void shoot(float t) {
    // Make new bullet and add to arraylist

      Bullet b = new Bullet(x + w/2, y + h/2, 0, -BULLET_SPEED);
    if (bullets.size() < 5) {
      bullets.add(b);
    }
  }
  
  void update() {
    // Update position
    x = constrain(mouseX - w/2, 0, width - w);
    y = constrain(mouseY, height-CONSTRAINTOP, height-CONSTRAINBOTTOM - h);
    
    
    // Update bullet coordinates
    for (int i = 0; i < bullets.size (); i++) {
      bullets.get(i).update();
    }
    
    //Remove out of bounds bullets
    for (int i = 0; i < bullets.size (); i++) {
      if (bullets.get(i).x < 0 || bullets.get(i).x > width || 
        bullets.get(i).y < 0 || bullets.get(i).y > height) {
        bullets.remove(i);
      }
    }
  }
  
  void display() {
    fill(palette[1]);
    rect(x, y, w, h);  
    
        //Display bullets
    for (int i = 0; i < bullets.size (); i++) {
      bullets.get(i).display();
    }
  }
}

