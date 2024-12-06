class rock extends Floater {
  private double dirRadians;
  private float size;
  private float rotVel;
  public rock(float _size, float[] _pos) {
    myColor = 255;
    myCenterX = _pos[0];
    myCenterY = _pos[1];
    myPointDirection = _random(0,360);
    dirRadians = myPointDirection*PI/180;
    myXspeed = Math.cos(dirRadians)*3;
    myYspeed = Math.sin(dirRadians)*3;
    size = _size;
    corners=6;
    xCorners = new int[corners];
    yCorners = new int[corners];
    rotVel = _random(-5,5);
    for (int i=0;i<corners;i++) {
      float _d = _random(size/2,size);
      xCorners[i] = (int)(Math.cos(i*2*PI/corners)*_d/2);
      yCorners[i] = (int)(Math.sin(i*2*PI/corners)*_d/2);
    }
  }
  
  public void move() {
    turn(rotVel);
    super.move();
  }
  
  /*public void show() {
    fill(myColor);
    noStroke();
    ellipse((float)myCenterX,(float)myCenterY,size,size);
  }*/
  
  public void bounce() {
    if (myCenterX<0) {
      myCenterX=0;
      myXspeed*=-1;
    }
    if (myCenterX>width) {
      myCenterX=width;
      myXspeed*=-1;
    }
    if (myCenterY<0) {
      myCenterY=0;
      myYspeed*=-1;
    }
    if (myCenterY>height) {
      myCenterY=height;
      myYspeed*=-1;
    }
  }
  
  public float[] getPos() {
    return new float[]{(float)myCenterX,(float)myCenterY};
  }
  
  public float getSize() {
    return size;
  }
}
