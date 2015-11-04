   Dataset[] dataset =  new Dataset [250];
int LISTSIZE;

void setup()
{
  size(600,600);
  LISTSIZE=250;
  
  
  loader(); //So everything will be populated from the start
  datacalc(); //so I have some fancy figures from the start and so I can verify my things are working
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
     String CPUB=row.getString("CPUB");
     dataset[i].CPUB =CPUB;
     
     String CPU=row.getString("CPU");
     dataset[i].CPU =CPU;
     
     int CPUOC=row.getInt("CPUOC");
     dataset[i].CPUOC =CPUOC;
     
     int GPUOC = row.getInt("GPUOC");
     dataset[i].GPUOC =GPUOC;
     
     int RAMOC= row.getInt("RAMOC");
     dataset[i].RAMOC =RAMOC;
     
     String GPUB=row.getString("GPUB");
     dataset[i].GPUB =GPUB;
     
     int GPUprice=row.getInt("GPUprice");
     dataset[i].GPUprice =GPUprice;
     
     int RAM=row.getInt("RAM");
     dataset[i].RAM =RAM;
     
     int DDR=row.getInt("DDR");
     dataset[i].DDR =DDR;
     
     int PSU=row.getInt("PSU");
     dataset[i].PSU =PSU;
     
     int Monitors=row.getInt("Monitors");
     dataset[i].Monitors =Monitors;
     
     int Refresh=row.getInt("Refresh");
     dataset[i].Refresh =Refresh;
     
     int Res=row.getInt("Res");
     dataset[i].Res =Res;
     i++;
  }
}//end loading in data
