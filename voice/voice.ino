#include <VoiceRecognition.h>
VoiceRecognition Voice;

void setup() {
  // put your setup code here, to run once:
   Serial.begin(57600);

  Voice.init();
  Voice.addCommand("qiao",0);
  Voice.addCommand("bu",1);
  Voice.start();
}

void loop() {
  // put your main code here, to run repeatedly:
  //stage3 
  switch(Voice.read()){
   case 0:
      Serial.println("C1");
      break;
   case 1:
      Serial.println("CN");
      break; 
   }
}
