/*
  Object Oriented Programming
  data visualisation assignment, year2 semester 1 
  
  Created: 30/10/15
  
  TO DO:
  -get the data read in.
  -display data as a simple trend graph to verify correct data read in.
  -choose three data vizualizations to suit the data
    1. trend graph
    2. world colour map
    3. people picture visualization
  -impliment these
  -design a menu to enable user to choose which data to view
  -include a way for user to return to menu
 
  UPDATED: 10/11/15
  -submitted version 1
  -used arraylists to hold each element seperatly
  -displayed the data in the form of a simple trend graph
  -fixed constantly repeating and moving graph my using a boolean to ensure the data only be added to YearCount during the first run
  -reads in data and utilises basic functionality 
  
  UPDATED: 11/11/2015
  -changed the use of arraylists to hold each element to using one arraylist to hold structures for the reports
  -made a function for drawing the trend graph instead of having it inside draw; drawTrend()
  -included little spaceship and light beam that moves across the screen displaying the data as it goes.

  UPDATED: 12/11/15
  -imported minim library for sounds
  -plays a sound as the spaceship moves across the screen
  
  UPDATED: 16/11/15
  -added the menu feature allowing the user to select which set to view using numbers
  -created the 'sky sphere' and ground plane
  
  UPDATED: 22/11/15
  -started the person graph, draws one person per report
  -reads the record and displays the people differently depending on the data
*/

import ddf.minim.*;//import minim for audio

//make an arraylist of report structures and one for the year count(no. of reports per year) 
ArrayList<Report> report = new ArrayList<Report>();
ArrayList<Integer> YearCount = new ArrayList<Integer>();

PImage grass;
PImage trend;
PImage worldMap;
PImage people;
PImage instr;
String[] lines;
PImage ship;
Minim minim;
AudioPlayer spaceship_sound;
boolean FirstRun;
int option;//menu option
float border; 
PImage camera;//icons for person graph
PImage phone;
float Px, Py;//coordinates for people in person graph
int j;//counters for person graph
float click, click2, click3;
boolean button1, button2, button3;
int counter;
float topx;//for the top left of the spaceship
PImage map;
float eyeZ; //Z position of 'camera' for menu


void setup()
{
  size(700, 700, P3D);
  
  grass = loadImage("grassTexture.jpg");
  trend = loadImage("trend.jpg");
  worldMap = loadImage("worldMap.jpg");
  people = loadImage("people.png");
  instr = loadImage("instr.jpg");
  minim = new Minim(this);
  spaceship_sound = minim.loadFile("Spaceship_sound.mp3");
  FirstRun = true;
  option = 0;
  camera = loadImage("Camera.jpg");
  phone = loadImage("phone.jpg");
  counter = 0;
  click = click2 = click3 = 255;
  button1=false;
  border = width * 0.1f;
  ship = loadImage("spaceship2.png");
  topx = width * 0.1f;//for the top left of the spaceship
  map = loadImage("map.png");
  eyeZ = height/0.5; 
  
  loadData();
  
 
}



void draw()
{
  background(0);
  strokeWeight(1);
  switch(option)
  {
  case 0:
  
    
    camera(width/2, height/2, eyeZ,width/2, height/2, 0, 0, 1, 0);
    world();
  
    topx = width * 0.1f;//for the top left of the spaceship
    spaceship_sound.rewind();
  break;
  case 1:
    camera(width/2, height/2, 600,width/2, height/2, 0, 0, 1, 0);
    background(125);
    j = 0;
    Px = width * 0.1;//coordinates for the 'people'
    Py = height * 0.1;
    
    
    while(j < report.size()-1)
    {
        DisplayPerson(Px, Py, report.get(j));
       
        if(Px > width - border)
        {
          Px = width * 0.1;
          Py += height/12.5;
        }
        else
        {
          Px += width/25;
        }
        
        
      
        j++;
       
    }
    topx = width * 0.1f;//for the top left of the spaceship
    spaceship_sound.rewind();
  break;
  case 2:
    camera(width/2, height/2, 600,width/2, height/2, 0, 0, 1, 0);
   //draw the trend graph
   drawAxis(YearCount , report, 10, 20, border);
   drawTrend(YearCount, FirstRun, border);
   
   if( topx < width + 50 )
   {
    topx += 1.5; 
   }
   spaceship(border, topx);
   FirstRun = false;  //ensures values only get added for the first run and stops arraylist infinitely growing
  break;
  case 3:
    camera(width/2, height/2, 600,width/2, height/2, 0, 0, 1, 0);
    background(255);
    int k = 0;
    
     while(k < report.size()-1)
    {
        worldMap(report.get(k));
        k++;
       
    }
    
    topx = width * 0.1f;//for the top left of the spaceship
    spaceship_sound.rewind();
  break;
  }
  
}//end draw


