final int displayWidth = 1500;
final int displayHeight = 800;

void setup()
{
  size(displayWidth, displayHeight);
  background(0,0,255);
  
  strokeWeight(4);
  fill(0, 0, 200);
  rect(0, 0, displayWidth, displayHeight);
  line(500, 0, 500, displayHeight);
  line(1000, 0, 1000, displayHeight);
  line(0, 200, displayWidth, 200);
  line(0, 400, displayWidth, 400);
  line(0, 600, displayWidth, 600); 
  
  // First Row of Slots
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Topic 1", 250, 100);
  text("Topic 2", 750, 100);
  text("Topic 2", 1250, 100);
  

  // Second Row of Slots
  text("Q 1", 250, 300);
  text("Q 2", 750, 300);
  text("Q 3", 1250, 300);
  
  // Third Row of Slots
  text("Q 4", 250, 500);
  text("Q 5", 750, 500);
  text("Q 6", 1250, 500);
  
  // Fourth Row of Slots
  text("Q 7", 250, 700);
  text("Q 8", 750, 700);
  text("Q 9", 1250, 700);
}

void draw()
{
  if( (mouseX < 500) && (mouseY < 400) && (mouseY > 200))
  {
    if (mousePressed == true)
    {
      background(0, 0, 200);
      String time = "010";
      int t;
      int interval = 10;
      t = interval - int(millis() / 1000);
      time = nf(t, 3);
      while(time != "0")
      {
        text(time, width/2, height/2);
      }
    }
  }
}