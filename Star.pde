class star extends Floater {
  private double dirRadians;
  public star() {
    myColor = 255;
    myCenterX = _random(0,width);
    myCenterY = _random(0,height);
    myPointDirection = _random(0,360);
    dirRadians = myPointDirection*PI/180;
    myXspeed = Math.cos(dirRadians)*1;
    myYspeed = Math.sin(dirRadians)*1;
  }
  
  public void show() {
    stroke(255);
    noFill();
    ellipse((float)myCenterX,(float)myCenterY,5,5);
  }
  
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
}
