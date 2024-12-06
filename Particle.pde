class particle extends Floater {
  private double dirRadians;
  public particle(float[] pos,float d,float[] momentum) {
    myColor = 255;
    myCenterX = pos[0];
    myCenterY = pos[1];
    myPointDirection = d;
    dirRadians = myPointDirection*PI/180;
    myXspeed = Math.cos(dirRadians)*10+momentum[0];
    myYspeed = Math.sin(dirRadians)*10+momentum[1];
  }
  
  public void show() {
    noStroke();
    fill(255);
    ellipse((float)myCenterX,(float)myCenterY,5,5);
  }
  
  public boolean check() {
    return myCenterX<0||myCenterX>width||myCenterY<0||myCenterY>height;
  }
  
  public float[] getPos() {
    return new float[]{(float)myCenterX,(float)myCenterY};
  }
  
  public float getSize() {
    return 5;
  }
}
