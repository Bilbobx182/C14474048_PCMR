Dataset[] dataset =  new Dataset [6000];
int LISTSIZE;
//PImage intel;
//PImage amd;
void setup()
{
  size(600,600);
  //intel = loadImage("intel.png");
 // amd= loadImage("AMD.gif");
  LISTSIZE=6000;
  
  
  loader(); //So everything will be populated from the start
  datacalc(); //so I have some fancy figures from the start and so I can verify my things are working
 drawcirclegraph();
 //graph on AMD VS NVIDIA
 IVA();
 //INTEL VS AMD
 RAMgraph();
 //RAM
 Stemleaf();
 //amd vs nvidia price
}

 int PSUAVG,t1;
 int RESAVG,t2;
 int RAMAVG,t3;
 int GPUAVG,t4;
void datacalc()
{

 for(int i=0;i<LISTSIZE;i++)
 {
   t1=t1+dataset[i].PSU;
   t2=t2+dataset[i].Res;
   t3=t3+dataset[i].RAM;
   t4=t4+dataset[i].GPUprice;
 }
 PSUAVG=t1/LISTSIZE;
 RESAVG=t2/LISTSIZE;
 RAMAVG=t3/LISTSIZE;
 GPUAVG=t4/LISTSIZE;
// mode put put into array then sort array boom
//  println(PSUAVG,RESAVG,RAMAVG,GPUAVG); 
  
}//end calculating math stuff

void loader()
{
 
 for(int i=0;i<LISTSIZE;i++)
 {
   dataset[i] = new Dataset();
   //"Because otherwise you have the array, but each element in the array is nul initially "
   
 }
   //loading it into a table, 
   Table table;
   table = loadTable("finaldata.csv","header");
   int i=0;
   for (TableRow row : table.rows()) 
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


void IVA()
{
  /*
line(width/2,0,width/2,height);
  int icount,acount;
  float ichange,achange;
  int min,max;
  
  min=0;
  max=width/2;
  ichange=achange=icount=acount=0;
  for(int i=0; i< LISTSIZE;i++)
  {
    if(dataset[i].CPUB.equalsIgnoreCase("Intel")) 
    {
      icount++;
    } 
    else
    {
      acount++;
    }
  }
  ichange=map(icount,0,LISTSIZE,min,max);
  achange=map(acount,0,LISTSIZE,min,max);
 // image(intel,0, (height-64) -64);
 //image(amd,width-128,(height-64)-64);
  println(ichange,achange);
  
  for(int i=0;i<ichange;i++)
  {
    fill(0,150,255);
    noStroke();
   ellipse(random(300),random(450),10,10);
  }
  float random;
   for(int i=0;i<achange;i++)
  {
    random=random(600);
    if ( random < width/2)
    {
      i--;
    }
    else
    {
     fill(30,200,40);
      noStroke();
   ellipse(random,random(450),10,10);
    }
  }
  */
}

void RAMgraph()
{
  /*
  //vars
  float GB4,GB8,GB16,GB32,NGB;
  int border=100;
  int max,min;
  background(0);
  //vardata
  max=500;
  min=0;
  GB4=GB8=GB16=GB32=NGB=0;
  
  //calculating ram amounts
  for(int i=0; i< LISTSIZE;i++)
  {
    switch(dataset[i].RAM) 
    {
      case 4: 
      GB4++;  break;
    
      case 8:  
      GB8++;break;
    
      case 16:
      GB16++; break;
    
      case 32:
      GB32++; break;
    
      default:
      NGB++;break;
    }
   }
   print("org values");
   println(GB4,GB8,GB16,GB32+NGB);
   print("SUM");
   println(GB4+GB8+GB16+GB32+NGB);
   
       // scaling it var  0 -> LISTSIZE   0 500
   GB4=map(GB4,0,LISTSIZE,min,max);
   GB8=map(GB8,0,LISTSIZE,min,max);
   GB16=map(GB16,0,LISTSIZE,min,max);
   GB32=map(GB32,0,LISTSIZE,min,max);
   NGB=map(NGB,0,LISTSIZE,min,max);

   
   stroke(255,0,0);
   line(border,height-border,width-border,height-border);
   line(border,height-border,border,border);
   
  float mod;
   line(border,border,border+GB4,border);
   text((GB4),border+GB4,border);
   
   mod=border*2;
   
   line(border,mod,border+GB8,mod);
   text((GB8),mod+GB8,mod);
   
   mod=border*3;
   line(border,mod,border+GB16,mod);
    text(GB16,mod+GB16,mod);
    
    mod=border*4;
   line(border,mod,border+GB32,mod);
   text(GB32,mod+GB32,mod);
     mod=border*4.8;
   line(border,mod,border+NGB,mod);
   text(NGB,mod+NGB,mod);
   int counter=0;
   for(int i=0;i<9;i++)
   {
     text(counter,border+counter,(height-border)+20);
     counter+=50;
   }
   */
}



int AMD,NVIDIA,OTHER=0;
String readin;

//center xy, radius NVIDIA,RADIUSAMD,RADIUS OTHER
int cx,cy,rn,ra,ro;

void drawcirclegraph()
{
  /*
  //note this does not scale, it only deals with 250 worth of data. scaling to be done later
  
  cx=width/2;
cy=height/2;
 background(0);
 fill(25,0,255);
  textSize(20);
  text("AMD VS NVIDIA GPU",width/2,height/5);
  for(int i=0; i< LISTSIZE;i++)
  {
   if(dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
   {
    NVIDIA++;
    } 
  else if(dataset[i].GPUB.equalsIgnoreCase("AMD"))
  {
    AMD=AMD+1;
  }
  else
  {
    OTHER++;
  }  
  }
  NVIDIA=NVIDIA*2;
  AMD=AMD*2;
  OTHER=OTHER*2;
  fill(0,255,0);
  ellipse(cx,cy,NVIDIA,NVIDIA);
  fill(255,0,0);
  ellipse(cx,cy,AMD,AMD);
  fill(0,0,0);
  ellipse(cx,cy,OTHER,OTHER);
  println(NVIDIA,AMD,OTHER);
  */ 
}


void Stemleaf()
{
  float e100,e200,e300,e500,e700;//euro counter
  float a100,a200,a300,a500,a700;//and counter for cost
  float n100,n200,n300,n500,n700; //Nvidia cost counter
  int sep;
  sep=50;
e100=e200=e300=e500=e700=a100=a200=a300=a500=a700=n100=n200=n300=n500=n700=0;
  //creating the layout
  line( (width/2)-50,0,(width/2) -50,height );
  line( (width/2)+50,0,(width/2) +50,height );
  line(0,height*.1,width,height*.1);
    
   for(int i=0; i< LISTSIZE;i++)
  {
    switch(dataset[i].GPUprice) 
    {
      case 100: 
      e100++;
       if(dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
       {
       n100++;
      } 
      else
      {
        a100++;
      }
      break;
       
       
      case 200:  
      e200++;
        if(dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
       {
       n200++;
      } 
      else
      {
        a200++;
      }
      break;
      
      
      case 300:
      e300++;
        if(dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
       {
       n300++;
      } 
      else
      {
        a300++;
      }
      break;
      
      case 500:
      e500++;
        if(dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
       {
       n500++;
      } 
      else
      {
        a500++;
      }
      break;
      
      case 700:
      e700++;
       if(dataset[i].GPUB.equalsIgnoreCase("NVIDIA")) 
       {
       n700++;
      } 
      else
      {
        a700++;
      }
      break;
    }
  }
  println(e100,a100,n100);
}
