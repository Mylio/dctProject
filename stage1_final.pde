import ddf.minim.*;//sound
import processing.serial.*;
Minim minim;//sound
Serial stage;  // Create object from Serial class
Serial stage3;//left 1411 for voice
PImage startImg0;
PImage startImg1; // start image for stage1
PImage startImg2; // start image for stage2
PImage startImg3; // start image for stage3
PImage river; 
PImage pass1; 
PImage pass2;
PImage pass3; 
PGraphics pg1;
PGraphics pg2;
PGraphics pg3;
float []bgalpha;
float initAlpha = 225;//set initial alpha
AudioPlayer sound1n2;
AudioPlayer sound3_s;
AudioPlayer sound3_f;

String stageValue;
String stageValue2;
String portName = Serial.list()[2]; //***
String portName2 = Serial.list()[1]; //***
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
float gX = 1000;
float gY = 376;
float gX1_2 = 900;
float gY1_2 = 112;
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
float gX2 = 604;
float gY2 = 416;
float gX2_2 = 712;
float gY2_2 = 160;
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
//final int gamePlay3=3,gameWin3=4,gameBreak3=5;//is it okay final sample.

//FishDraw
float t;
ArrayList fishes;
PImage b;
float numfish;
int diedfish1;
int[] diedfish = new int[6];
int fishLimit;
float speed;
float portion;

//Class
Fish[] fish;
Fish[] fish1_2;
Fish[] fish2;
Fish[] fish2_2;
Fish[] fish3;

void setup(){
//music
  minim = new Minim(this);
  sound1n2 = minim.loadFile("round1n2.mp3");
  sound3_s = minim.loadFile("round3_correct.mp3");
  sound3_f = minim.loadFile("round3_wrong.mp3");
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
startImg0 = loadImage("start0.png");
startImg1 = loadImage("start1.png");
startImg2 = loadImage("start2.png");
startImg3 = loadImage("start3.png");
river = loadImage("river.png");
pass1 = loadImage("pass1.png");
pass2 = loadImage("pass2.png");
pass3 = loadImage("pass3.png");
pg1 = createGraphics(width/3, height);
pg2 = createGraphics(width/3, height);
pg3 = createGraphics(width/3, height);
bgalpha=new float[6];
for(int i=0;i<bgalpha.length;i++){bgalpha[i] = initAlpha;}

//FishDraw
stroke(0);
smooth();
numfish = 50;
t = 0;
fishLimit=0;
speed = 30;
portion = 18/speed;
//diedfish = 0;
fishes = new ArrayList();
for (int i = 1; i < numfish+1; i++) {
   fishes.add(new FishDraw(-(width/2)/speed-random(width)/speed,-(height/2)/speed+(floor(random(numfish))*(height/numfish))/speed,(3*PI)/2,(6+floor(random(0,3))*20)/360.0,int(random(6) > 1)-random(0.1)));
  }//end fishDraw

makeFish();
stage = new Serial(this,portName,serialNo); //***
stage3 = new Serial(this,portName2,serialNo2);//***
}
void draw(){
background(0);
checkEnergy(); //***
drawEnergy();
statusCheck();
drawStartImg();
drawWinImg();
//for image
//pg3.beginDraw();
//pg3.background(204,102,100,bgalpha[2]); //set bg color
//pg3.endDraw();
//image(pg3, 0, 0); 
//pg2.beginDraw();
////pg2.background(204,102,100,bgalpha[1]);
//pg2.endDraw();
//image(pg2, width/3, 0); 
pg1.beginDraw();
pg1.background(0,0,0,bgalpha[0]);
pg1.endDraw();
image(pg1, width*2/3, 0); 
//start0
if(stageIng == 1){
    tint(255,bgalpha[0]);
    startImg0.resize(0, height);
    image(startImg0,width*2/3-1,0);
    noTint(); 
}else{bgalpha[0]=0;}
//for test ***
drawGoal();
}

