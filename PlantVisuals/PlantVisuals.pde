import processing.serial.*;

TriangleGrid tr;
Serial myPort;

void setup() {
   tr = new TriangleGrid(80);
    
   colorMode(HSB, 100, 100, 100);
   //size(1080,720);
   fullScreen(2);
   frameRate(30);
   
   myPort = new Serial(this, Serial.list()[0], 115200);
   myPort.bufferUntil(10);
}

void draw() {
  background(100);
  tr.drawGrid();
}

void serialEvent(Serial p) { 
  String serialOut = p.readString();
  if(serialOut.contains("p2:0")) {
    tr.color1On = false;
  };
  if(serialOut.contains("p2:1")) {
    tr.color1On = true;
  };
  if(serialOut.contains("c16:0")) {
    tr.color2On = false;
  };
  if(serialOut.contains("c16:1")) {
    tr.color2On = true;
  };
} 

void keyPressed() {
  
  if (key == 'a') {
    tr.color1On = !tr.color1On;
  }
  
  if (key == 'b') {
    tr.color2On = !tr.color2On;
  }
}