//-------------------------------------- FUNCTIONS --------------------------------------------------------------------------------


//load data into the sketch
void loadData()
{
  lines = loadStrings("ufocasedata.txt"); //will be loading each line into string array
  
  for( int i = 0; i < lines.length; i++ )
  {
    Report report_temp = new Report(lines[i]);
    report.add(report_temp);
  }//end for
}//end loadData


//function for the generation of world menu
void world()
{
  //sky sphere
   pushMatrix();
   stroke(0);
   fill(0, 0, 125);
   translate(width/2, height/2, 0);
   sphere(2500);
   popMatrix();
  
  //ground plane tiles
  for( int x = -2500; x < 2500; x += 50 )
  {
    for( int z = 2500;  z > -2500; z -= 50 )
    {
      beginShape(QUAD);
      noStroke();
      textureMode(IMAGE);
      texture(grass);
      vertex(x, (height/2)+50, z+50, 0, 0);
      vertex(x+50, (height/2)+50, z+50, 50, 0);
      vertex(x+50, (height/2)+50, z, 50, 50);
      vertex(x, (height/2)+50, z, 0, 50);
      endShape();
    }
  }
  
  //menu option tiles (vertical)
  beginShape(QUAD);
      noStroke();
      textureMode(IMAGE);
      texture(instr);
      vertex(height*0.4, height*0.4, height/2+900, 0, 0);//image is size 1000 x 1000
      vertex(height*0.6, height*0.4, height/2+900 , 1000, 0);
      vertex(height*0.6, height*0.6, height/2+900 , 1000, 1000);
      vertex(height*0.4, height*0.6, height/2+900 , 0, 1000);
      endShape();
  
  beginShape(QUAD);
      noStroke();
      textureMode(IMAGE);
      texture(people);
      vertex(height*0.4, height*0.4, height/2+700, 0, 0);//image is size 600 x 319 
      vertex(height*0.6, height*0.4, height/2+700 , 600, 0);
      vertex(height*0.6, height*0.6, height/2+700 , 600, 319);
      vertex(height*0.4, height*0.6, height/2+700 , 0, 319);
      endShape();
      
       beginShape(QUAD);
      noStroke();
      textureMode(IMAGE);
      texture(trend);
      vertex(height*0.4, height*0.4, height/2+500, 0, 0);//image is size 1300 x 1004
      vertex(height*0.6, height*0.4, height/2+500 , 1300, 0);
      vertex(height*0.6, height*0.6, height/2+500 , 1300, 1004);      
      vertex(height*0.4, height*0.6, height/2+500 , 0, 1004);
      endShape();
      
       beginShape(QUAD);
      noStroke();
      textureMode(IMAGE);
      texture(worldMap);
      vertex(height*0.4, height*0.4, height/2+300, 0, 0);//image is size 550 293
      vertex(height*0.6, height*0.4, height/2+300 , 550, 0);
      vertex(height*0.6, height*0.6, height/2+300 , 550, 293);      
      vertex(height*0.4, height*0.6, height/2+300 , 0, 293);
      endShape();
      
      
}//end world


void keyPressed()//for setting the menu option chosen by user
{
    if(key == '0' )
    {
      option = key - '0';
    }
   
     if ((key == 'w' || key == 'W') && eyeZ > height*0.5 + 401) 
      {
  
        eyeZ -= 200;
       
      }
       if ((key == 's' || key == 'S') && eyeZ < height/0.5-1 ) 
      {
  
        eyeZ += 200;
        
      }
      
      if(key == ENTER && eyeZ == 1200)
      {
        option = 1;
      }
      else if(key == ENTER && eyeZ == 1000)
      {
        option = 2;
      }
      else if(key == ENTER && eyeZ == 800)
      {
        option = 3;
      }
   
} 

