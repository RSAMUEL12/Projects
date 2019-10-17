import java.util.Comparator;

class Company {
  String companyName;
  
  //Arraylists to store the ratings for each category
  ArrayList<Float> overallRating;
  ArrayList<Float> workBalance;
  ArrayList<Float> cultureValue;
  ArrayList<Float> careerOpp;
  ArrayList<Float> compBenefits;
  ArrayList<Float> seniorMan;
  
  //Hashmap to store the average values
  //The keys are the names of each category
  HashMap<String, Double> Averages = new HashMap<String, Double>();
  
  //Double variables to store the averages
  double averageOverall;
  double averageWorkBalance;
  double averageCultureVal;
  double averageCareerOpp;
  double averageCompBenefits;
  double averageSeniorMan;
  color colour;
  int noOfEmployees;

  //CONSTRUCTOR method
  Company(color colour, String name) {
    this.overallRating = new ArrayList<Float>();
    this.workBalance = new ArrayList<Float>();
    this.careerOpp = new ArrayList<Float>();
    this.cultureValue = new ArrayList<Float>();
    this.compBenefits = new ArrayList<Float>();
    this.seniorMan = new ArrayList<Float>();
    this.colour = colour;
    this.companyName = name;
    noOfEmployees = 0;
  }
  
  //returns the colour used to represent the company
  color getColour() {
    return colour;
  }
  
  //returns the values stored in hashmap 'averages'
  double getAverage(String key) {
    return Averages.get(key); 
  }
  
  //returns company name
  String getName() {
    return companyName;
  }
  
  //returns the no. of employees
  int getEmployees() {
    return noOfEmployees;
  }
  
  //Adding the values of ratings from .csv to arraylists
  void setOverallRating(float rating) {
    overallRating.add(rating);
  }
  void setWorkBalance(float rating) {
    workBalance.add(rating);
  }
  void setCultureValue(float rating) {
    cultureValue.add(rating);
  }
  void setCareerOpp(float rating) {
    careerOpp.add(rating);
  }
  void setCompBenefits(float rating) {
    compBenefits.add(rating);
  }
  void setSeniorMan(float rating) {
    seniorMan.add(rating);
  }

 //increments the no. of employees for each entry added
  void incrementSize() {
    noOfEmployees++;
  }
  
  //LIST OF MEAN FUNCTIONS FOR EACH CATEGORY OF RATINGS
  //each function calculates the value and stores it in the hashmap
  void findAverageOverall() {
    double sumOfRatings = 0;
    for (int i = 0; i < overallRating.size(); i++) {
        sumOfRatings += overallRating.get(i);
    }
   averageOverall = sumOfRatings / overallRating.size();
   Averages.put("Overall Rating", averageOverall);
  }
  
  void findAverageWorkBalance() {
    double sumOfRatings = 0;
    for (int i = 0; i < workBalance.size(); i++) {
        sumOfRatings += workBalance.get(i);
    }
   averageWorkBalance = sumOfRatings / workBalance.size();
 
   Averages.put("Work-Balance Rating", averageWorkBalance);
  }
  
  void findAverageCareerOpp() {
    double sumOfRatings = 0;
    for (int i = 0; i < careerOpp.size(); i++) {
        sumOfRatings += careerOpp.get(i);
    }
   averageCareerOpp = sumOfRatings / careerOpp.size();
   Averages.put("Career Opportunity Rating", averageCareerOpp);
  }
  
  void findAverageCultureValue() {
    double sumOfRatings = 0;
    for (int i = 0; i < cultureValue.size(); i++) {
        sumOfRatings += cultureValue.get(i);
    }
   averageCultureVal = sumOfRatings / cultureValue.size();
   Averages.put("Culture Value Rating", averageCultureVal);
  }
  
  void findAverageCompBenefits() {
    double sumOfRatings = 0;
    for (int i = 0; i < compBenefits.size(); i++) {
        sumOfRatings += compBenefits.get(i);
    }
   averageCompBenefits = sumOfRatings / compBenefits.size();
   Averages.put("Compensation-Benefits Rating", averageCompBenefits);
  }
  
  void findAverageSeniorMan() {
    double sumOfRatings = 0;
    for (int i = 0; i < seniorMan.size(); i++) {
        sumOfRatings += seniorMan.get(i);
    }
   averageSeniorMan = sumOfRatings / seniorMan.size();
   Averages.put("Senior Management Rating", averageSeniorMan);
  }
  
}
