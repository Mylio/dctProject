import processing.serial.*;
Serial stage;  // Create object from Serial class
Serial stage3;//left 1411 for voice
PImage startImg1; // start image for stage1
PImage startImg2; // start image for stage2
PImage startImg3; // start image for stage3
PGraphics pg1;
PGraphics pg2;
PGraphics pg3;
float []bgalpha;
float initAlpha = 255;//set initial alpha


String stageValue;
String stageValue2;
//String seriValue;
//String portName = Serial.list()[2];
String portName2 = Serial.list()[1]; //test
int serialNo = 115200;
int serialNo2 = 57600;//for stage3
//stage1 86 / Fish 21
int stageIng;
boolean count1_1,count1_2,count2_1,count2_2,count3_1;
//stage1
float energy;
float energyLimit = 60;
float energy1_2;
float energyLimit1_2 = 60;
int fishQuan = 10;
int fishQuan1_2 = 10;
float gX = width/3;
float gY = 600;
float gX1_2 = width/2+30;
float gY1_2 = 600;
int status;
int fno [];
int fno1_2 [];
int gaFishQuan;
int gaFishQuan1_2;
final int gamePlay=3,gameWin=4,gameBreak=5;
//stage2
float energy2;
float energyLimit2 = 60;
float energy2_2;
float energyLimit2_2 = 60;
int fishQuan2 = 10;
int fishQuan2_2 = 10;
float gX2 = 150;
float gY2 = 350;
float gX2_2 = 250;
float gY2_2 = 350;
int status2;
int fno2 [];
int fno2_2 [];
int gaFishQuan2;
int gaFishQuan2_2;
final int gamePlay2=3,gameWin2=4,gameBreak2=5;//is it okay final sample.
//stage3
float energy3;
float energyLimit3 = 60;
int fishQuan3 = 10;
float gX3 = 170;
float gY3 = 100;
int status3;
int fno3 [];
int gaFishQuan3;
final int gamePlay3=3,gameWin3=4,gameBreak3=5;//is it okay final sample.

//FishDraw
ArrayList fishes;
float numfish = 25;
float t;
//Class
Fish[] fish;
Fish[] fish1_2;
Fish[] fish2;
Fish[] fish2_2;
Fish[] fish3;

void setup(){
 // fullScreen();
  size(1220,488);
colorMode(HSB,360);//for FishDraw
energy = 0;
gaFishQuan = 0;
gaFishQuan1_2 = 0;
gaFishQuan2 = 0;
gaFishQuan2_2 = 0;
gaFishQuan3 = 0;
status = gamePlay;
stageIng = 1;
count1_1=false;
count1_2=false;
count2_1=false;
count2_2=false;
count3_1=false;
//fish
fish = new Fish[fishQuan];
fno = new int [10];
fish1_2 = new Fish[fishQuan];
fno1_2 = new int [10];
fish2 = new Fish[fishQuan];
fno2 = new int [10];
fish2_2 = new Fish[fishQuan];
fno2_2 = new int [10];
fish3 = new Fish[fishQuan];
fno3 = new int [10];
//start image
startImg1 = loadImage("start1.jpg");
startImg2 = loadImage("start2.jpg");
startImg3 = loadImage("start3.jpg");
pg1 = createGraphics(width, height/3);
pg2 = createGraphics(width, height/3);
pg3 = createGraphics(width, height/3);
bgalpha=new float[6];
for(int i=0;i<bgalpha.length;i++){bgalpha[i] = initAlpha;}
//FishDraw
stroke(0);
smooth();
numfish = 1;
t = 0;
fishes = new ArrayList();
for (int i = 1; i < numfish+1; i++) {
   fishes.add(new FishDraw(-(width/2)/18-random(width)/18,-(height/2)/18+(floor(random(numfish))*(height/numfish))/18,(3*PI)/2,(6+floor(random(0,3))*20)/360.0,int(random(6) > 1)-random(0.1)));
  }//end fishDraw

makeFish();
//stage = new Serial(this,portName,serialNo);
//stage3 = new Serial(this,portName2,serialNo2);
}
void draw(){
background(0);
//checkEnergy();
drawEnergy();
statusCheck();
drawStartImg();
//for image
pg3.beginDraw();
pg3.background(204,102,100,bgalpha[2]); //set bg color
pg3.endDraw();
image(pg3, 0, 0); 
pg2.beginDraw();
pg2.background(204,102,100,bgalpha[1]);
pg2.endDraw();
image(pg2, 0, height/3); 
pg1.beginDraw();
pg1.background(204,102,100,bgalpha[0]);
pg1.endDraw();
image(pg1, 0, height*2/3); 
}

