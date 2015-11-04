   Dataset[] dataset =  new Dataset [250];

void setup()
{
  
  loader();
 
}

void loader()
{
 
 for(int i=0;i<250;i++)
 {
   dataset[i] = new Dataset();
   //"Because otherwise you have the array, but each element in the array is nul initially "
   
 }
}
