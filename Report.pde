//class for the reports

class Report
{
  String year;
  String event;
  String location;
  String pysFX;
  String Multimedia;
  String ETcontact;
  String abduction;
  
  Report( String line )
  {
     //using space as delimiter, store the data in a temporary array for each line
    String delims = "[ ]+";
    String[] temps = line.split(delims);
    
    //add the current values of temp array to the structure
    year = temps[0];
    event = temps[1];
    location = temps[2];
    pysFX = temps[3];
    Multimedia = temps[4];
    ETcontact = temps[5];
    abduction = temps[6];
    
  }
}

