#include <Wire.h>
int mpu = 0x68;
int buzzer = 9;
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;
int index = 0;
int xindex = 0;
double prev;
double current; 
double post;
double prevx;
double currentx;
double postx;
double maxTime;
double diff1;
double diff2; 
double minTime;
double maxArray[3];
int count = 1;
bool isFreezingOrTurning = false;
bool freezing = false;


const float alpha = 0.5; 

void determineIfMax(){
if(prev < current && post < current && current > 0){
maxTime = (index-1)*0.05;
maxArray[count] = maxTime;
count = count + 1;
}
}

void checkIndexDistance(){
  if(maxArray[0] != 0){
    if(abs(((index*0.05) - maxArray[0]) > 7.5)){
      memset(maxArray, 0, sizeof(maxArray));
      count = 0;
    }
  }
  }

void checkPeakDistances(){
diff1 = abs(maxArray[1] - maxArray[0]);
diff2 = abs(maxArray[2] - maxArray[1]);
if(((diff1+diff2)/2) < 2){ //change this time accordingly
isFreezingOrTurning = true;
} 
}

void determineIfMin(){

  if(prevx > currentx && postx > currentx && currentx < -0.5){ //get confirmation on the amplitude of c
    minTime = (xindex - 1)*0.05;
  }
}


void Zscroll(){
  index = index + 1;
if(index == 1){
prev = GyZ;
}
else if(index == 2){
current = GyZ;
}
else{
post = GyZ;
determineIfMax();
checkIndexDistance();
if(sizeof(maxArray) == 3){
checkPeakDistances();
memset(maxArray, 0, sizeof(maxArray));
count = 0;
}
prev = current;
current = post;
}
}

void Xscroll(){
xindex = xindex + 1;
  if(xindex == 1){
    prevx = AcX;
  }
  else if(xindex == 2){
    currentx = AcX;
  }
  else{
  postx = AcX;
  determineIfMin();
  if(isFreezingOrTurning == true){
  if(abs(maxTime - minTime) < 2){
    freezing = true;
  }
  else{
    freezing = false;
    minTime = 0;
  }
  }
  }
  prevx = currentx;
  currentx = postx;
  
}



void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
pinMode(buzzer, OUTPUT);
Wire.begin();
Wire.beginTransmission(mpu);
Wire.write(0x6B);
Wire.write(0);
Wire.endTransmission(true);
}

void loop() {
  // put your main code here, to run repeatedly:
Wire.beginTransmission(mpu);
Wire.write(0x3B);
Wire.endTransmission(false);
Wire.requestFrom(mpu, 14, true);
AcX=Wire.read()<<8|Wire.read();
AcY=Wire.read()<<8|Wire.read();
AcZ=Wire.read()<<8|Wire.read();
Tmp=Wire.read()<<8|Wire.read();
GyX=Wire.read()<<8|Wire.read();
GyY=Wire.read()<<8|Wire.read();
GyZ=Wire.read()<<8|Wire.read();
delay(50);

Zscroll();
Xscroll();
if(freezing == true){
  //turn motor on
  digitalWrite(buzzer, HIGH);
  isFreezingOrTurning = false;
  freezing = false;
  memset(maxArray, 0, sizeof(maxArray));
  minTime = 0;
  maxTime = 0;
  delay(3500);
  digitalWrite(buzzer, LOW);
}
index = index + 1;
}



