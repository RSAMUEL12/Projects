class Container {
  
  //variables to store the sizes of each side
  int l;
  int w;
  int h;
  
  //stores the volume of the container
  float volume;
  
  //Min/Max values to indicate the boundaries of the container
  float minX;
  float maxX;
  
  float minY;
  float maxY;
  
  float minZ;
  float maxZ;
  
  //Location of the box container
  float x, y, z;

  //DEFAULT CONSTRUCTOR IF NO LENGTHS ARE SPECIFIED
  Container() {
    this.l = width;
    this.w = height;
    this.h = height;
    
    this.x = width/2;
    this.y = height/2;
    this.z = -height/2;
    calcMinAndMax();
  }
  
  //CONSTRUCTOR FOR A CONTAINER WITH EQUAL LENGTHS
  Container(int l) {
    this.l = l;
    this.w = l;
    this.h = l;
    
    this.x = width/2;
    this.y = height/2;
    this.z = -height/2;
    calcMinAndMax();
  }
  
  //CONSTRUCTOR METHOD FOR DIFFERENT LENGTHS
  Container(int l, int w, int h) {
    this.l = l;
    this.w = w;
    this.h = h;
    
    this.x = width/2;
    this.y = height/2;
    this.z = -height/2;
    calcMinAndMax();
  }
  
  //Calculates the minimum and maximum values of the container by using
  //the x,y,z coordinates it is placed at and the sizes of the lengths
  void calcMinAndMax() {
    minX = x - w/2;
    maxX = x + w/2;
    
    minY = y - h/2;
    maxY = y + h/2;
    
    maxZ = z - l/2;
    minZ = z + l/2;
    calcVolume();
    
  }
  
  //function to calculate the volume of the container
  void calcVolume() {
    volume = l * w * h; 
  }
  
  //If a new length is present, l is reassigned and new min/max values calculated
  //to keep the molecules within the boundaries
  //This is repeated for width, and height.
  void changeLength(int newLength) {
    this.l = newLength;
    calcMinAndMax();
  }
  
  void changeWidth(int newWidth) {
    this.w = newWidth;
    calcMinAndMax();
  }
  
  void changeHeight(int newHeight) {
    this.h = newHeight;
    calcMinAndMax();
  }
  
  //function to display the 3D Container
  void display() {
    pushMatrix();
    translate(x, y, z);
    stroke(0);
    noFill();
    box(w, h, -l);
    popMatrix();
  }
  
}
