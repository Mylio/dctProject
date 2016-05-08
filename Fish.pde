class Fish{
PImage fishWater;
float fX,fY ;
int fNo;
int rxMove;
int ryMove;
float pt;
boolean ga = true;
float wlimit1,wlimit2,hlimit1,hlimit2;
int limit = 40;
  Fish(int f,float x,float y,int stage){
    fNo = f;
    fX = x;
    fY = y;
    rxMove = int(random(1));//return 0 or 1
    ryMove = int(random(1));
    wlimit1 = width;
    wlimit2 = 0;
    if(stage == 1){
      hlimit2 = height*2/3; hlimit1 = height;
      }else if(stage == 2){
      hlimit2 = height/3; hlimit1 = height*2/3;
      }else if(stage == 3){
      hlimit2 = 0; hlimit1 = height/3;println(hlimit1);println(height*2/3);}
    //hlimit1 = height;
    //hlimit2 = 0;
    //loadImage
    fishWater = loadImage("water.gif"); 
  }
  void display(){
    image(fishWater,fX,fY);
  }
  void move(){
    if(pt > 90 ){
        fX = 0;
        fY = 0;
        pt--;
    }else if(rxMove == 1){
      if(ryMove == 1){
        fX +=random(2);
        fY +=random(2); 
      }else{
        fX +=random(2);
        fY -=random(2); 
      }
    }else if(rxMove != 1){
      if(ryMove == 1){
        fX -=random(2);
        fY +=random(2); 
      }else{
        fX -=random(2);
        fY -=random(2); 
      }
    }
    
   if(fX > wlimit1){
     rxMove = 0;
   }else if(fX < wlimit2){
      rxMove = 1;   
   } 
   if(fY > hlimit1){
     ryMove = 0;
   }else if(fY < hlimit2){
      ryMove = 1;   
   }
  }
  void gather(float gX,float gY){
    if(ga){
      if((gX-fX)>0 ){
        rxMove = 1;
      }else{
        rxMove = 0;
      } 
      if((gY-fY)>0){
        ryMove = 1;
      }else{
        ryMove = 0;
      }
      if(abs(gX-fX)<5 && abs(gY-fY)<5){
        ga = false;
        println("get");
        wlimit1 = gX + limit;
        wlimit2 = gX - limit;
        hlimit1 = gY + limit;
        hlimit2 = gY - limit;
      }
    }
  }
 // void randomMove(float gX,float gY,range){}

}