   Dataset[] dataset =  new Dataset [250];
int LISTSIZE;

void setup()
{
  size(600,600);
  LISTSIZE=250;
  
  
  loader(); //So everything will be populated from the start
  datacalc(); //so I have some fancy figures from the start and so I can verify my things are working
 drawcirclegraph();
 
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
  println(PSUAVG,RESAVG,RAMAVG,GPUAVG); 
  
}//end calculating math stuff

void loader()
{
 
 for(int i=0;i<250;i++)
 {
   dataset[i] = new Dataset();
   //"Because otherwise you have the array, but each element in the array is nul initially "
   
 }
   //loading it into a table, 
   Table table;
   table = loadTable("FDtest.csv","header");
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

int AMD,NVIDIA,OTHER=0;
String readin;

//center xy, radius NVIDIA,RADIUSAMD,RADIUS OTHER
int cx,cy,rn,ra,ro;

void drawcirclegraph()
{
  
  //note this does not scale, it only deals with 250 worth of data. scaling to be done later
  /*
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