void reStart(){
  status = gamePlay;
  stageIng = 1;
  count1_1=false;
  count1_2=false;
  count2_1=false;
  count2_2=false;
  count3_1=false;
  energy = 0;
  energy1_2 = 0;
  energy2 = 0;
  energy2_2 = 0;
  energy3 = 0;
  gaFishQuan = 0;
  gaFishQuan1_2 = 0;
  gaFishQuan2 = 0;
  gaFishQuan2_2 = 0;
  gaFishQuan3 = 0;
  for(int i=0;i<bgalpha.length;i++){bgalpha[i] = initAlpha;}
  fill(255);
  
  makeFish();
}
void drawStartImg(){
  if(stageIng == 1){
     //if(bgalpha[3]>10){
     //for(int i=510;i<0;i--){bgalpha[3]-=0.5;}
     //}
    tint(255,bgalpha[3]);
    image(startImg1,0,height*2/3);
    noTint(); 
    }
  if(stageIng == 2){
    tint(255,bgalpha[4]);
    image(startImg2,0,height/3);
    noTint();
                    //rect(width,height/3,0,height/3);
                  }
  if(stageIng == 3){
    tint(255,bgalpha[5]);
    image(startImg3,0,0);
    noTint();
}
}
void drawGoal(){
  ellipseMode(CENTER);
  fill(100);
  ellipse(gX,gY,20,20);
  ellipse(gX1_2,gY1_2,20,20);
  ellipse(gX2,gY2,20,20);
  ellipse(gX2_2,gY2_2,20,20);
  ellipse(gX3,gY3,20,20);
  
}
void drawEnergy(){
  rect(0,height*2/3,energy,50);//note that as default, energy grows from up to down
  rect(width/2,height*2/3,energy1_2,50);
  rect(0,height*1/3,energy2,50);
  rect(width/2,height*1/3,energy2_2,50);
  rect(0,0,energy3,50);
}
void makeFish(){
  
    for(int k=0;k<fish.length;k++){
      fish[k] = new Fish(k,random(width),random(height),1);
      fish1_2[k] = new Fish(k,random(width),random(height),1);
      fish2[k] = new Fish(k,random(width),random(height),2);
      fish2_2[k] = new Fish(k,random(width),random(height),2);
      fish3[k] = new Fish(k,random(width),random(height),3);
    }
  
}
void drawFish(){
   if(energy2 >= 45){
    gatherFish(10,2);
  }else if(energy2 >=40){
    gatherFish(8,2);
  }else if(energy2 >= 25){
    gatherFish(4,2);
  }
  if(energy >= 45){
    gatherFish(10,1);
  }else if(energy >=40){
    gatherFish(8,1);
  }else if(energy >= 25){
    gatherFish(4,1);
  }
    if(energy1_2 >= 45){
    gatherFish(10,12);
  }else if(energy1_2 >=40){
    gatherFish(8,12);
  }else if(energy1_2 >= 25){
    gatherFish(4,12);
  }
  
   
    if(energy2_2 >= 45){
    gatherFish(10,22);
  }else if(energy2_2 >=40){
    gatherFish(8,22);
  }else if(energy2_2 >= 25){
    gatherFish(4,22);
  }
   
    if(energy3 >= 45){
    gatherFish(10,3);
  }else if(energy3 >=40){
    gatherFish(8,3);
  }else if(energy3 >= 25){
    gatherFish(4,3);
  }
  
  
  for(int j=0;j<fish.length;j++){
    fish[j].display();
    fish2[j].display();
    fish1_2[j].display();
    fish2_2[j].display();
    fish3[j].display();
  }
  
  for(int k=0;k<fish.length;k++){
    fish[k].move();
    fish2[k].move();
    fish1_2[k].move();
    fish2_2[k].move();
    fish3[k].move();
    
      if(k<gaFishQuan){
      fish[k].gather(gX,gY);
      }
      if(k<gaFishQuan1_2){
      fish1_2[k].gather(gX1_2,gY1_2);
      }
      if(k<gaFishQuan2){
      fish2[k].gather(gX2,gY2);
      }
      if(k<gaFishQuan2_2){
      fish2_2[k].gather(gX2_2,gY2_2);
      }
      if(k<gaFishQuan3){
      fish3[k].gather(gX3,gY3);
      }
  }
  
 
}
void gatherFish(int quan,int stage){//quan have to be less than fishQuan
  //quan += gaFishQuan;
 // for(int m=gaFishQuan;m <quan;m++){
    if(stage == 3){
      for(int m=gaFishQuan;m <quan;m++){
   //     fish3[m].gather(gX3,gY3);
        gaFishQuan3 ++;
    }}
    if(stage == 2){
      for(int m=gaFishQuan;m <quan;m++){
   //     fish2[m].gather(gX2,gY2);
    gaFishQuan2 ++;
    println(gaFishQuan2);
    }}
    if(stage == 1){
      for(int m=gaFishQuan;m <quan;m++){
    //  fish[m].gather(gX,gY);
      gaFishQuan ++;
      println(gaFishQuan);
      }
    }
    if(stage == 12){
      for(int m=gaFishQuan;m <quan;m++){  
     //   fish1_2[m].gather(gX1_2,gY1_2);
        gaFishQuan1_2 ++;
      }
      }
    
    if(stage == 22){
      for(int m=gaFishQuan;m <quan;m++){
     //   fish2_2[m].gather(gX2_2,gY2_2);
    gaFishQuan2_2 ++;
    }}
    
 // }//m
}
//FishDraw
void drawFishes(){
      t = t+1;
    for (int i = fishes.size()-1; i >= 0; i--) {
      FishDraw fish1 = (FishDraw) fishes.get(i);
      float[] pos1 = fish1.getpos();
      float th = fish1.getth();
      float fisht = fish1.getfisht(1);
      float randt = fish1.getfisht(0);
      fisht = fisht + 1;
      fish1.display(t);
      if (fisht%(50+randt) == 0){
        fish1.setth(th+signs(random(-1,1))*random(PI/4));
        fisht = 0;
        randt = round(random(50));
      }
      fish1.setfisht(fisht,randt);
      fish1.update();
      if ((pos1[1] > ((width/2)+100)/18) || (pos1[2] > ((height/2)+100)/18) || (pos1[2] < -((height/2)+100)/18)){
        fishes.remove(i);
        fishes.add(new FishDraw(-(width/2)/18-random((3*width)/2)/18,-(height/2)/18+(floor(random(numfish))*(height/numfish))/18,(3*PI)/2,(6+floor(random(0,3))*20)/360.0,int(random(6) > 1)-random(0.1)));
      }
    }
   // println(fishes.get(0));
     
  }
   
  float signs(float a){
    if (a > 0){
      return 1;
    } else if (a == 0){
      return 0;
    } else{
      return -1;
    }
}//end FishDraw

