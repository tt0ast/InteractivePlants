class TriangleGrid {
  
  color[][] triArray;
  int numRows;
  int numCols;
  float triSizeX;
  float triSizeY;
  boolean color1On;
  boolean color2On;
  
  TriangleGrid(int columns) {
    
    numCols = columns * 2;
    triSizeX = width / (numCols / 2.0);
    numCols++; // because we have a empty col a the beginning, we need to draw one extra col
    triSizeY = (sqrt(3) / 2) * triSizeX;
    numRows = ceil(height / triSizeY);
    
    triArray = new color[numCols][numRows];
    for (int x = 0; x < numCols; x++){
      for (int y = 0; y < numRows; y++){
        triArray[x][y] = color(100,100,100);
      } 
    }
    
    strokeWeight(2.0);
    color1On = false;
    color2On = false; 
  }
  
  void drawGrid() {
    
    float scaleFacP = 1.0;
    float scaleFacM = 1 - (scaleFacP - 1);
    float triSizeXHalf = (triSizeX / 2);
    
    color[][] nextTriArray = new color[numCols][numRows];
    
    if (color1On) {
      addColorBlob(2, 10, 40, 70);
    }
    if (color2On) {
      addColorBlob(2, 10, 70, 100);
    }
    
    pushMatrix();
    translate(-triSizeXHalf, 0);
    
    for (int y = 0; y < numRows; y++) {
      for (int x = 0 ; x < numCols; x++) {
        float alpha = (noise(x / 25.0, y / 12.5, millis() / 7500.0) * 70) + 30; 
        nextTriArray[x][y] = getHoodColor(x,y);     
        color newColor = color(hue(nextTriArray[x][y]), saturation(nextTriArray[x][y]), alpha);
    
        stroke(newColor);
        fill(newColor);

            if (x % 2 == y % 2) {
              triangle(x * triSizeXHalf, y * triSizeY,
                       (x + 1) * triSizeXHalf, (y + 1) * triSizeY,
                       (x + 2) * triSizeXHalf, y * triSizeY);
            }
            else {
              triangle(x * triSizeXHalf * scaleFacM, (y + 1) * triSizeY,
                       (x + 1) * triSizeXHalf, y * triSizeY,
                       (x + 2)*  triSizeXHalf, (y + 1) * triSizeY); 
            }
        } 
     }
     
     popMatrix();
     
     triArray = nextTriArray;
     
   }
   
   void addColorBlob(int minBlobSize, int maxBlobSize, int hueLow, int hueHigh) {
     
     color blobColor = color(random(hueLow, hueHigh),random(hueLow, hueHigh),100);
     int blobSizeX = int(random(minBlobSize, maxBlobSize * 1.5));
     int blobSizeY = int(random(minBlobSize, maxBlobSize));
     
     int xOffset = int(random(0, numCols - blobSizeX));
     int yOffset = int(random(0, numRows - blobSizeY));
     
     for (int x = 0; x < blobSizeX; x++) {
       for (int y = 0; y < blobSizeY; y++) {
         triArray[x + xOffset][y + yOffset] = blobColor;
       }     
     }
   }
   
   color getHoodColor(int x, int y) {
     
     color color1 = triArray[mod(x - 1, numCols)][y];
     color color2 = triArray[mod(x + 1, numCols)][y];
     color color3 = triArray[x][mod(y - 1, numRows)];
     color color4 = triArray[x][mod(y + 1, numRows)];
     
     float hue = (hue(color1) + hue(color2) + hue(color3) + hue(color4)) / 4;
     float saturation = (saturation(color1) + saturation(color2) + saturation(color3) + saturation(color4)) / 4;
       
     return color(hue, saturation, 100);
   }
   
   // java mod returns < 0 values for < 0 inputs, this is a fix for that
   int mod(int a, int b) {
     int remainder = a % b;
     if (remainder < 0) {
        remainder += b;
     }
     return remainder;
   }

}
