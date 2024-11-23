import java.util.*;

boolean[] keys = new boolean[91];

float _random(float a, float b) {
  return (float)(Math.random()*(b-a)+a);
}

float _dist(float[] a, float[] b) {
  return dist(a[0],a[1],b[0],b[1]);
}

int count=0;
ship s;
ArrayList <rock> rocks = new ArrayList <rock>();
star[] stars = new star[20];

void setup() {
  size(1500,800);
  s = new ship(width/2,height/2);
  for (int i=0;i<20;i++) {
    rocks.add(new rock(50,new float[]{_random(0,width),_random(0,height)}));
  }
  for (int i=0;i<stars.length;i++) {
    stars[i] = new star();
  }
}

void draw() {
  background(0);
  //text(Arrays.toString(keys),50,50);
  for (int i=0;i<stars.length;i++) {
    star a = stars[i];
    a.move();
    a.show();
  }
  s.moveStepEachFrame();
  s.show();
  if (keys[76]) {
    //particles.add(new particle(s.getPos(),s.getD(),s.getVelocity(),10));
  }
  for (int i=0;i<rocks.size();i++) {
    rock a = (rock)rocks.get(i);
    a.move();
    a.show();
    if (_dist(a.getPos(),s.getPos())<a.getSize()/2) {
      noLoop();
    }
  }
  text(count,50,100);
  text(s.maxSpeed,50,150);
}

void keyPressed() {
  System.out.println(keyCode);
  if (keyCode<keys.length) {
    keys[keyCode]=true;
  }
  if (key==',') {
    s.dash();
  }
  if (key=='r') {
    count=0;
    //particles.clear();
    rocks.clear();
    setup();
    loop();
  }
  if (keyCode==10) {
    s.warp();
  }
  if (keyCode==76) {
    //particles.add(new particle(s.getPos(),s.getD(),s.getVelocity(),10));
  }
}

void keyReleased() {
  if (keyCode<keys.length) {
    keys[keyCode]=false;  
  }
}

