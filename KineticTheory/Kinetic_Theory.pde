//NOTE: This visualisation uses the ControlP5 library, which needs to be placed
//in the libraries folder in the processing sketchbook
import controlP5.*;
ControlP5 cp5;

Textlabel pressureInfo, pressureValue, volumeInfo, volumeValue;

Molecule_System m;
Container c;

//Variables for holding the user selected value from CP5 GUI
double Mass;
double Temperature;
int l;
int w;
int h;

//Variable to store the initial position of the camera before it is moved by the user
float cameraX;
//defult zoom value for the camera() function in draw()
int zoom = 6;

//variables to hold output data for the user
int Pressure;

int noOfMolecules;


void setup() {
  size(1920,1080, P3D);
  cameraX = width/2;
  frameRate(60);

  //CP5 CONTROLS
  cp5 = new ControlP5(this);
  
  //A group class in CP5 to group all the sliders together in one location
  Group g1 = cp5.addGroup("g1")
                .setPosition(150,350)
                .setBackgroundHeight(100)
                .setBackgroundColor(color(125,50))
                .setSize(380, 320)
                .setLabel("Control Panel")
                .setBarHeight(35)
                .setFont(createFont("Dubai Regular", 20))
                ;
                
  //Second group to store all the outputs of Pressure and Volume in one place on the display
  Group g2 = cp5.addGroup("g2")
                .setPosition(1370,450)
                .setBackgroundHeight(100)
                .setBackgroundColor(color(125,50))
                .setSize(380, 150)
                .setLabel("Outputs")
                .setBarHeight(35)
                .setFont(createFont("Dubai Regular", 20))
                ;

  //Text labels to create a label for the value and the value itself
  pressureInfo = cp5.addTextlabel("pressureInfo")
                  .setPosition(0, 5)
                  .setFont(createFont("Dubai Regular", 20))
                  .setColorValue(color(0))
                  .setText("Pressure Exerted: ")
                  .setGroup(g2)
  ;
  
  pressureValue = cp5.addTextlabel("pressureValue")
                  .setPosition(200, 5)
                  .setColor(color(0))
                  .setFont(createFont("Dubai Bold", 20))
                  .setGroup(g2)
  ;
  
  //Text labels to create info for volume and its actual value
  volumeInfo = cp5.addTextlabel("volumeInfo")
                  .setPosition(0, 30)
                  .setFont(createFont("Dubai Regular", 20))
                  .setText("Volume of Container: ")
                  .setColor(color(0))
                  .setGroup(g2)
  ;
  
  volumeValue = cp5.addTextlabel("volumeValue")
                  .setPosition(200, 30)
                  .setFont(createFont("Dubai Bold", 20))
                  .setGroup(g2)
                  .setColor(color(0))
                  .setColorForeground(color(129));
  
  
  //CP5 Sliders for User Interactivity
  //Slider to change the temperature
  cp5.addSlider("Temperature")
    .setFont(createFont("Dubai Regular", 12))
    .setPosition(25, 10)
    .setRange(1,500)
    .setSize(200,40)
    .setColorCaptionLabel(0)
    .setValue(100)
    .setGroup(g1);
    ;
    
  //Slider to change the mass of a molecule
  cp5.addSlider("Mass")
    .setFont(createFont("Dubai Regular", 12))
    .setPosition(25, 60)
    .setRange(100,10000)
    .setSize(200,40)
    .setColorCaptionLabel(0)
    .setValue(4000)
    .setGroup(g1);
    ;
  
  //Slider to change the number of molecules present
  cp5.addSlider("noOfMolecules")
    .setFont(createFont("Dubai Regular", 12))
    .setPosition(25, 110)
    .setRange(1,50)
    .setSize(200,40)
    .setColorCaptionLabel(0)
    .setValue(10)
    .setGroup(g1);
    ;
  
  //Slider to change the number of molecules present
  cp5.addSlider("l")
    .setFont(createFont("Dubai Regular", 12))
    .setLabel("Length")
    .setPosition(25, 160)
    .setRange(200,1000)
    .setSize(200,40)
    .setColorCaptionLabel(0)
    .setValue(700)
    .setGroup(g1);
    ;
  
  //Slider to change the number of molecules present
  cp5.addSlider("w")
    .setFont(createFont("Dubai Regular", 12))
    .setLabel("Width")
    .setPosition(25, 210)
    .setRange(200,1000)
    .setSize(200,40)
    .setColorCaptionLabel(0)
    .setValue(700)
    .setGroup(g1);
    ;
  
  //Slider to change the number of molecules present
  cp5.addSlider("h")
    .setFont(createFont("Dubai Regular", 12))
    .setLabel("Height")
    .setPosition(25, 260)
    .setRange(200,1000)
    .setSize(200,40)
    .setColorCaptionLabel(0)
    .setValue(700)
    .setGroup(g1);
    ;
  
  //Creating a caption for each of the sliders above
  cp5.getController("Temperature").setCaptionLabel("Temperature");
  cp5.getController("Mass").setCaptionLabel("Mass");
  cp5.getController("noOfMolecules").setCaptionLabel("No. of Molecules");

  //Constructing a container object to hold the molecule system
  c = new Container(700);
  //stores all the sizes for each side of the container to redraw the container
  //if the value changes
  l = c.l;
  w = c.w;
  h = c.h;
  
  //Constructing the molecule system within the container - 
  //container boundaries are accessed by the molecule system class for scalability
  m = new Molecule_System(noOfMolecules, Mass);
}

//Function to change the zoom value in order to be able to zoom in
//to the container if the mouse is scrolled up or down
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e == 1) { //If scrolled down, zoom increments and the camera moves back
    if (zoom < 10) {
       zoom++; 
    }
  }
  else {//If scrolled up, zoom decrements and the camera moves forward
    if (zoom > 3) {
       zoom--; 
    }
  }
}

void draw() {
  background(255);
  mouseWheel();
  //creating a camera to pan around the container
  if (mousePressed == true) {
    camera(mouseX, height/2, (height/2) / tan(PI/zoom), width/2, height/2, -width/2, 0, 1, 0);
    cameraX = mouseX;
  }
  else {
    camera(cameraX, height/2, (height/2) / tan(PI/zoom), width/2, height/2, -width/2, 0, 1, 0);
  }
  
  lights();
  //drawing the container space to outline the boundaries of the molecules
  c.display();
  //Functions to change the sizes of each side is the slider is changed in the
  //CP5 GUI
  c.changeLength(l);
  c.changeWidth(w);
  c.changeHeight(h);
  
  //functions which allow for new values from the sliders to be fed as a new input 
  //to the molecule system to adjust velocity and pressure
  m.changeMass(Mass);
  m.changeTemperature(Temperature);
  m.changeNoOfMolecules(noOfMolecules);
  m.display();
  
 
   //2D elements in a 3D Visualisation
   //source: https://forum.processing.org/two/discussion/3393/2d-hud-in-3d-game
  camera();
  pressureValue.setText(Float.toString(m.calcPressure()) + "Pa");
  volumeValue.setText(Float.toString(c.volume) + "m^2");
  hint(DISABLE_DEPTH_TEST);
  
}

//CP5 methods to assign the new slider value to the corresponding variable
void Temperature(float newTemp) {
  Temperature = (double) newTemp;
}

void Mass(float newMass) {
  Mass = (double) newMass;
}

void noOfMolecules(int newNo) {
  noOfMolecules = newNo;
}

void l(int newL) { //reassigns length
  l = newL;
}

void w(int newW) {//reassigns width
  w = newW;
}

void h(int newH) {//reassigns height
  h = newH;
}
