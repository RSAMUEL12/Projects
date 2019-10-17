import java.util.Collections;
import java.util.Comparator;
import java.util.Map;
import java.util.HashMap;
//MAIN PROGRAM FOR VISUALISATION  
// The program accesses a .csv file to create a table of data
// employee_reviews.csv is accessed
Table table;

PFont f; //normal font
PFont f2; //bold font

//Company objects instantiated with their accent colours and their names
Company Google = new Company(color(66,133,244), "google");
Company Amazon = new Company(color(255,153,0), "amazon");
Company Netflix = new Company(color(229,9,20), "netflix");
Company Facebook = new Company(color(60,90,153), "facebook");
Company Apple = new Company(color(125,125,125), "apple");
Company Microsoft = new Company(color(127,186,0), "microsoft");
Company[] Companies = new Company[]{Google, Amazon, Netflix, Facebook, Apple, Microsoft};
int size = 6; //size defined for easier reference in the code.

//PShape variable used to create the chart but using the GROUP option
PShape chart;


float borderWidth = 100;
float plotX = 1200;
float plotY = 800;
//the size of the chart will be x0.8
//the size of its container
float scale = 0.8;
//the scale to determine the width of the radial bars in relation
//to the container (0.1 times the size)
float barScale = 0.1;
float textScale = 0.03;

float chartX = 400;
float chartY = 400;


//Space between each rating is 54 degrees
float split = 54;
color buttonColour = color(255);



void setup() {
  size(1920, 1080);
  
  f = createFont("Arial",16); //standard text
  f2 = createFont("Arial Bold",16);//bold text
  
  //loads csv file
  table = loadTable("employee_reviews.csv", "header");
  
  //Accessing each of the table rows and storing the values by 
  //referencing the column names
  for (TableRow row : table.rows()) {
    
    //each row is defined
    String name = row.getString("company");
    
    //Strings that hold the values of each rating made by employees
    String overallRat = row.getString("overall-ratings");
    String workBalance = row.getString("work-balance-stars");
    String careerOp = row.getString("carrer-opportunities-stars");
    String cultureVal = row.getString("culture-values-stars");
    String compBenefit = row.getString("comp-benefit-stars");
    String seniorMan = row.getString("senior-mangemnet-stars");
    
    //adds the values to the Company Class by first matching the name of the company
    //currently accessed from the table with the name in the Companies array so
    //the information is stored in the correct location
    for (int i = 0; i < size; i = i+1) {
      if (name.equals(Companies[i].getName())) {
        //add overall rating to arraylist
        
        //Conditional Statements to filter out the value "none" to float arraylists
        
        //If the conditions are met, each of the ratings are stored in their arraylists
        //within the Company object
        if (!checkValue(overallRat)) {
          Companies[i].setOverallRating(Float.parseFloat(overallRat));
        }
        
        if (!checkValue(workBalance)) {
          Companies[i].setWorkBalance(Float.parseFloat(workBalance));
        }
        
        if (!checkValue(careerOp)) {
          Companies[i].setCareerOpp(Float.parseFloat(careerOp));
        }
        if (!checkValue(cultureVal)) {
          Companies[i].setCultureValue(Float.parseFloat(cultureVal));
        }
        if (!checkValue(compBenefit)) {
          Companies[i].setCompBenefits(Float.parseFloat(compBenefit));
        }
        if (!checkValue(seniorMan)) {
          Companies[i].setSeniorMan(Float.parseFloat(seniorMan));
        }
        
        //Increments the number of employees - if at least 1 rating is made by an employee
        //they will be counted in the size
        Companies[i].incrementSize();
        break;
      }
    }
    
  }//endFor
  
  //for each company, the average rating for every category is calculated
  for(int i = 0; i < size; i++) {
    Companies[i].findAverageWorkBalance();
    Companies[i].findAverageOverall(); //calculates overall ratings average from array list
    Companies[i].findAverageCareerOpp();
    Companies[i].findAverageCultureValue();
    Companies[i].findAverageCompBenefits();
    Companies[i].findAverageSeniorMan();
  }
  //constructs a new shape for the radial chart
  chart = createShape(GROUP);
}//end setup

//function to check that the value does not equal "none"
Boolean checkValue(String value) {
  if(("none").equals(value)) {
    return true;
  }
  return false;
}


//Takes a screenshot of the visualisation once the key 's' is pressed
void keyPressed() {
  if(key == 's') {
     println("Saving Photo");
     save("visualisation.png");
  }
}

