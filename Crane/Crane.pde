 
boolean ortho = false;  //used to toggle betwen orthographic and perspective projection

float perspectiveX = 0;  //used to rotate the crane for views
float perspectiveY = 0;  

boolean animate = false;
boolean firsthalf = false;

boolean openClaw = false;   //used to animate the claw 
boolean closeClaw = false;

float targetcableLength_start = 8.0;    //used for our special animation sequence
float targetopenAngle = 20;
float targetcableLength_end = 1;

float armAngles = 0; //used to rotate the arm (indefinite)
float cranePosition = -200; //used to move the crane (-200 - 200)
float cableLength = 1; //used to extend/retract cable (1 - 10)
float clawRotation = 275; //used to rotate the claw (indefinite)
float openAngle = 12; //used to open the claw (20 / 12)

float size = 100;
void setup() {
  size(640, 750, P3D);
}

void draw() {
  background(255, 255, 255);

  clawMachine(armAngles, cranePosition, cableLength, clawRotation, openAngle);
  prizes();

  //special animation sequence
  if(animate == true)
    animate();
  
  //claw animations
  if(openClaw == true)
    animateClawOpen();
  if(closeClaw == true)
    animateClawClose();
    
}

void animateClawOpen(){
 if(openClaw){
   //claw is closed, open it
   if(openAngle < 20){
     openAngle += .2;
   }else{
     openClaw = false;
   }
 } 
}

void animateClawClose(){
if(closeClaw){
   //claw is open, close it
   if(openAngle > 12){
     openAngle -= .2;
   }else{
     closeClaw = false;
   }  
 }
}
void animate(){
  if(firsthalf == false){
    if(openAngle < targetopenAngle){
      openAngle+=.2;
    }else if(cableLength < targetcableLength_start){
      cableLength+=.2;
    }else{
      firsthalf = true;
    }
  }
  if(firsthalf){
    if(openAngle > 12){
      openAngle-=.2; 
    }else if(cableLength > targetcableLength_end) {
        cableLength-=.2; 
    }else{
      firsthalf = false;
        animate = false;
    }
  }
}

void clawMachine(float armAngle, float armPos, float cableLength, float clawRotation, float openAngle) {
  rotateX(radians(perspectiveX));
  rotateY(radians(perspectiveY));
  mount();
  arm(armAngle, armPos, cableLength, clawRotation, openAngle);
  
}

void mount() {
  fill(color(224, 224, 224));

  pushMatrix();
  translate(width/2, 100);
  rotateY(radians(30));
  box(100, 50, 50);

  popMatrix();
}

void arm(float armAngle, float armPos, float cableLength, float clawRotation, float openAngle) {
  pushMatrix();
  fill(color(204, 102, 224));
  translate(width/2, 140);
  rotateY(radians(armAngle));
  box(400, 30, 30);
  crane(armPos, cableLength, clawRotation, openAngle);
  popMatrix();
}

void crane(float armPos, float cableLength, float clawRotation, float openAngle) {
  fill(color(0, 153, 0));
  pushMatrix();
  translate(armPos, 40);
  box(50, 50, 50);
  cable(cableLength);
  claw(40*cableLength, clawRotation, openAngle);
  popMatrix();
}

void cable(float cableLength) {
  fill(color(255, 255, 0));
  pushMatrix();
  translate(0, 40*(cableLength/2));
  scale(1, cableLength);
  box(5, 50, 5);
  popMatrix();
}

void claw(float position, float clawRotation, float openAngle) {
  fill(color(0, 0, 255)); 
  pushMatrix();
  translate(0, 35+position);
  rotateY(radians(clawRotation));
  box(50, 50, 50);
  clawArm(openAngle);
  popMatrix();
}

void clawArm(float openAngle) {
  fill(color(51,255,255));
  float openAngleR = openAngle;
  float openAngleL = -(openAngle);
  
  //left arm
  pushMatrix();
  translate(0, 35, openAngleR);
  rotateX(radians(15));
  box(10, 30, 10);
  popMatrix();
  
  //left sphere
  pushMatrix();
  translate(0, 50, openAngleR+5);
  sphere(8);
  popMatrix();
  
  //left finger
  pushMatrix();
  translate(0, 75, openAngleR);
  rotateX(radians(-15));
  box(10, 45, 10);
  popMatrix();
  
  //right arm
  pushMatrix();
  translate(0, 35, openAngleL);
  rotateX(radians(-15));
  box(10, 30, 10);
  popMatrix();
  
  //right sphere
  pushMatrix();
  translate(0, 50, openAngleL-5);
  sphere(8);
  popMatrix();
  
  
  //right finger
  pushMatrix();
  translate(0, 75, openAngleL);
  rotateX(radians(15));
  box(10, 45, 10);
  popMatrix();

}

