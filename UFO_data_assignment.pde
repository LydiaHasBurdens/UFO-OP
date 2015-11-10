/*
  Object Oriented Programming
  data visualisation assignment, year2 semester 1 
  
  -get the data read in.
  -display data as a simple trend graph to verify correct data read in.
  -choose three data vizualizations to suit the data
    1. trend graph
    2. world colour map
    3. people picture visualization
  -impliment these
  -design a menu to enable user to choose which data to view
  -include a way for user to return to menu 
  
*/


void setup()
{
  size(500, 500, P3D);
  
  lines = loadStrings("ufocasedata.txt"); //will be loading each line into string array

  magic = false;
  
  testcount = 1;
}

String[] lines;

//create an arraylist for each element in the 'structure'
ArrayList<String> year = new ArrayList<String>();
ArrayList<String> event = new ArrayList<String>();
ArrayList<String> location = new ArrayList<String>();
ArrayList<String> pysFX = new ArrayList<String>();
ArrayList<String> Multimedia = new ArrayList<String>();
ArrayList<String> ETcontact = new ArrayList<String>();
ArrayList<String> abduction = new ArrayList<String>();


int testcount;
ArrayList<Integer> YearCount = new ArrayList<Integer>();

boolean magic;


void draw()
{
  background(0);
  
   if(magic == false)
    {
  for(String s:lines)//loop through all lines 
  {
    //using space as delimiter, store the data in a temporary array for each line
    String delims = "[ ]+";
    String[] temps = s.split(delims);
    
    //add the current values of temp array to the array lists 
    year.add(temps[0]);
    event.add(temps[1]);
    location.add(temps[2]);
    pysFX.add(temps[3]);
    Multimedia.add(temps[4]);
    ETcontact.add(temps[5]);
    abduction.add(temps[6]);
    
  }
  
  //to differentiate bewteen the last year and the end
  //year.add("0000");
    
   
     for( int i = 1; i < 201; i++ )
     {
       int intyear = Integer.parseInt(year.get(i));
       int intyear2 = Integer.parseInt(year.get(i-1));
       if( intyear == intyear2 )
       {
         testcount++;
       }
       else
       {
         YearCount.add(testcount);
         testcount = 1;
       }
     }
    }
   
   magic = true;
   float border = width * 0.1f;
   drawAxis(YearCount ,year , 10, 20, border);
   stroke(0, 255, 255);
      
     
   float windowRange = (width - (border * 2.0f));
   float dataRange = 20;      
   float lineWidth =  windowRange / (float) (YearCount.size() - 1);
    
   float scale = (windowRange / dataRange);
   for (int k = 1 ; k < YearCount.size() ; k ++)
   {
       float x1 = border + ((k - 1) * lineWidth);
       float x2 = border + (k * lineWidth);
       float y1 = (height - border) - (YearCount.get(k - 1)) * scale;
       float y2 = (height - border) - (YearCount.get(k)) * scale;
       line(x1, y1, x2, y2);
      
   } 
    
}//end draw


//draw the axis for the trend graph
void drawAxis(ArrayList data, ArrayList horizLabels, int verticalIntervals, float vertDataRange, float border)
{
  stroke(200, 200, 200);
  fill(200, 200, 200);  
  
  // Draw the horizontal azis  
  line(border, height - border, width - border, height - border);
  
  float windowRange = (width - (border * 2.0f));  
  
  float horizInterval =  windowRange / 20;
  float tickSize = border * 0.1f;
  
    
  for (int i = 0 ; i < 21 ; i++ )
  {   
   // Draw the ticks
   float x = border + (i * horizInterval);
    line(x, height - (border - tickSize), x, (height - border));
   float textY = height - (border * 0.5f);
  
   if(  i % 2 == 0 && (10*i)<= 201)
   {
     // Print the text 
     textAlign(CENTER, CENTER);
     text(year.get((10*i)), x, textY);
   }
   
   
  }//end for loop
  
  // Draw the vertical axis
  line(border, border , border, height - border);
  
  float verticalDataGap = vertDataRange / verticalIntervals;
  float verticalWindowRange = height - (border * 2.0f);
  float verticalWindowGap = verticalWindowRange / verticalIntervals; 
  for (int i = 0 ; i <= verticalIntervals ; i ++)
  {
    float y = (height - border) - (i * verticalWindowGap);
    line(border - tickSize, y, border, y);
    float hAxisLabel = verticalDataGap * i;
        
    textAlign(RIGHT, CENTER);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  }
  
  
  
}//end drawaxis