void draw() {
  //background(#F4D03F);
  background(#F3C13A);
  
  textFont(f,16); 
  textAlign(RIGHT, CENTER);
  //pushes a translation into a stack
  pushMatrix();
  //changes the coordinate axis so that the plot area can be created in the centre
  translate(width/2, (height/2) + 25);
  drawPlotArea();
  //pops a translation made from the stack
  popMatrix();
  //functions to create the title, description and legend
  drawMainTitle();
  drawDescription();
  drawLegend();
  
  
  //CREATING THE RADIAL BAR CHARTS in their respective locations
  //each coordinate system is reset everytime a new chart is made
  //the translate function allows for the coordinates specified to become the origin
  //which allows for the radial chart to be made from the origin.
  pushMatrix();
  translate(560, 365);
  //drawPlotArea();
  //drawMainTitle();
  //workBalanceButton();
  //mousePressed();
  drawRadialChart("Overall Rating");
  popMatrix();
  
  pushMatrix();
  translate(960, 365);
  drawRadialChart("Culture Value Rating");
  popMatrix();
  
  pushMatrix();
  translate(1360, 365);
  drawRadialChart("Compensation-Benefits Rating");
  popMatrix();
  
  pushMatrix();
  translate(560, 765);
  drawRadialChart("Work-Balance Rating");
  popMatrix();
  
  pushMatrix();
  translate(960, 765);
  drawRadialChart("Career Opportunity Rating");
  popMatrix();
  
  pushMatrix();
  translate(1360, 765);
  drawRadialChart("Senior Management Rating");
  popMatrix();
  
  noLoop();

}

//For each category specified, a chart is made
void drawRadialChart(String category) {
  float diameter = chartX * scale;
  float reduction = chartX * barScale; //the amount the diameter decreases by according to the scaler barScale
  HashMap<String, Double> averages = new HashMap<String,Double>();
  
  //stores each companies average in the hashmap along with their name as id
  for (int i = 0; i < size; i++) {
    averages.put(Companies[i].getName(), Companies[i].getAverage(category));
  }

  //Might need to remove the comparator as the hashmap sorts by key everytime
  //a new entry is added
  
  //new arraylist to store the entries in the hashmap for sorting
  //https://www.geeksforgeeks.org/sorting-a-hashmap-according-to-values/ << where the sorting code was borrowed from
  //Collections.sort() will then sort the list according to the values
  ArrayList<Map.Entry<String, Double>> sortedList = new ArrayList<Map.Entry<String, Double>>(averages.entrySet());
  Collections.sort(sortedList, new Comparator<Map.Entry<String, Double>>() {
    //used to compare the values of two entries with each other
    @Override
    public int compare(Map.Entry<String, Double> entry1, Map.Entry<String, Double> entry2) {
      return entry2.getValue().compareTo(entry1.getValue());
    }
  });
  
  //Adds the sorted entries into a separate arraylists
  //Arraylists instead of hashmaps because the keys will be ordered in ascending order
  ArrayList<Double>mapValues = new ArrayList<Double>();
  ArrayList<String>mapKeys = new ArrayList<String>();

  for (Map.Entry<String, Double> e : sortedList) {
    mapValues.add(e.getValue());
    mapKeys.add(e.getKey());
  }
  
  
  //GENERATES OVERALL RATING RADIAL CHART
  //Each Company has a radial chart made
  for (int i = 0; i < mapValues.size(); i++) {
    color colour = color(255);
    for (int j = 0; j < size; j++) {
      if (mapKeys.get(i).equals(Companies[j].getName())) {
        colour = Companies[j].getColour();
      }
    }
    drawRadial(diameter, mapValues.get(i), colour);
    diameter-=reduction;
  }
  
  //axis drawn after chart so that the lines from the other charts are not covered
  drawAxis(chartX, chartY, category);
  drawCentre(diameter);//draws the centre ellipse for the gap in the middle - aesthetic
  drawCompanyNames(chartX, mapKeys);//draws the company names alongside the bars
}

//function which creates a white ellipse in the centre of the bar chart
void drawCentre(float diameter) {
  fill(255);
  noStroke();
  PShape centre = createShape(ELLIPSE, 0, 0, diameter, diameter);
  shape(centre);
}

//draws the radial bar chart using the radial bar function for each company
void drawRadial(float diameter, double average, color colour) {
  pushMatrix();
  rotate((3*PI)/2);
  //scales the chart x0.8 the size of the container
  //draws radial bar charts for each company

  radialBar(diameter, (split * (float)average), 0, 0, colour);

  shape(chart); //displays the radial bar chart
  popMatrix();

}

//creates a pie chart which will be layered on top of each other
//to create a radial bar chart
void radialBar(float diameter, float angle, float x, float y, color colour) {
  stroke(255);
  strokeWeight(plotX * 0.005);
  fill(colour);
  //each of the arcs are added to the PShape chart variable
  PShape arc1 = createShape(ARC, x, y, diameter, diameter, 0, radians(angle));
  arc1.setStroke(255);
  chart.addChild(arc1);
  fill(255);
  PShape arc2 = createShape(ARC, x, y, diameter, diameter, radians(angle), radians(360));
  chart.addChild(arc2);
}

//Draws axis of radial bar chart using arc functions
void drawAxis(float containerX, float containerY, String title) {
  stroke(0);
  strokeWeight(3);
  float r = (containerX * scale) / 2;
  float theta = radians(270);
  
  for(int i = 0; i <= 5; i++) {
    //x = r*cos(theta), y = r*sin(theta) - polar coordinates
    float x = r * cos(theta + radians(split * i));
    float y = r * sin(theta + radians(split * i));
    
    //creates coordinates for the numbers on the axis, the length is longer for more space for readability
    float x_text = (r + 15) * cos(theta + radians(split * i)); //Coordinates for the text values on axis
    float y_text = (r + 15) * sin(theta + radians(split * i));
    line(0, 0, x, y);
    textFont(f2);
    textSize(containerX * textScale);
    textAlign(CENTER, CENTER);
    fill(0);
    //the text values are the numbers 1 to 5, which are converted to string so they are outputted
    text(Integer.toString(i), x_text, y_text);
  }
  
  noFill();
  float diameter = containerX * scale;
  float reduction = containerX * barScale;
  int counter = 0;
  while (counter <= size) {
    noFill();
    stroke(0);
    strokeWeight(2);
    //arcs used to create the radial curves of the bar chart axis by using the diameter defined
    arc(0, 0, diameter, diameter, radians(270), radians(540));
    diameter -= reduction;
    counter++;
  }
  
  textFont(f2);
  text(title, 0, -(containerY / 2.1)); //adds the title of the type of rating focused on
}

//Text for each company written alongside the corresponding radial bars
void drawCompanyNames(float containerX, ArrayList<String> names) {
  
  textSize(containerX * textScale);
    
  float radius = -(containerX) * 0.375;
  for (int i = 0; i < names.size(); i++) {
    String name = names.get(i).substring(0, 1).toUpperCase() + names.get(i).substring(1);
    fill(0);
    if (i == 0) {
      textFont(f2);
    } else {
      textFont(f);
    }
    textAlign(RIGHT, CENTER);
    text(name, -8, radius);
    radius+= containerX * (barScale/2);
  }
}

//Creates area where visualisation is produced
void drawPlotArea() {
   fill(255);
   stroke(0);
   strokeWeight(2);
   rectMode(CENTER);
   rect(0, 0, 1200, 800, 30);
}

//Draws title of the visualisation
void drawMainTitle() {
   fill(255);
   textAlign(CENTER, BOTTOM);
   textFont(f2);
   textSize(35);
   text("Employee Ratings of Technology Companies for different categories", width/2, 37);
}

//writes a description below the main title and above the plot area
void drawDescription() {
   fill(255);
   textFont(f);
   textSize(18);
   text("The visualisation is a display of employee ratings (from 0 to 5) for 6 technology companies. The values of each rating are collected and an average rating is produced and displayed on a series of radial bar charts.", width/2, 70);
   text("The diagrams below show the average ratings for each of the following categories: Work-Balance Rating, Culture Value Rating, Compensation and Benefits Rating, Career Opportunity Rating and Senior Management Rating.", width/2, 85);
   text("The radial bars for each company are sorted from the highest rating on the outside, to the lowest rating on the inside of the radial bar chart.", width/2, 110);
   text("The companies themselves are identified using their own colour fill as well as text to identify them on the radial bar chart.", width/2, 125);
}

void drawLegend() {
  fill(255);
  stroke(0);
  strokeWeight(2);
  rectMode(CENTER);
  rect(200, (height/4) + 50, 200, 310, 30);
  
  float y = 200;

  //adds the company names and their colour next to the name
  //for loop to add the names below each other on the legend
  for (int i = 0; i < size; i++) {
    fill(0);
    textAlign(CENTER, CENTER);
    text(Companies[i].getName().substring(0, 1).toUpperCase() + Companies[i].getName().substring(1) , 180, y);
    fill(Companies[i].getColour());
    ellipse(250, y, 30, 30);
    y+=45;
  }
}