//person for the person graph
 void DisplayPerson(float Px, float Py, Report report)
  {
    fill(255, 0, 0);
    noStroke();
    ellipseMode(CENTER);
    rectMode(CENTER);
    float radius = width * 0.02;
    
    ellipse(Px, Py, radius, radius);
    rect(Px , Py + (height/40), width/50, height/33 );
    rect(Px , Py + (height/21), width/85, height/50);
     
    //if the report included an abduction show an alien head instead
    if(Integer.parseInt(report.abduction) == 1)
    {
      fill(0, 255, 0);
      ellipse(Px, Py, width * 0.02, width * 0.02);
      fill(0);
      ellipse(Px-(radius/2), Py, radius, radius/2);
      ellipse(Px+(radius/2), Py, radius, radius/2);
    }
    
    //check if the report included a multimedia evidence, display a camera if yes
    if(Integer.parseInt(report.abduction) == 1)
    {
      beginShape(QUAD);
      textureMode(IMAGE);
      texture(camera);
      vertex(Px+radius, Py+(height/50),1, 0, 0);
      vertex(Px+(radius*2), Py+(height/50),1, 50, 0);
      vertex(Px+(radius*2), Py+(height/15),1, 50, 111);
      vertex(Px+radius, Py+(height/15),1, 0, 111);
      endShape();
    }
    
    //check if the report included ETcontact and display a telephone
    if(Integer.parseInt(report.ETcontact) == 1)
    {
      beginShape(QUAD);
      textureMode(IMAGE);
      texture(phone);
      vertex(Px+(radius*0.3), Py,2, 0, 0);
      vertex(Px+(radius), Py,2, 50, 0);
      vertex(Px+(radius), Py+(height/35),2, 50, 100);
      vertex(Px+(radius*0.3), Py+(height/35),2, 0, 100);
      endShape();
    }
    
   
    textAlign(LEFT, LEFT);
    //graph legend
     fill(0, 255, 0);
      ellipse( width * 0.25, height - border, width * 0.02, width * 0.02);
      fill(0);
      ellipse((width * 0.25)-(radius/2), (height - border), radius, radius/2);
      ellipse((width * 0.25)+(radius/2), (height - border), radius, radius/2);
      textSize(15);
      text("Abduction", (width * 0.25)+20, (height - border));
    
    beginShape(QUAD);
      textureMode(IMAGE);
      texture(camera);
      vertex( width * 0.4, height * 0.85, 1, 0, 0);
      vertex( width * 0.4 + 20, height * 0.85,1, 50, 0);
      vertex( width * 0.4 + 20, height * 0.85 + 50 ,1, 50, 111);
      vertex( width * 0.4, height * 0.85 + 50,1, 0, 111);
      endShape();
      text("Multimedia Evidence", width * 0.4 + 25, (height - border));
      
    beginShape(QUAD);
      textureMode(IMAGE);
      texture(phone);
      vertex(width * 0.70, height * 0.85,2, 0, 0);
      vertex(width * 0.70 + 20, height * 0.85,2, 50, 0);
      vertex(width * 0.70 + 20, height * 0.85 + 50,2, 50, 100);
      vertex(width * 0.70, height * 0.85 + 50,2, 0, 100);
      endShape();
      text("ET contact", width * 0.70 + 25, (height - border));
    
  }//end draw_person()
  


  
  
//draw the axis for the trend graph
void drawAxis(ArrayList data, ArrayList<Report> report, int verticalIntervals, float vertDataRange, float border)
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
     textSize(20);
     text(report.get((10*i)).year, x, textY);
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
    textSize(20);  
    text((int)hAxisLabel, border - (tickSize * 2.0f), y);
  }
}//end drawaxis



