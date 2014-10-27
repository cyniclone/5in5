// Nicolas Aguirre 2014
// Designing Interactivity

/* Palette
 https://color.adobe.com/sandy-stone-beach-ocean-diver-color-theme-15325/
 color[] palette = {
 #E6E2AF, #A7A37E, #EFECCA, #046380, #002F2F*/

//SeaWolf https://color.adobe.com/Sea-Wolf-color-theme-782171/edit/?copy=true
color [] palette = {
  color(220, 53, 34), #D9CB9E, #374140, #2A2C2B, #1E1E20, 
  #CD75E8
};

int THRESHOLD = 50;
int score;

Player player;
Bullet bullet;
Enemy enemy;

boolean game;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Particle> particles = new ArrayList<Particle>();


void setup() {
  rectMode(CORNER);
  game = true;
  size (400, 800);
  noStroke();

  score = 30;

  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<Particle> particles  = new ArrayList<Particle>();

  player = new Player(width/2, 200, 60, 10);
}

void draw() {
  if (game) {
    background(palette[4]);

    update();
    checkCollision();
    display();

    textAlign(LEFT);

    fill(200);
    textSize(12);
    text("Nicolas Aguirre", width - 100, height-10);
    textSize(24);
    text(score, 5, height-10);
  } else {

    rectMode(CENTER);
    fill(80);
    stroke(#FAE119);
    rect(width/2, height/2, 300, 300);
    fill(#FAE119);
    textAlign(CENTER);
    textSize(24);
    text("GAME OVER", width/2, height/2);
    textSize(14);
    text("Press the space bar to reset.", width/2, height/2 + 80);
  }
}

void update () {
  player.update();

  // Every second make a new enemy
  if (frameCount % 45 == 0 ) {
    Enemy enemy = new Enemy(random(0, width-60), 20, 60, 10);
    enemies.add(enemy);
  }

  // Update each enemy
  for (int i = 0; i < enemies.size (); i++) {
    enemies.get(i).update();
  }

  // Update particles
  for (int i = 0; i < particles.size (); i++) {
    particles.get(i).update();
  }
}

void display () {
  player.display();

  //Draw threshold line
  fill(palette[2]);
  rect (0, height - THRESHOLD, width, 10);

  //Display each enemy
  for (int i = 0; i < enemies.size (); i++) {
    enemies.get(i).display();
  }

  //Display each particle

  for (int i = 0; i < particles.size (); i++) {
    particles.get(i).display();
  }
}

void checkCollision() {
  // Check enemy-bullet collision
  for (int i = 0; i < player.bullets.size (); i++) {
    bullet = player.bullets.get(i);

    for (int j = 0; j < enemies.size (); j++) {
      enemy = enemies.get(j);

      if (! (bullet.x+bullet.w < enemy.x || bullet.x > enemy.x+enemy.w
        || bullet.y > enemy.y + enemy.h || bullet.y + bullet.h < enemy.y))
      {
        // Invoke die function
        enemy.die();

        // Remove enemy and bullet from arraylist
        if (enemies.size() > 0) {
          enemies.remove(j);
        }
        if (player.bullets.size() > 0) {
          player.bullets.remove(i);
        }
      }
    }
  }

  // Check enemy-threshold collision
  for (int i = 0; i < enemies.size (); i++) {
    Enemy enemy = enemies.get(i);
    if (enemy.y + enemy.h > height - THRESHOLD) {
      game = false;
    }
  }

  // Check enemy-player collision
  if (enemies.size() > 0) {

    for (int i = 0; i < enemies.size (); i++) {
      Enemy enemy = enemies.get(i);
      if (! (player.x+player.w < enemy.x || player.x > enemy.x+enemy.w
        || player.y > enemy.y + enemy.h || player.y + player.h < enemy.y)) {
        game = false;
      }
    }
  }

  // Check particle collisions
  if (particles.size() > 0) {
    for (int i = 0; i < particles.size (); i++) {
      Particle particle = particles.get(i);
      //Check to see if player caught particle
      if (! (player.x+player.w < particle.x || player.x > particle.x+particle.w
        || player.y > particle.y + particle.h || player.y + player.h < particle.y)) {
        particles.remove(i);
      }

      // Check to see if particle passed threshold line
      if (particle.y > height - THRESHOLD && particle.active) {
        particle.active = false;
        score--;
      } 

      if (particle.x <= 0 || particle.x+particle.w >= width) {
        particle.xSpeed *= -1;
      }
      //      // Remove out of bounds particles
      //      if (particle.y > height || particle.x < 0 || particle.x + particle.w > width) {
      //        particles.remove(i);
      //      }
    }
  }

  // Check to see if score == 0
  if (score <= 0 ) {
    game = false;
  }
}
void mousePressed() {
  player.shoot(radians(90));
}

void keyPressed() {
  if (!game) {
    switch (key) {
    case ' ':
      game = true;
      if (enemies.size() > 0) {
        enemies.clear();
      }
      if (particles.size() > 0) {
        particles.clear();
      }
      setup();

      break;
    }
  }
}

