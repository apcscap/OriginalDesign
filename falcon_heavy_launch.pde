float x;
float y;
float spd;
float acceleration;
float engineRX;
float engineRY;
float engineLX;
float engineLY;
float engineSize;
float engineWidth;
float engineHeight;
float capsuleWidth;
float capsuleHeight;
float cargoWidth;
float cargoHeight;
float engineCurve;
float landingLegPad;
ArrayList<Float> sparksX;
ArrayList<Float> sparksY;
ArrayList<Float> sparksLifeTime;

void falconMain(float x, float y) {
  background(0);
  engineRX = x - engineWidth * engineSize;
  engineRY = y - engineHeight * engineSize;
  engineLX = x + engineWidth * engineSize;
  engineLY = y - engineHeight * engineSize;
}
void setup() {
  size(500,500);
  engineSize = 1;
  engineHeight = 50;
  engineWidth = 10;
  capsuleWidth = engineWidth;
  capsuleHeight = engineHeight + 10 * engineSize;
  cargoWidth = capsuleWidth;
  cargoHeight = capsuleHeight * 0.25;
  x = 250.0 - engineWidth * engineSize / 2;
  y = 500.0;
  falconMain(x, y);
  engineCurve = 2;
  landingLegPad = 10 * engineSize;
  sparksX = new ArrayList<Float>();
  sparksY = new ArrayList<Float>();
  sparksLifeTime = new ArrayList<Float>();
  spd = 1;
  acceleration = 1.01;
}
void drawLandingLegs(float x, float y) {
  fill(220);
  noStroke();
  triangle(x + engineWidth * engineSize / 2 - (3 * engineSize), y + engineSize * engineHeight - landingLegPad, x + engineWidth * engineSize / 2 - (2 * engineSize), y + engineSize * (engineHeight + 10) - landingLegPad, x + engineWidth * engineSize / 2 - (5 * engineSize), y + engineSize * (engineHeight + 10) - landingLegPad);
  triangle(x + engineWidth * engineSize / 2 + (3 * engineSize), y + engineSize * engineHeight - landingLegPad, x + engineWidth * engineSize / 2 + (2 * engineSize), y + engineSize * (engineHeight + 10) - landingLegPad, x + engineWidth * engineSize / 2 + (5 * engineSize), y + engineSize * (engineHeight + 10) - landingLegPad);
}
void drawAngles(float x, float y) {
  fill(255);
  bezier(x, y, x, y - (engineHeight * 0.3 * engineSize),  x + engineWidth * engineSize , y - (engineHeight * 0.3 * engineSize),  x + engineWidth * engineSize, y);
}
void drawCargoAngles(float x, float y) {
  fill(255);
  y = y - capsuleHeight * engineSize - cargoHeight * engineSize;
  x = x - 4 * engineSize / 2;
  bezier(x, y, x, y - (cargoHeight * 0.7 * engineSize),  x + (cargoWidth + 4) * engineSize, y - (cargoHeight * 0.7 * engineSize),  x + (cargoWidth + 4) * engineSize, y);
  println("Curve is: " + (cargoWidth + 4) * engineSize);
}
void addSparks(float x, float y) {
  int count = 0;
  while(count < int(random(3))) {
    sparksX.add(x + random(10 * engineSize));
    sparksY.add(y + random(20 * engineSize));
    sparksLifeTime.add(0.0);
  }
}
void drawSparks() {
  int count = 0;
  while(count < sparksX.size()) {
    if(sparksLifeTime.get(count) > 10.0) {
      sparksX.remove(count);
      sparksY.remove(count);
      sparksLifeTime.remove(count);
    }
    fill(255, 152, 51);
    rect(sparksX.get(count), sparksY.get(count), 3 * engineSize, 3 * engineSize);
    float lifeTime = sparksLifeTime.get(count);
    sparksLifeTime.set(count, lifeTime + 1.0);
    count++;
  }
}
void drawEngines(float x, float y) {
  fill(255);
  stroke(1);
  rect(x,y, engineSize * engineWidth, engineSize * engineHeight);//engineCurve * engineSize);
  drawLandingLegs(x, y);
  drawAngles(x , y);
  addSparks(x, y + engineHeight * engineSize);
  drawSparks();
}
void drawLetters(float x, float y, String word) {
  y = y - capsuleHeight * engineSize;
  fill(0,0,255);
  textSize(5 * engineSize);
  int count = 0;
  float position = (capsuleHeight * engineSize - 10 * engineSize) / word.length();
  while(count < word.length()) {
    text(word.charAt(count), x + (capsuleWidth * engineSize - 3 * engineSize) / 2, y + 10 * engineSize + position * count);
    count++;
  }
}
void drawEngineWCapsule(float x, float y) {
  fill(255);
  stroke(1);
  rect(x,y - capsuleHeight * engineSize,engineSize * capsuleWidth, engineSize * capsuleHeight, engineCurve * engineSize);
  rect(x - 4 * engineSize / 2, y - capsuleHeight * engineSize - cargoHeight * engineSize, engineSize * (cargoWidth + 4), engineSize * cargoHeight);
  println("Capsule is: " + engineSize * (cargoWidth + 5));
  drawCargoAngles(x, y);
  drawLetters(x, y, "SpaceX");
}
void animateFalcon() {
  // Make Falcon Heavy fly.
  y += -spd;
  spd *= acceleration;
  falconMain(x, y);
  // Update Falcon Heavy.
  drawEngines(engineRX, engineRY);
  drawEngines(engineLX, engineLY);
  drawEngineWCapsule(x, y);
}
void draw() {
  animateFalcon();
}