void drawTrend(ArrayList<Integer> YearCount, boolean FirstRun, float border )
{
  
  int testcount = 1;
  
  if( FirstRun == true )//only runs for firstv run through of program
   {
      for( int i = 1; i < 203; i++ )
       {
         int intyear = Integer.parseInt(report.get(i).year);
         int intyear2 = Integer.parseInt(report.get(i-1).year);
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
     
   float windowRange = (width - (border * 2.0f));
   float dataRange = 20;      
   float lineWidth =  windowRange / (float) (YearCount.size() - 1);
   stroke(0, 255, 255);
    
   float scale = (windowRange / dataRange);
   for (int k = 1 ; k < YearCount.size() ; k ++)
   {
       float x1 = border + ((k - 1) * lineWidth);
       float x2 = border + (k * lineWidth);
       float y1 = (height - border) - (YearCount.get(k - 1)) * scale;
       float y2 = (height - border) - (YearCount.get(k)) * scale;
       line(x1, y1, x2, y2);
      
   }  
}//end drawTrend



//function for the trend graph spaceship
void spaceship(float border, float topx)
{
  //moves across the screen beaming down and revealing the data
  //makes cool spacesound
  
  float shipX = topx;//coordinates for the ship's upper left corner
  float shipY = border;
  
  spaceship_sound.play();
  
    //display as a single shape
    beginShape(QUAD);
    noStroke();
    textureMode(IMAGE);
    texture(ship);
    vertex(shipX, shipY, 0, 0);
    vertex(shipX + 50, shipY, 50, 0);
    vertex(shipX + 50, shipY + 44, 50, 44);//image is size 50x44 
    vertex(shipX, shipY+44, 0, 44);
    endShape();
    
    //box that reveals data
    beginShape(QUAD);
    fill(0);
    noStroke();
    vertex(shipX + 28, shipY + 40, 1);
    vertex(shipX + width, shipY + 40, 1);
    vertex(shipX + width, height - (border + 2), 1);
    vertex(shipX + 28, height - (border + 2), 1);
    endShape();
    
    //light beam
    stroke(245, 252, 177);
    strokeWeight(5);
    line(shipX + 26, shipY + 38, shipX+ 26, height - border);//middle of the ship at the bottom, going down to axis
  
}//end spaceship

//world map chart function
void worldMap(Report report)
{
  
  beginShape();
  noStroke();
    textureMode(IMAGE);
    texture(map);
    vertex(0, height * 0.15,-1, 0, 0);
    vertex(width, height * 0.15,-1, 2000, 0);
    vertex(width, height * 0.75, -1,2000, 926);//image is size 926 x 2000
    vertex(0, height * 0.75,-1, 0, 926);
  endShape();
  
  textAlign(LEFT, LEFT);
  textSize(30);
  text("Frequency of Reports Per Continent", width*0.2, height*0.05);
 
  
  if(report.location.equals("USA"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.06,width*0.19), random(height*0.3,height*0.37), 5, 5);
  }
  else if(report.location.equals("Australia"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.75,width*0.85), random(height*0.57,height*0.63), 5, 5);
  }
  else if(report.location.equals("Europe") || report.location.equals("Den/Nor") || report.location.equals("France") || report.location.equals("U K") || report.location.equals("Spain") || report.location.equals("Wales") || report.location.equals("Austria") || report.location.equals("Sweden") || report.location.equals("Switz"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.4,width*0.5), random(height*0.25,height*0.34), 5, 5);
  }
  else if(report.location.equals("Canada") || report.location.equals("N"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.06,width*0.19), random(height*0.2,height*0.3), 5, 5);
  }
  else if(report.location.equals("G/Mexico") || report.location.equals("N") || report.location.equals("Brazil") || report.location.equals("Costa"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.2,width*0.25), random(height*0.45,height*0.65), 5, 5);
  }
  else if(report.location.equals("S"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.45,width*0.53), random(height*0.45,height*0.55), 5, 5);
  }
  else if(report.location.equals("Malaysia") || report.location.equals("Russia") || report.location.equals("Isreal") || report.location.equals("Iran"))
  {
    fill(255, 0, 0);
    ellipse(random(width*0.5,width*0.8), random(height*0.20,height*0.4), 5, 5);
  }
}


