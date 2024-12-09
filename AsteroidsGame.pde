import java.util.*;

boolean[] keys = new boolean[91];

int mode = 0;

float _random(float a, float b) {
  return (float)(Math.random()*(b-a)+a);
}

float _dist(float[] a, float[] b) {
  return dist(a[0],a[1],b[0],b[1]);
}

int count=0;
boolean bullets=false;
boolean breakAsteroids=true;
boolean controls=true; //new=true
boolean laser=false;
ship s;
ArrayList <rock> rocks = new ArrayList <rock>();
ArrayList <particle> particles = new ArrayList <particle>();
star[] stars = new star[20];

void setup() {
  size(1500,800);
  s = new ship(width/2,height/2);
  for (int i=0;i<20;i++) { //20
    rocks.add(new rock(50,new float[]{_random(0,width),_random(0,height)}));
  }
  for (int i=0;i<stars.length;i++) {
    stars[i] = new star();
  }
}

void draw() {
  background(0);
  //text(Arrays.toString(keys),50,50);
  if (mode<4) {
    stroke(255);
    fill(0);
    rect(width/2-200,height/2-50,400,100);
    textAlign(CENTER,CENTER);
    fill(255);
    noStroke();
  }
  if (mode==0) {
    text("Run into asteroids to break them (indestructible ship)",width/2,height/2-25);
    text("Bullets break asteroids (destructible ship)",width/2,height/2+25); 
  }
  if (mode==1) {
    text("Asteroids break into smaller ones",width/2,height/2-25);
    text("Asteroids immediately disappear when broken",width/2,height/2+25);
  }
  if (mode==2) {
    text("Ship moves in the direction you input with WASD",width/2,height/2-25);
    text("A/D turns the ship",width/2,height/2+25);
  }
  if (mode==3) {
    text("Shoots one bullet at a time",width/2,height/2-25);
    text("Shoots a continuous laser beam",width/2,height/2+25);
  }
  if (mode==4) {
    for (int i=0;i<stars.length;i++) {
      star a = stars[i];
      a.move();
      a.show();
    }
    s.moveStepEachFrame();
    s.show();
    if (keys[76]&&bullets&&laser) {
      particles.add(new particle(s.getPos(),s.getD(),s.getVelocity()));
    }
    for (int i=0;i<rocks.size();i++) {
      rock a = (rock)rocks.get(i);
      a.move();
      a.show();
      for (int j=0;j<particles.size();j++) {
        //particle b = particles.get(j);
        if (_dist(a.getPos(),particles.get(j).getPos())<a.getSize()/2) {
          float _size=a.getSize();
          float[] _pos=a.getPos();
          rocks.remove(i);
          if (_size>10&&breakAsteroids) {
            rocks.add(i,new rock(_size/1.5,_pos));
            rocks.add(i,new rock(_size/1.5,_pos));
            i++;
          } else {
            i--;
          }
          count++;
          particles.remove(j);
          j--;
          break;
        }
      }
      if (_dist(a.getPos(),s.getPos())<a.getSize()/2) {
        if (bullets) {
          noLoop();
        } else {
          float _size=a.getSize();
          float[] _pos=a.getPos();
          rocks.remove(i);
          count++;
          if (breakAsteroids&&_size>10) {
            rocks.add(i,new rock(_size/1.5,_pos));
            rocks.add(i,new rock(_size/1.5,_pos));
            i++;
          } else {
            i--;
          }
        } //true, bat, ant, bat, [dog, cat]
      }
    }
    for (int i=0;i<particles.size();i++) {
      particle a = (particle)particles.get(i);
      a.move();
      a.show();
      
      if (a.check()) {
        particles.remove(i);
        i--;
      }
    }
    text(count,50,100);
    text(s.maxSpeed,50,150);
  }
}

void keyPressed() {
  if (keyCode==76&&!keys[76]&&!laser&&bullets) particles.add(new particle(s.getPos(),s.getD(),s.getVelocity()));
  if (keyCode<keys.length) keys[keyCode]=true;
  if (key==',') s.dash();
  if (key=='r') reset();
  if (keyCode==10) s.warp();
}

void keyReleased() {
  if (keyCode<keys.length) {
    keys[keyCode]=false;  
  }
}

void reset() {
  count=0;
  particles.clear();
  rocks.clear();
  setup();
  loop();
}

void mousePressed() {
  if (mouseX>=width/2-200&&mouseX<=width/2+200&&mouseY>=height/2-50&&mouseY<=height/2+50) {
    if (mouseY>height/2) {
      if (mode==0) {
        bullets = true;
      } else if (mode==1) {
        breakAsteroids = false;
      } else if (mode==2) {
        controls = false;
      } else if (mode==3) {
        laser = true;
      }
    }
    if (mode<4) mode++;
    if (mode==3&&!bullets) mode++;
  }
}
