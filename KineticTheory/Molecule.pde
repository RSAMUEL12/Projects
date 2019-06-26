class Molecule {
  
  PVector location, velocity; //Vectors to hold Molecule location and mass
  double molarMass; //Mass of Molecule
  double k = 1.38 * Math.pow(10, -23); //Boltzmann's Constant
  
  float radius = 20; //radius of each molecule

  //CONSTRUCTOR METHOD
  Molecule(double mass) {
    //global min and max values of container obtained to limit spawn area of molecules
    this.location = new PVector(random(c.minX + radius, c.maxX - radius), random(c.minY + radius, c.maxY - radius), random(c.minZ - radius, c.maxZ + radius));
    this.velocity = new PVector(random(-1,1), random(-1,1), random(-1,1));
    //this.velocity.normalize();
    this.molarMass = mass * Math.pow(10, -26);
  }
  
  //Update function to add the velocity to molecule to keep it moving
  void update() {
    location.add(velocity);
  }
 
  
  //Function for applying a temperature, which changes the speed of each molecule
  void applyTemperature(double temp) {
    double KE = 3/2 * k * temp;
    double velocity2 = (2 * KE) / molarMass;
    float newvelocity = (float) Math.pow(velocity2, 0.5);
    //println(newvelocity);
    this.velocity.setMag(newvelocity);
  }
  
  //Function to apply a new mass if the user passes a new one
  void applyMass(double newMass) {
    this.molarMass = newMass * Math.pow(10, -26);
  }
  
  //Function to check if the molecule moves out of the container space
  void checkBoundary() {
  // Test to see if the shape exceeds the boundaries of the screen
  // If it does, reverse its direction by multiplying by -1
    if (location.x >= c.maxX - radius || location.x <= c.minX + radius) {
      velocity.x *= -1;
    }
    if (location.y >= c.maxY - radius || location.y <= c.minY + radius) {
      velocity.y *= -1;
    }
    if (location.z <= c.maxZ + radius || location.z >= c.minZ - radius) {
      velocity.z *= -1;
    }
  }
  
  //Function to check if a molecule is outside the boundaries of the container, if 
  //so, false is returned
  boolean checkBeyond() {
    if (location.x >= c.maxX || location.x <= c.minX) {
      
      return true;
    }
    if (location.y >= c.maxY || location.y <= c.minY) {
      return true;
    }
    if (location.z <= c.maxZ || location.z >= c.minZ) {
      return true;
    }
    return false;
  }
  
  //Function to display the molecule as a sphere in 3D plane
  void display() {
    fill(125);
    noStroke();
    pushMatrix();
    translate(location.x, location.y, location.z);
    sphere(radius);
    popMatrix();
  }
  
}
