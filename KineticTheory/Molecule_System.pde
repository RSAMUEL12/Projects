class Molecule_System {
  
  //arraylist to store all the molecules
  ArrayList<Molecule> molecules;
  
  //variables of double or float to hold the accurate values of temperature, pressure, force and velocity
  //The variables are used so that pressure can be calculated from the previously found velocity
  //and force values
  double mass;
  double temperature;
  float averageVSquared;
  float averageForce;
  float pressure;
  
  //variable to hold the no. of molecules present in the container
  int noOfMolecules;
  
  //CONSTRUCTOR METHOD
  Molecule_System(int noOfMolecules, double mass) {
    molecules = new ArrayList<Molecule>();
    this.noOfMolecules = noOfMolecules;
    initialise(mass);
  }
  
  //once constructed, the arraylist needs to be filled
  void initialise(double mass) {
    for (int i = 0; i < noOfMolecules; i++) {
      molecules.add(new Molecule(mass)); 
    }
  }
  
  //Changes the mass for every molecule present
  void changeMass(double mass) {
    this.mass = mass;
  }
  
  //Changes the temperature of the molecule system
  void changeTemperature(double temp) {
    this.temperature = temp;
  }
  
  //Changes the number of molecules present in the system
  void changeNoOfMolecules(int newNo) {
    //If more molecules are added
    if (newNo > noOfMolecules) {
      //checks if new number is greater than the size, if so, more molecules are added until the right size
      if (newNo > molecules.size()) {
         for (int i = molecules.size(); i < newNo; i++) {
           molecules.add(new Molecule(mass)); 
         }
      }
      else {
        noOfMolecules = newNo; 
      }
    }
    //If molecules are removed
    else {
      noOfMolecules = newNo;
    }
  }

  
  //Calculates an average veleocity squared value for pressure
  void calcAverageVelocity() {
    float totalVelocitySquared = 0;
    for (Molecule m: molecules) {
      totalVelocitySquared += m.velocity.mag() * m.velocity.mag();
    }
    averageVSquared = totalVelocitySquared / noOfMolecules;
  }
  
  //Calculates the average force each molecule applies
  void calcAverageForce() {
    averageForce = (float) (mass * noOfMolecules * averageVSquared) / c.l; 
  }
  
  //Calculates an average pressure exerted by each molecule using the average force and velocity squared
  float calcPressure() {
    calcAverageVelocity();
    calcAverageForce();
    pressure = averageForce / (c.w * c.h);
    return pressure;
  }
  
  //Accesses each individual molecule to display, check boundaries, apply new masses and temperature values etc.
  void display() {
    for (int i = 0; i < noOfMolecules; i++) {
      molecules.get(i).display();
      molecules.get(i).applyMass(mass);
      molecules.get(i).applyTemperature(temperature);
      //checkCollision();
      molecules.get(i).checkBoundary();
      //if any molecules are out of the boundary, then a new molecule is created to replace it
      //Molecules are replaced when the container sides are changed
      if (molecules.get(i).checkBeyond() == true) {
        molecules.set(i, new Molecule(mass));
      }
      molecules.get(i).update();
    }
  }
}
