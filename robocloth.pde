import themidibus.*;

MidiBus myBus; 
PVector boxCenter;
float boxSize = 20;

void setup() {
  size(800, 600);
  smooth();
  myBus = new MidiBus(this, 0, -1);
  boxCenter = new PVector(0, 0);
}

void draw() {
  background(255);
  rectMode(CENTER);
  noStroke();
  fill(0);
  rect(boxCenter.x, boxCenter.y, boxSize, boxSize);
}

void recvXKnobChange(float n) {
  if (boxCenter == null) {
    return;
  }
  boxCenter.x = lerp(width, 0, n);  
}

void recvYKnobChange(float n) {
  if (boxCenter == null) {
    return;
  }
  boxCenter.y = lerp(height, 0, n);
}

void controllerChange(int channel, int number, int value) {
  float n = norm(value, 0, 127);
  switch (number) {
  case 10:
    recvXKnobChange(n);
    break;
  case 11:
    recvYKnobChange(n);
    break;
  default:
    background(255, 0, 0);
    println("<ERROR unexpected control change. " + " channel:" + channel + " number:" + number + " n:" + n + ">");
  }
}

void rawMidi(byte[] data) { // You can also use rawMidi(byte[] data, String bus_name)
  int status = (int)(data[0] & 0xFF);
  switch (status) {
  case 176: // breath velocity
    return;
  }
}