void keyPressed() {
  //toggle between orthographic and perspective projection
  if(key == 'o' || key == 'O'){
    ortho = true;
  }
  if(key == 'p' || key == 'P'){
    ortho = false;
  }
  
  //toggle between views
  if (key == '1') {   
    if(!ortho){
      perspectiveX = -50;
      perspectiveY = 0;
      frustum(-width/2.5, width/2.5, -height/2.5, height/2.5, 400,-400); // Same as ortho()
    }
    else
    ortho(-width, width, -height, height); // Same as ortho()
    //loop();
  }if (key == '2') {
    if(!ortho){
      perspectiveX = 20;
      perspectiveY = 0;
      frustum(-width/2.5, width/2.5, -height/2.5, height/2.5, 200,-200); // Same as ortho()
    }
    else
      ortho(-width/1.5, width/1.5, -height/1.5, height/1.5); // Same as ortho()
    //loop();
  }if (key == '3') {
    if(!ortho){
      perspectiveX = -20;
      perspectiveY = -20;
      frustum(-width/2.5, width/2.5, -height/2.5, height/2.5, 200,-200); // Same as ortho()
    }  
    else
      ortho(-width/2, width/2, -height/2, height/2); // Same as ortho()
    //loop();
  }
  
  //full animation
  if(key == ' '){
   animate = true; 
  }
  
  //crane animations
  if (key == 'q' || key == 'Q') {
    armAngles -= 2;
    //loop();
  }
  if (key == 'w' || key == 'W') {
    armAngles += 2;
    //loop();
  }
  if (key == 'e' || key == 'E') {
    if (cranePosition > -195)
      cranePosition -= 5;
    //loop();
  }
  if (key == 'r' || key == 'R') {
    if (cranePosition < 195)
      cranePosition += 5;
    //loop();
  }
  if (key == 'a' || key == 'A') {
    if (cableLength > 1){
      cableLength -= .5;
      //loop();
    }
  }
  if (key == 'z' || key == 'Z') {
    if (cableLength < 8){
      cableLength += .5;
      //loop();
    }
  }
  if (key == 's' || key == 'S') {
      clawRotation -= 5;{
      //loop();
    }
  }
  if (key == 'd' || key == 'D') {
      clawRotation += 5;{
      //loop();
    }
  }  
  if (key == 'x' || key == 'X') {
    if(openAngle <= 12){
      openClaw = true;
    }
  }
  if (key == 'c' || key == 'C') {
    if(openAngle >= 20){
       closeClaw = true;
    }
  }
}

void prizes(){
 pushMatrix();
 translate(width/2,height-(height/9),-100);
 drawShape(10); 
 popMatrix(); 

 pushMatrix();
 translate(width/2,height-(height/9));
 drawShape(15); 
 popMatrix(); 
 
 pushMatrix();
 translate(280,height-(height/9),-100);
 drawShape(7); 
 popMatrix(); 
 
 pushMatrix();
 translate(280,height-(height/9));
 drawShape(10); 
 popMatrix(); 
 
 pushMatrix();
 translate(400,height-(height/9),-50);
 drawShape(25); 
 popMatrix(); 
 
 pushMatrix();
 translate(200,height-(height/9),-100);
 drawShape(12); 
 popMatrix(); 
 
 pushMatrix();
 translate(200,height-(height/9),-200);
 drawShape(12); 
 popMatrix(); 
 
 pushMatrix();
 fill(255,0,255);
 translate(200,height-(height/9));
 box(50);
 popMatrix();
 
 pushMatrix();
 fill(255,0,0);
 translate(400,height-(height/9),-70);
 box(50);
 popMatrix();
 
 pushMatrix();
 fill(255,3,150);
 translate(200,height-(height/9),100);
 box(30,50,30);
 popMatrix();
 
 pushMatrix();
 fill(17,3,150);
 translate(300,height-(height/9),-120);
 box(40,30,40);
 popMatrix();
 
 pushMatrix();
 fill(17,255,5);
 translate(380,height-(height/9),-120);
 box(40,30,40);
 popMatrix();
 
 
 pushMatrix();
 fill(177,30,50);
 translate(280,height-(height/9),50);
 sphere(40);
 popMatrix();
 
}

void drawShape(float scale) {
  scale(scale);
  beginShape(QUADS);
  
  fill(255,0,0);
  vertex(1,1,3);
  vertex(1,3,3);
  vertex(3,3,3);
  vertex(3,1,3);

  fill(0,255,0);
  vertex(3,1,3);
  vertex(3,1,1);
  vertex(3,3,1);
  vertex(3,3,3);

  fill(0,0,255);
  vertex(3,1,1);
  vertex(1,1,1);
  vertex(1,3,1);
  vertex(3,3,1);

  fill(0,255,255);
  vertex(3,3,3);
  vertex(1,1,3);
  vertex(1,3,3);
  vertex(1,3,1);

  fill(255,0,255);
  vertex(1, 3,3);
  vertex(3,3,3);
  vertex(3,3,1);
  vertex(1,3,1);

  fill(255,255,0);
  vertex(3,1,3);
  vertex(1,1,3);
  vertex(1,1,1);
  vertex(3,1,1);
  endShape();
  
}
