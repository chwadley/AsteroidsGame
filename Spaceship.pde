class ship extends Floater {
  //private float x,y,dx,dy,d;
  private boolean dashing;
  private int dashTimer;
  private float maxSpeed;
  
  public ship(float _x, float _y) {
    myColor=255;
    myCenterX=_x;
    myCenterY=_y;
    myXspeed=0;
    myYspeed=0;
    myPointDirection=0;
    dashing=false;
    corners=16;
    xCorners = new int[]{-4,-5,-5,-4,-3,-1, 0, 2, 3, 7, 8, 6, 2, -6,-6,-7,-7,-6,-6,2,6,8,7,3,2,0,-1,-3,-4,-5,-5,-4,-6,-6};
    yCorners = new int[]{-7,-8,-9,-8,-9,-7,-8,-6,-7,-3,-4,-6,-8,-10,-2,-2, 2, 2,10,8,6,4,3,7,6,8, 7, 9, 8, 9, 8, 7, 1,-1};
  }
  
  public void moveStepEachFrame() {
    if (keys[87]) {
      accelerate(0.5);
    }
    if (keys[83]) {
      accelerate(-0.5);
    }
    if (keys[65]) {
      turn(-5);
    }
    if (keys[68]) {
      turn(5);
    }
    dashTimer-=dashing?1:0;
    dashing=dashing&&dashTimer>0;
    fill(255);
    float sp=dist((float)myXspeed,(float)myYspeed,0,0);
    text(sp,50,50);
    float friction = 1;
    myXspeed*=dashing?0.98:friction;
    myYspeed*=dashing?0.98:friction;
    maxSpeed = 6.666;
    myXspeed=sp>maxSpeed&&!dashing?myXspeed*maxSpeed/sp:myXspeed; //these two lines are to make sure that the spaceship cannot gain too much speed.
    myYspeed=sp>maxSpeed&&!dashing?myYspeed*maxSpeed/sp:myYspeed; //this caps the player's speed at maxSpeed.
    move();
  }
  
  /*public void show() {
    fill(0);
    stroke(255);
    strokeWeight(dashing?2:1);
    push();
    translate((float)myCenterX,(float)myCenterY);
    rotate((float)myPointDirection);
    beginShape();
    vertex(-5,-5);
    vertex(0,0);
    vertex(-5,5);
    vertex(10,0);
    endShape(CLOSE);
    pop();
  }*/
  
  public float[] getPos() {
    return new float[]{(float)myCenterX,(float)myCenterY};
  }
  
  public float getD() {
    return (float)myPointDirection;
  }
  
  public float[] getVelocity() {
    return new float[]{(float)myXspeed,(float)myYspeed};
  }
  
  public void dash() {
    dashing=true;
    dashTimer=10;
    myXspeed=cos(radians((float)myPointDirection))*10;
    myYspeed=sin(radians((float)myPointDirection))*10;
  }
  
  public void warp() {
    myCenterX=_random(0,width);
    myCenterY=_random(0,height);
    myXspeed=0;
    myYspeed=0;
    myPointDirection=_random(0,2*PI);
  }
}