void reStart(){
  delay(8000);
  key='f';
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
  for (int i = fishes.size()-1; i >= 0; i--) {
      FishDraw fish1 = (FishDraw) fishes.get(i);
        fish1.ga = 0;
   } 
  makeFish();
}
void drawStartImg(){
  if(stageIng == 1){
    tint(255,bgalpha[3]);
    image(river,0,0);
    image(river,width/3,0);
    image(river,width*2/3,0);
    noTint(); 
    river.resize(0, height);
  }
  if(stageIng == 2){
    tint(255,bgalpha[3]);
    image(river,0,0);
    image(river,width*2/3,0);
    image(pass1,width*2/3,0);
    noTint();
   river.resize(0,height);
   pass1.resize(0,height);
  }
  if(stageIng == 3){
    tint(255,bgalpha[3]);
    image(river,width/3,0);
    image(river,width*2/3,0);
    image(pass1,width/3,0);
    image(pass2,width*2/3,0);
    noTint(); 
    pass1.resize(0, height);
    pass2.resize(0, height);
  }
  if(stageIng == 1){
    tint(255,bgalpha[3]);
    startImg1.resize(0, height);
    image(startImg1,width*2/3-1,0);
    noTint(); 
    }
  if(stageIng == 2){
    tint(255,bgalpha[4]);
    startImg2.resize(0, height);
    image(startImg2,width/3,0);
    noTint();
                    //rect(width,height/3,0,height/3);
                  }
  if(stageIng == 3){
    tint(255,bgalpha[5]);
    startImg3.resize(0, height);
    image(startImg3,0,0);
    noTint();
}
}
void drawWinImg(){
  if(status==gameBreak){
    image(river,0,0);    
    image(river,width/3,0);
    image(river,width/3,0);    
    image(river,width*2/3,0);
    image(pass3,0,0);
    image(pass2,width/3,0);
    image(pass2,width*2/3,0);
    pass3.resize(0, height);
    pass2.resize(0, height);
  }
}
void drawGoal(){
  ellipseMode(CENTER);
  fill(0,255,0);
  noStroke();
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
//void drawFish(){
//   if(energy2 >= 45){
//    gatherFish(10,2);
//  }else if(energy2 >=40){
//    gatherFish(8,2);
//  }else if(energy2 >= 25){
//    gatherFish(4,2);
//  }
//  if(energy >= 45){
//    gatherFish(10,1);
//  }else if(energy >=40){
//    gatherFish(8,1);
//  }else if(energy >= 25){
//    gatherFish(4,1);
//  }
//    if(energy1_2 >= 45){
//    gatherFish(10,12);
//  }else if(energy1_2 >=40){
//    gatherFish(8,12);
//  }else if(energy1_2 >= 25){
//    gatherFish(4,12);
//  }
  
   
//    if(energy2_2 >= 45){
//    gatherFish(10,22);
//  }else if(energy2_2 >=40){
//    gatherFish(8,22);
//  }else if(energy2_2 >= 25){
//    gatherFish(4,22);
//  }
   
//    if(energy3 >= 45){
//    gatherFish(10,3);
//  }else if(energy3 >=40){
//    gatherFish(8,3);
//  }else if(energy3 >= 25){
//    gatherFish(4,3);
//  }
  
  
//  for(int j=0;j<fish.length;j++){
//    fish[j].display();
//    fish2[j].display();
//    fish1_2[j].display();
//    fish2_2[j].display();
//    fish3[j].display();
//  }
  
//  for(int k=0;k<fish.length;k++){
//    fish[k].move();
//    fish2[k].move();
//    fish1_2[k].move();
//    fish2_2[k].move();
//    fish3[k].move();
    
//      if(k<gaFishQuan){
//      fish[k].gather(gX,gY);
//      }
//      if(k<gaFishQuan1_2){
//      fish1_2[k].gather(gX1_2,gY1_2);
//      }
//      if(k<gaFishQuan2){
//      fish2[k].gather(gX2,gY2);
//      }
//      if(k<gaFishQuan2_2){
//      fish2_2[k].gather(gX2_2,gY2_2);
//      }
//      if(k<gaFishQuan3){
//      fish3[k].gather(gX3,gY3);
//      }
//  }
  
 
//}
//void gatherFish(int quan,int stage){//quan have to be less than fishQuan
//  //quan += gaFishQuan;
// // for(int m=gaFishQuan;m <quan;m++){
//    if(stage == 3){
//      for(int m=gaFishQuan;m <quan;m++){
//   //     fish3[m].gather(gX3,gY3);
//        gaFishQuan3 ++;
//    }}
//    if(stage == 2){
//      for(int m=gaFishQuan;m <quan;m++){
//   //     fish2[m].gather(gX2,gY2);
//    gaFishQuan2 ++;
//    println(gaFishQuan2);
//    }}
//    if(stage == 1){
//      for(int m=gaFishQuan;m <quan;m++){
//    //  fish[m].gather(gX,gY);
//      gaFishQuan ++;
//      println(gaFishQuan);
//      }
//    }
//    if(stage == 12){
//      for(int m=gaFishQuan;m <quan;m++){  
//     //   fish1_2[m].gather(gX1_2,gY1_2);
//        gaFishQuan1_2 ++;
//      }
//      }
    
//    if(stage == 22){
//      for(int m=gaFishQuan;m <quan;m++){
//     //   fish2_2[m].gather(gX2_2,gY2_2);
//    gaFishQuan2_2 ++;
//    }}
    
// // }//m
//}
//FishDraw
void drawFishes(){
     //fishDraw
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
    if ((pos1[1] > ((width/2)+100)/speed) || (pos1[2] > ((height/2)+100)/speed) || (pos1[2] < -((height/2)+100)/speed)){
      fishes.remove(i);
      fishes.add(new FishDraw(-(width/2)/speed-random((3*width)/2)/speed,-(height/2)/speed+(floor(random(numfish))*(height/numfish))/speed,(3*PI)/2,(6+floor(random(0,3))*20)/360.0,int(random(6) > 1)-random(0.1)));
    }
     //if ( key == 'r' ){
     // fish1.ga = 1;
     // print(pos1[1] , pos1[2]  , "\n");
    //}
    
    if ( ( key == 'a') && (pos1[1] > 13*portion)&& (pos1[1] <15*portion) && (pos1[2] > -8*portion) && (pos1[2] <  -4*portion) ){
      fish1.ga = 1;
    }
    if ( ( key == 'b') && (pos1[1] > 18*portion)&& (pos1[1] <19*portion) && (pos1[2] > 5.5*portion) && (pos1[2] < 9*portion) ){
      fish1.ga = 2;
    }
    if ( ( key == 'c') && (pos1[1] > -3*portion)&& (pos1[1] <1*portion) && (pos1[2] < 16*portion) && (pos1[2] > 8*portion) ){
      fish1.ga = 3;
    }
    if ( ( key == 'd') && (pos1[1] > 4.5*portion)&& (pos1[1] <6.5*portion) && (pos1[2] < -3*portion) && (pos1[2] > -7*portion) ){
      fish1.ga = 4;
    }
    if ( ( key == 'e') && (pos1[1] > -27*portion) && (pos1[1] <-25*portion)&& (pos1[2] > -9*portion) && (pos1[2] < -7*portion) ){
      fish1.ga = 5;
    }
    if ( ( key == 'f') ){  
      fish1.ga = 0;
    }
  }
  
  // catch number of died fish
  for(int i =0;i<6;i++){
    diedfish[i] = 0;
  }
   for (int i = fishes.size()-1; i >= 0; i--) {
      FishDraw fish1 = (FishDraw) fishes.get(i);
      if (fish1.ga == 1){
        diedfish[1]++;
      }
      if (fish1.ga == 2){
        diedfish[2]++;
      }
      if (fish1.ga == 3){
        diedfish[3]++;
      }
      if (fish1.ga == 4){
        diedfish[4]++;
      }
      if (fish1.ga == 5){
        diedfish[5]++;
      }
   }
   //print (diedfish[1] +"\n");
     
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
    //  drawFish(); //water pokemon
      drawGoal();
      drawFishes();
      break;
    case gameWin:
      gameWin();
      break;
    case gameBreak:
      //gameBreak();
      status = gamePlay;
      reStart();
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
//void gameBreak(){
//  textSize(50);
//  textAlign(CENTER,CENTER);
//  fill(0,150,153,204);
//  text("Congrats!\nyou WIN",width/2,80);
//}
void play(){
  if((energy >= energyLimit) && (diedfish[1]>fishLimit)){
        count1_1 = true;
        //println(count1_1);
      }
  if((energy1_2 >= energyLimit1_2)&& (diedfish[2]>fishLimit)){
        count1_2 = true;
       // println(count1_2);
      }
  if(count1_1 && count1_2){
    stageIng = 2; 
    for (int i = fishes.size()-1; i >= 0; i--) {
      FishDraw fish1 = (FishDraw) fishes.get(i);
      if (fish1.ga == 1 || fish1.ga==2){
        fish1.ga = 0;
      }
    }
    //println("ING: "+stageIng);
    }
  if((energy2 >= energyLimit2)&& (diedfish[3]>fishLimit)){
        count2_1 = true;
      }
  if((energy2_2 >= energyLimit2_2)&& (diedfish[4]>fishLimit)){
        count2_2 = true;
  }
  if(count1_1 && count1_2 && count2_1 && count2_2){
      stageIng = 3;
      for (int i = fishes.size()-1; i >= 0; i--) {
      FishDraw fish1 = (FishDraw) fishes.get(i);
      if (fish1.ga == 3 || fish1.ga==4){
        fish1.ga = 0;
      }
    }  
  }
  if((energy3 >= energyLimit3 )&& (diedfish[5]>fishLimit)){
        count3_1 = true;
        println("energy3 >= energyLimit3, fishLimit get");  
  }
  if(count3_1){
    status = gameWin;
  }
  if(stageIng==1){
    if(bgalpha[0]>5){bgalpha[0]--;}
  //   if(bgalpha[3]>5){bgalpha[3]-=0.2;}
  }
  //if(stageIng==2){
  //  if(bgalpha[1]>5){bgalpha[1]--;}
  //  if(bgalpha[4]>5){bgalpha[4]-=0.2;}
  //}
  //if(stageIng==3){
  //  if(bgalpha[2]>5){bgalpha[2]--;}
  //  if(bgalpha[5]>5){bgalpha[5]-=0.2;}
  //}
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
       key = 'a';
       sound1n2.rewind();
       sound1n2.play();
       println("A1 get");
     }
     if(stageValue.trim().equals("A2") && stageIng==1){
       energy1_2 +=20;
       key = 'b';
       sound1n2.rewind();
       sound1n2.play();
       println("A2 get");
     }
     if(stageValue.trim().equals("B1") && stageIng==2){
       energy2 +=20;
       key = 'c';
       sound1n2.rewind();
       sound1n2.play();
       println("B1get");
     }
     if(stageValue.trim().equals("B2") && stageIng==2){
       energy2_2 +=20;
       key = 'd';
       sound1n2.rewind();
       sound1n2.play();
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
     if(stageValue2.trim().equals("C1") && (stageIng ==3) ){
       energy3 +=20;
       key = 'e';
       sound3_s.rewind();
       sound3_s.play();
     }else if(stageValue2.trim().equals("CN") && (stageIng ==3) ){
       sound3_f.rewind();
       sound3_f.play();
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
    }else if(key == 'a'){
      energy+=50;  
      sound1n2.rewind();
      sound1n2.play();
    }else if(key == 'c'){
      energy2+=50;
      sound1n2.rewind();
      sound1n2.play();
    }else if(key == 'e'){
      energy3+=50;
      sound3_s.rewind();
      sound3_s.play();
    }else if(key == 'b'){
      energy1_2+=50;
      sound1n2.rewind();
      sound1n2.play();
      println(energy1_2);
    }else if(key == 'd'){
      energy2_2+=50;
      sound1n2.rewind();
      sound1n2.play();
    }
    if(key == ENTER){
      reStart();
    }
    //cheat key
    if(key == 'A'){
       count1_1 = true  ;  
    }
    if(key == 'B'){
       count1_2 = true  ;
    }
    if(key == 'C'){
       count2_1 = true  ; 
    }
    if(key == 'D'){
       count2_2 = true  ;
    }
    if(key == 'E'){
       count3_1 = true  ;
    }
  }else if(status == gameBreak){
    if(key == ENTER){
      reStart();
    }
  }
}