#include <VoiceRecognition.h>
VoiceRecognition Voice;
int led_pin = 11;
int fsr_pin1 = A0;
int fsr_pin2 = A1;
int fsr_pin_start = A3;
int ris_pin1 = A3;
int ris_pin2 = A5;
int pr_min = 200;
void setup()
{
  Serial.begin(115200);
  pinMode(led_pin, OUTPUT);

//  Voice.init();
//  Voice.addCommand("a ma kai men",0);
//  Voice.addCommand("bu",1);
//  Voice.start();
}

void loop()
{ //stage1
  int fsr_value1 = analogRead(fsr_pin1); // 讀取FSR
  int fsr_value2 = analogRead(fsr_pin2);
  int fsr_start = analogRead(fsr_pin_start);
  int led_value = map(fsr_value1, 0, 1023, 0, 255); // 從0~1023映射到0~255
 // analogWrite(led_pin, led_value); // 改變LED亮度
  //Serial.println(fsr_value1);
  //Serial.println(led_value);
  //Serial.println("-------------");
  delay(100);
//  Serial.println(fsr_value1);
//  Serial.write("-------------");
//  Serial.println(fsr_value2);
  //stage2
  int ris_value1 = analogRead(ris_pin1);
  int ris_value2 = analogRead(ris_pin2);
  //Serial.println(ris_value2);
   // Serial.println("ris_value1: "+ris_value1);
  //  Serial.println("ris_value2: "+ris_value2);
//  //stage3 
//  switch(Voice.read()){
//   case 0:
//      Serial.write("C1");
//      break;
//   case 1:
//      Serial.write("CN");
//      break; 
//   }

  //check for stage1&2
  if(fsr_value1>180){
      Serial.println("A1");
     // Serial.write(fsr_value1);
    }
  if(fsr_value2 > 180){
   //   Serial.write(fsr_value2);
      Serial.println("A2");      
    }
  if(ris_value1 > 100){
    //  Serial.write(ris_value1);
      Serial.println("B1");      
    }
  if(ris_value2 > 100){
    //  Serial.println(ris_value2);
      Serial.println("B2");      
    }
 // digitalWrite(13, ris_value2 > pr_min ? LOW : HIGH);
}

