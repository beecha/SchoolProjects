/*
 * rotations
 */

// Orientation of the object (yaw = heading)
float yaw1 = radians(45), pitch1 = radians(30), roll1 = radians(60);
//float yaw2 = radians(0),  pitch2 = radians(0),  roll2 = radians(0);
float yaw2 = radians(45+180),  pitch2 = radians(60),  roll2 = radians(60);
float yaw, pitch, roll;

// Camera rotation
float cameraHeading = radians(30), cameraPitch = -radians(30);

void setup() {
  size(512,512,P3D);
  background(64);
}

boolean animating = false;
int start_time;

void draw() {
  background(64);
  
  
  beginCamera();
    camera(0,0,-200,
           0,0,0,
           0,1,0);
    perspective(radians(60), width/height, 0.01, 10000);
    
    rotateX(-cameraPitch);
    rotateY(-cameraHeading);
  endCamera();
  
  lights();
  
  // X axis
  stroke(#ff0000);
  line(-1000,0,0,
        1000,0,0);
       
  // Y axis
  stroke(#00ff00);
  line(0,-1000,0,
       0, 1000,0);
       
  // Z axis
  stroke(#0000ff);
  line(0,0,-1000,
       0,0, 1000);
  
  // Draw the lines showing the to/from rotations
  pushMatrix();
  rotateY(yaw1);
  rotateX(pitch1);
  rotateZ(roll1);
  stroke(0);
  strokeWeight(3);
  fill(0);
  line(0,0,0,0,0,100);
  translate(0,0,100);
  sphere(2);
  popMatrix();
  
  pushMatrix();
  rotateY(yaw2);
  rotateX(pitch2);
  rotateZ(roll2);
  stroke(255);
  strokeWeight(3);
  fill(255);
  line(0,0,0,0,0,100);
  translate(0,0,100);
  sphere(2);
  popMatrix();
  strokeWeight(1);
    
  // Animate object rotation
  final float DURATION = 1000.0; // ms
  float t = animating ? min((millis() - start_time) / DURATION, 1.0) : 0;
  yaw = lerp(yaw1,yaw2,t);
  pitch = lerp(pitch1,pitch2,t);
  roll = lerp(roll1,roll2,t);
    
  // Draw the object in its current rotation.
  stroke(0);
  fill(192);
  rotateY(yaw);
  rotateX(pitch);
  rotateZ(roll);
  box(24,24,32);
  translate(0,0,24);
  box(10,10,16);
}

void mouseDragged() {
  cameraHeading -= radians(mouseX - pmouseX);
  
  cameraPitch -= radians(mouseY - pmouseY);
  cameraPitch = constrain(cameraPitch, -PI/2, PI/2);
}
        
void keyPressed() {
  animating = true;
  start_time = millis();
}
  
  
  