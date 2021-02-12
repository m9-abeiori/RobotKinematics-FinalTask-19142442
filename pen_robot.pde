float distance = 150;
float camAngle1 = 0;
float camAngle2 = 30;
float l1 = 30;
float l2 = 70;
float l3 = 80;
float l4 = 20;
float armW = 10;
float penW = 1;
float jointR =9;


void setup(){
  
  size(1200, 800, P3D);
  
}

void draw(){
  
  background(200);
  
  float alpha1 = radians(camAngle1);
  float alpha2 = radians(camAngle2);
  int i;
  if(-90 < camAngle2 && camAngle2 < 90){
    i = -1;
  }
  else{
    i = 1;
  }
  camera((l2 + l3)/2 + distance*cos(alpha2)*sin(alpha1), (l1 + l2)/2 + distance*sin(alpha2), -distance*cos(alpha2)*cos(alpha1), (l2 + l3)/2, (l1 + l2)/2, 0, 0, i, 0);
  if(keyPressed){
    if(key == 'w'){
      camAngle2++;
    }
    if(key == 's'){
      camAngle2--;
    }
    if(key == 'd'){
      camAngle1++;
    }
    if(key == 'a'){
      camAngle1--;
    }
  }
  if(camAngle2 < -270){
    camAngle2 = camAngle2 + 360;
  }
  if(270 < camAngle2){
    camAngle2 = camAngle2 - 360;
  }
  
  float mX = (mouseX - 600)/10  + (l2 + l3)/2;
  float mY = (-mouseY + 400)/10 ;
  
  float H = 0;
    if (mousePressed == true){
      H = 0;
    }
    else{ 
      H = 3;
    }
  
  float C3 = (sq(mX) + sq(mY) + sq(H - l1 + l4) - sq(l2) - sq(l3))/(2*l2*l3);
  float S3 = sqrt(1 - sq(C3));
  
  float A = sqrt(sq(mX) + sq(mY));
  float B = H - l1 + l4;
  float M = l2 + l3*C3;
  float N = l3*S3;
  
  float angle1 = atan2(mY, mX);
  float angle2 = atan2(M*A - N*B, N*A + M*B);
  float angle3 = atan2(S3, C3);
  float angle4 = radians(180) - angle2 - angle3;
  
  pushMatrix();
  
  //arm1
  rotateY(-angle1);
  translate(0, l1/2 + armW/4, 0);
  fill(255);
  box(armW, l1 + armW/2, armW);
  
  //joint1
  translate(0, l1/2 - armW/4, armW);
  
  //arm2
  rotateZ(-angle2);
  translate(0, l2/2, 0);
  fill(255);
  box(armW, l2 + armW, armW);
  
  //joint2
  translate(0, l2/2, -armW);
  
  //arm3
  rotateZ(-angle3);
  translate(0, l3/2, 0);
  fill(255);
  box(armW, l3 + armW, armW);
  
  //joint3
  translate(0, l3/2, 0);
  fill(255);
  sphere(jointR);
  
  //pen
  rotateZ(-angle4);
  translate(0, l4/2, 0);
  fill(255);
  box(penW, l4, penW);
  
  popMatrix();
  
  //ink
  if(mousePressed == true){
    rotateX(radians(90));
    fill(0);
    ellipse(mX, mY, 2, 2);
  }
  
  
  
  
  
  
}