void statusCheck(){
  switch(status){
    case gamePlay:
      play();
      drawFish();
      drawGoal();
      drawFishes();
      break;
    case gameWin:
      gameWin();
      break;
    case gameBreak:
      gameBreak();
      break;
    default:
     // println( "aaa" );
      break;
  }
}
void gameWin(){ 
  status = gameBreak;
  println("win");
}
void gameBreak(){
  textSize(50);
  textAlign(CENTER,CENTER);
  fill(0,150,153,204);
  text("Congrats!\nyou WIN",width/2,80);
}
void play(){
  if(energy >= energyLimit){
        count1_1 = true;
        //println(count1_1);
      }
  if(energy1_2 >= energyLimit1_2){
        count1_2 = true;
       // println(count1_2);
      }
  if(count1_1 && count1_2){stageIng = 2; 
    //println("ING: "+stageIng);
    }
  if(energy2 >= energyLimit2){
        count2_1 = true;
      }
  if(energy2_2 >= energyLimit2_2){
        count2_2 = true;
  }
  if(count1_1 && count1_2 && count2_1 && count2_2){stageIng = 3;}
  if(energy3 >= energyLimit3){
        count3_1 = true;
        println("energy3 >= energyLimit3");
  }
  if(count3_1){
    status = gameWin;
  }
  if(stageIng==1){
    if(bgalpha[0]>5){bgalpha[0]--;}
     if(bgalpha[3]>5){bgalpha[3]-=0.2;}
  }
  if(stageIng==2){
    if(bgalpha[1]>5){bgalpha[1]--;}
    if(bgalpha[4]>5){bgalpha[4]-=0.2;}
  }
  if(stageIng==3){
    if(bgalpha[2]>5){bgalpha[2]--;}
    if(bgalpha[5]>5){bgalpha[5]-=0.2;}
  }
  //for(int i=0;i<3;i++){
  //  if(i < stageIng){
  //    println("here"+i);
  //    for(float j=initAlpha;j<1;j--){
  //      bgalpha[i]--;
  //      println("222");
  //    }
  //  }
  //}
}
void checkEnergy(){
  if(stage.available()>0){
     stageValue = stage.readString();
     println(stageValue);
     if(stageValue.trim().equals( "A1")  && stageIng==1){
       energy+=20;
       println("A1 get");
     }
     if(stageValue.trim().equals("A2") && stageIng==1){
       energy1_2 +=20;
       println("A2 get");
     }
     if(stageValue.trim().equals("B1") && stageIng==2){
       energy2 +=20;
       println("B1get");
     }
     if(stageValue.trim().equals("B2") && stageIng==2){
       energy2_2 +=20;
       println("B2get");
     }
  }else{
   // println("No~~~");
    //println(Serial.list()[1]);
    }
  //stage3
     if(stage3.available()>0){
     stageValue2 = stage3.readString();
     println(stageValue2);
     if(stageValue2.trim().equals("C1") ){
       energy3 +=20;
     }
  }else{
   // println("No~~~");
    //println("1__"+Serial.list()[1]);
    //println("2__"+Serial.list()[2]);
    //println("0__"+Serial.list()[0]);
    }
}
void keyPressed() {
  if(status == gamePlay){
    if(key == 'L'){
      energy++;
    }else if(key == 'Z'){
      energy+=50;
    }else if(key == 'A'){
      energy2+=50;
    }else if(key == 'Q'){
      energy3+=50;
    }else if(key == 'X'){
      energy1_2+=50;
      println(energy1_2);
    }else if(key == 'S'){
      energy2_2+=50;
    }
    if(key == ENTER){
      reStart();
    }
  }else if(status == gameBreak){
    if(key == ENTER){
      reStart();
    }
  }
}