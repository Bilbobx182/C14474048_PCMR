import gifAnimation.*;
import org.gicentre.utils.gui.HelpScreen;

HelpScreen menu;
PFont largeFont, smallFont;
Dataset[] dataset =  new Dataset [6000];
int LISTSIZE;
int graphs;
Gif fry;

void setup()
{
  size(600, 600);
  graphs=0; 
  LISTSIZE=6000;
  loader(); //So everything will be populated from the start
  datacalc(); //so I have some fancy figures from the start and so I can verify my things are working
  menu();

  //variables for the gif
  fry = new Gif(this, "futurama.gif");
  fry.loop();

  //Creating a custom font for the rest of the program
  PFont font;
  font = createFont("CoolveticaRg-Regular-13", 12);
  textFont(font);

  //INITIALIZE the menu and what it's going to display
  int vspace = 20;
  int hsize = 12;

  menu = new HelpScreen(this, font);
  menu.setHeader("Quick Menu", vspace, hsize);

  menu.putEntry("H", "Turn the quickmenu screen on and off");
  menu.addSpacer();
  menu.putEntry("Esc", "Quits the sketch");
  menu.putEntry("1", "Main menu");
  menu.putEntry("2", "Stem and leaf");
  menu.putEntry("3", "RAM graph");
  menu.putEntry("4", "Bullseye graph");
  menu.putEntry("5", "Resolution graph");
  menu.putEntry("6", "Stats"); 
  menu.setBackgroundColour(color(#ffd700));
  menu.setFooter("C14474048 Assignment", 20, 10);
}

int PSUAVG, t1;
int RESAVG, t2;
int RAMAVG, t3;
int GPUAVG, t4;
int MONAVG, t5;
void datacalc()
{

  background(255);
  frameRate(100);
  for (int i=0; i<LISTSIZE; i++)
  {
    t1=t1+dataset[i].PSU;
    t2=t2+dataset[i].Res;
    t3=t3+dataset[i].RAM;
    t4=t4+dataset[i].GPUprice;
    t5=t5+dataset[i].Monitors;
  }
  PSUAVG=t1/LISTSIZE;
  RESAVG=t2/LISTSIZE;
  RAMAVG=t3/LISTSIZE;
  GPUAVG=t4/LISTSIZE;
  MONAVG=t5/LISTSIZE;
}//end calculating math stuff
//-----------------------------------------------------------------------------------------------OPTION 6---------------------------------------------------------------------------
void disdata()
{
  PFont font;
  font = createFont("CoolveticaRg-Regular-13", 12);
  textFont(font);
  frameRate(30);
  int x, y;
  x=50;
  y=195;
  fill(#ffdf00);
  background(0);
  textAlign(CENTER, BOTTOM);
  text("Statistics and other tid bits", width/2, x);
  textAlign(LEFT);
  text("PSU Average WATT:"+PSUAVG, x, y);
  text("Resolution Average:"+RESAVG, x, y+100);
  text("RAM Average:"+RAMAVG+"GB", x, y+200);
  text("GPU Price Average:"+GPUAVG+"USD", x, y+300);
  text("Monitors Average:"+MONAVG, x, y+400);
  image(fry, x+(x*4), height/2, 300, 200);
}


void loader()
{

  for (int i=0; i<LISTSIZE; i++)
  {
    dataset[i] = new Dataset();
    //"Because otherwise you have the array, but each element in the array is nul initially "
  }
  //loading it into a table, 
  Table table;
  table = loadTable("finaldata.csv", "header");
  int i=0;
  for (TableRow row : table.rows ()) 
  {
    //loads the contents of FDTEST into the table, populates the table per element, then puts table element into the dataset.
    dataset[i].CPUB=row.getString("CPUB");
    dataset[i].CPU=row.getString("CPU");
    dataset[i].CPUOC=row.getInt("CPUOC");
    dataset[i].GPUOC = row.getInt("GPUOC");
    dataset[i].RAMOC=row.getInt("RAMOC");
    dataset[i].GPUB =row.getString("GPUB");
    dataset[i].GPUprice =row.getInt("GPUprice");
    dataset[i].RAM =row.getInt("RAM");
    dataset[i].DDR=row.getInt("DDR");
    dataset[i].PSU=row.getInt("PSU");
    dataset[i].Monitors=row.getInt("Monitors");
    dataset[i].Refresh=row.getInt("Refresh");
    dataset[i].Res=row.getInt("Res");
    i++;
  }
}//end loading in data

void draw()
{
  PFont font;
  font = createFont("CoolveticaRg-Regular-13", 12);
  textFont(font);
  //detecting for each menu option
  switch (graphs)
  {    
  case 1:     
    menu();
    break;

  case 2:
    Stemleaf();
    break;

  case 3:
    RAMgraph();
    break;

  case 4:
    drawcirclegraph();
    break;

  case 5:
    res();
    break;

  case 6:
    disdata();
    break;
  }

  if (menu.getIsActive())
  {
    menu.draw();
  }
}
//----------------------------------------------------------------------------------OPTION 5------------------------------------------------------------------------------------------
void res()
{

  float r720, r1080, r2048;//for where they'd be on my monitor
  float c1, c2, c3;//counters for resolutions less than and including 720, resolution that is 1080 and finally more.
  r720=720;//Screen res variables so they scale accordingly
  r1080=1080;
  r2048=2048;
  c1=c2=c3=0;
  r720=(map(r720, 0, 2048, 0, 600));
  r1080=(map(r1080, 0, 2048, 0, 600));
  r2048=(map(r2048, 0, 2048, 0, 600));
  //  println(r720, r1080, r2048);
  for (int i=0; i<LISTSIZE; i++)
  {
    if (dataset[i].Res == 720|| dataset[i].Res < 720)
    {
      c1++;
    }
    if (dataset[i].Res>720 && dataset[i].Res < 1081)//1 above 1080 so as to not take it in 
    {
      c2++;
    }
    if (dataset[i].Res > 1080)
    {
      c3++;
    }
  }
  c1=(c1/LISTSIZE)*100;
  c2=(c2/LISTSIZE)*100;
  c3=(c3/LISTSIZE)*100;
  //  println(c1, c2, c3);
  noStroke();
  fill(#ffff1a);
  rect(0, 0, r2048, r2048);
  fill(#DF7401);
  rect(0, 0, r1080, r1080);
  fill(#70DB93);
  rect(0, 0, r720, r720);

  fill(0);
  textAlign(LEFT);
  text("% Of users on 2048p: " +c3, r2048-(width/4), r2048);
  text("% Of users on 1080p: "+c2, r1080-(width/4), r1080);
  text("% Of users on 720p:"+c1, (r720-(width/4)) +10, r720);
}

void mousePressed()
{
  if (mouseY<100)
  { 
    Stemleaf();
  }
}

//----------------------------------------------------------------------------------OPTION 1 MENU---------------------------------------------------------------------
void menu()
{

  int x;
  int[] y= {
    100, 200, 300, 400, 500
  };// it auto formats it to this, when I control T...........
  int mod=100;
  background(0);
  fill(#ffcc00);
  stroke( #ffcc00);

  for (int i=0; i<5; i++)
  {
    line(0, y[i], width, y[i]);
  }
  PImage pcmr;
  pcmr = loadImage("pc.png");
  //Menu options without the flashlight on them
  textAlign(LEFT);
  fill(#ffdf00);
  text(" AMD VS NVIDIA", 0, (y[0]/2));
  text("RAM", 0, y[0]+(y[0]/2));
  text("AMD vs NVIDIA Market share", 0, y[1]+(y[0]/2));
  text("Resolution graph", 0, y[2]+(y[0]/2));
  text("STATS", 0, y[3]+(y[0]/2));
  textSize(26);
  text("PRESS 1 TO RETURN TO THE MENU", 120, y[4]+(y[0]/2));
  textSize(12);
  image(pcmr, 0, y[4]+(y[0]/2));

  if (mouseY<100)
  { 
    fill(#ffdf00);
    rect(0, 0, width, y[0]); 
    fill(0);
    text(" AMD VS NVIDIA PRESS 2", 0, (y[0]/2));
  }
  if (mouseY>100 && mouseY<200)
  {
    fill(#ffdf00);
    rect(0, y[0], width, y[0]);
    fill(0);
    text("RAM PRESS 3", 0, y[0]+(y[0]/2));
  }

  if (mouseY>200 && mouseY<300)
  {
    fill(#ffdf00);
    rect(0, y[1], width, y[0]);
    fill(0);
    text("AMD vs NVIDIA Market share PRESS 4", 0, y[1]+(y[0]/2));
  }
  if (mouseY>300 && mouseY<400)
  {
    fill(#ffdf00);
    rect(0, y[2], width, y[0]);
    fill(0);
    text("Resolution graph PRESS 5", 0, y[2]+(y[0]/2));
  }
  if (mouseY>400 && mouseY<500)
  {
    fill(#ffdf00);
    rect(0, y[3], width, y[0]);
    fill(0);
    text("STATS PRESS 6", 0, y[3]+(y[0]/2));
  }
}

void keyPressed()
{
  if (key >= '0' && key <='9' )
  {
    graphs = key - '0';
  }
  if ((key == 'h') || (key == 'H'))
  {
    menu.setIsActive(!menu.getIsActive());
  }
}
//-------------------------------------------------------------------------------------OPTION 3 RAMGRAPH-----------------------------------------------------------------------------------

void RAMgraph()
{
  fill(255);
  //vars
  float GB4, GB8, GB16, GB32, NGB;
  float border=100;
  int max, min;
  background(0);
  //vardata
  max=400;
  min=0;
  GB4=GB8=GB16=GB32=NGB=0;

  //calculating ram amounts
  for (int i=0; i< LISTSIZE; i++)
  {
    switch(dataset[i].RAM) 
    {
    case 4: 
      GB4++;  
      break;

    case 8:  
      GB8++;
      break;

    case 16:
      GB16++; 
      break;

    case 32:
      GB32++; 
      break;

    default:
      NGB++;
      break;
    }
  }
  //  print("org values");
  //  println(GB4, GB8, GB16, GB32+NGB);
  //  print("SUM");
  //  println(GB4+GB8+GB16+GB32+NGB);

  // scaling it var  0 -> LISTSIZE   0 500
  GB4=map(GB4, 0, LISTSIZE, min, max);
  GB8=map(GB8, 0, LISTSIZE, min, max);
  GB16=map(GB16, 0, LISTSIZE, min, max);
  GB32=map(GB32, 0, LISTSIZE, min, max);
  NGB=map(NGB, 0, LISTSIZE, min, max);


  stroke(255, 0, 0);
  line(border, height-border, width-border, height-border);
  line(border, height-border, border, border);

  float mod;
  //calculating the borders including each modifier
  textAlign(LEFT);
  stroke(0, 255, 0);
  strokeWeight(3);
  line(border, border, border+GB4, border);
  text("GB4", border-(border/2), border);

  mod=border*2;
  stroke(#FFDF00);
  line(border, mod, border+GB8, mod);
  text("GB8", border-(border/2), mod);

  stroke(0, 255, 0);
  mod=border*3;
  line(border, mod, border+GB16, mod);
  text("GB16", border-(border/2), mod);

  mod=border*4;
  line(border, mod, border+GB32, mod);
  text("GB32", border-(border/2), mod);

  mod=border*4.8;
  line(border, mod, border+NGB, mod);
  text("Other", border-(border/2), mod);

  strokeWeight(1);
  int counter=0;
  for (int i=0; i<9; i++)
  {
    text(counter, border+counter, (height-border)+20);
    counter+=50;
  }

  textAlign(CENTER);
  text("Amount of users", (width)/2, height-(border/2));
  text(" How many users have nGB", width/2, border/2);
  textAlign(CENTER);
}

//----------------------------------------------------------------------------OPTION 4, NVIDIA VS AMD MARKET SHARE-----------------------------------------------------------------------
void drawcirclegraph()
{ 
  float AMD, NVIDIA, OTHER, INTEL;
  int cx, cy, rn, ra, ro, border;
  INTEL=AMD=NVIDIA=OTHER=cx=cy=rn=ra=ro=0;
  border=55;

  cx=width/2;
  cy=height/2;
  background(0);
  fill(#FFDF00);
  textAlign(CENTER);
  text("Brand GPU Ownership", (width/2), 50);

  //creating the scale so the people know
  stroke(#FFDF00);
  line(width/2, height-border, width, height-border);
  int mod;
  mod=5;
  textAlign(CENTER, TOP);
  for (int i=0; i<600; i+=100)
  {
    //printing out the scale
    text(i, width/2 + mod, height-border);
    mod+=border;
  }

  //Calculating the GPU ownership
  for (int i=0; i< LISTSIZE; i++)
  {
    if (dataset[i].CPUB.equalsIgnoreCase("INTEL")) 
    {
      INTEL++;
    } else if (dataset[i].CPUB.equalsIgnoreCase("AMD"))
    {
      AMD=AMD+1;
    } else
    {
      OTHER++;
    }
  }

  AMD=(map(AMD, 0, LISTSIZE, 0, width-100) );
  INTEL= (map(INTEL, 0, LISTSIZE, 0, width-100));
  noStroke();

  //Creating the circles
  fill(#89CFF0);
  ellipse(cx, cy, INTEL, INTEL);
  fill(208, 21, 21);
  ellipse(cx, cy, AMD, AMD);

  //creating a black rect to take over half the circle so I can label everything
  fill(0);
  rect(0, border+(border/2), width/2, height-border);

  //doing the lines and numbers

  stroke(#89CFF0);
  line(width/4, height/2, width/2, height/2);
  fill(#FFDF00);
  textAlign(LEFT, BOTTOM);
  text("AMD users: "+(int)AMD, width/4, (height/2));

  stroke(#32b600);
  line(width/4, height/2-(border*2), width/2, height/2-(border*2));
  fill(#FFDF00);
  textAlign(LEFT, BOTTOM);
  text("INTEL users: "+(int)INTEL, width/4, (height/2)-(border*2));
}
//------------------------------------------------------------------------------------------OPTION 2 STEMLEAF-------------------------------------------------------------------------------
void Stemleaf()
{
  background(0);
  float e100, e200, e300, e500, e700;//euro counter
  float a100, a200, a300, a500, a700;//and counter for cost
  float n100, n200, n300, n500, n700; //Nvidia cost counter
  int sep;
  int numcount=100;
  float x, y;
  x=width/2;
  y=height*.27;
  sep=50;
  e100=e200=e300=e500=e700=a100=a200=a300=a500=a700=n100=n200=n300=n500=n700=0;//really long init on making them 0 so there's no random data.
  //creating the layout
  stroke(255, 215, 0);
  strokeWeight(1);
  line( (width/2)-50, 0, (width/2) -50, height );
  line( (width/2)+50, 0, (width/2) +50, height );
  line(0, height*.1, width, height*.1);
  textAlign(CENTER);
  fill(255);
  text("COST IN €", width/2, height*.05);
  text("amount of AMD users", width/4, height*.05);
  text("amount of NVIDIA users", (width-(width/6)), height*.05);

  //middle counter sign thing
  for (int i=0; i<5; i++)
  {
    text(numcount, x-10, y);
    y=y+100;

    if (i<2)
    {
      numcount+=100;
    } else
    {
      numcount+=200;
    }
  }
  y=height*.15;
  int range=0;
  int x1=(width/2) -60;
  int x2=(width/2) +55;
  for (int i=0; i<5; i++)
  {
    text(range, x1, y);
    text(range, x2, y);
    x1-=50;
    x2+=50;
    range+=50;
    //    println(x1, y-.10);
  }

  for (int i=0; i< LISTSIZE; i++)
  {
    //Calculating the quantity of people that have AMD or NVIDIA AT a certain price range
    switch(dataset[i].GPUprice) 
    {
    case 100: 
      e100++;
      if (dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
      {
        n100++;
      } else
      {
        a100++;
      }
      break;


    case 200:  
      e200++;
      if (dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
      {
        n200++;
      } else
      {
        a200++;
      }
      break;


    case 300:
      e300++;
      if (dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
      {
        n300++;
      } else
      {
        a300++;
      }
      break;

    case 500:
      e500++;
      if (dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
      {
        n500++;
      } else
      {
        a500++;
      }
      break;

    case 700:
      e700++;
      if (dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
      {
        n700++;
      } else
      {
        a700++;
      }
      break;
    }
  }
  float test2=e100+e200+e300+e500+e700;
  float test = a100+a200+a300+a500+a700+n100+n200+n300+n500+n700;
  int min=0;
  int max=600;
  //mapping the values so they scale
  a100=map(a100, 0, LISTSIZE, min, max);
  a200=map(a200, 0, LISTSIZE, min, max);
  a300=map(a300, 0, LISTSIZE, min, max);
  a500=map(a500, 0, LISTSIZE, min, max);
  a700=map(a700, 0, LISTSIZE, min, max);

  n100=map(n100, 0, LISTSIZE, min, max);
  n200=map(n200, 0, LISTSIZE, min, max);
  n300=map(n300, 0, LISTSIZE, min, max);
  n500=map(n500, 0, LISTSIZE, min, max);
  n700=map(n700, 0, LISTSIZE, min, max);

  //testing to make sure they mapped properly.
  //println(a100,a200,a300,a500,a700);
  //println(n100,n200,n300,n500,n700);
  //  println("100€", a100, n100);
  //  println("200€", a200, n200);
  //  println("300€", a300, n300);
  //  println("500€", a500, n500);
  //  println("700€", a700, n700);
  y=height*.27;
  stroke(255, 0, 0);

  //drawing lines
  strokeWeight(3);
  line( (width/2)-50, y, ((width/2)-50)-a100, y );
  line( (width/2)+50, y, ((width/2)+50)+n100, y );
  y+=100;
  line( (width/2)-50, y, ((width/2)-50)-a200, y );
  line( (width/2)+50, y, ((width/2)+50)+n300, y );
  y+=100;
  line( (width/2)-50, y, ((width/2)-50)-a300, y );
  line( (width/2)+50, y, ((width/2)+50)+n300, y );
  y+=100;
  line( (width/2)-50, y, ((width/2)-50)-a500, y );
  line( (width/2)+50, y, ((width/2)+50)+n500, y );
  y+=100;
  line( (width/2)-50, y, ((width/2)-50)-a700, y );
  line( (width/2)+50, y, ((width/2)+50)+n700, y );
}

//OTHER CODE THAT I may want to use
//-------------------------------------------------------------------------------------OPTION NOT IN THE MENU------------------------------------------------------------
void IVA()
{

  line(width/2, 0, width/2, height);
  int icount, acount;
  float ichange, achange;
  int min, max;

  min=0;
  max=width/2;
  ichange=achange=icount=acount=0;
  for (int i=0; i< LISTSIZE; i++)
  {
    if (dataset[i].CPUB.equalsIgnoreCase("Intel")) 
    {
      icount++;
    } else
    {
      acount++;
    }
  }
  ichange=map(icount, 0, LISTSIZE, min, max);
  achange=map(acount, 0, LISTSIZE, min, max);
  // image(intel,0, (height-64) -64);
  //image(amd,width-128,(height-64)-64);
  // println(ichange, achange);

  for (int i=0; i<ichange; i++)
  {
    fill(0, 150, 255);
    noStroke();
    ellipse(random(300), random(450), 10, 10);
  }
  float random;
  for (int i=0; i<achange; i++)
  {
    random=random(600);
    if ( random < width/2)
    {
      i--;
    } else
    {
      fill(30, 200, 40);
      noStroke();
      ellipse(random, random(450), 10, 10);
    }
  }
}

