Pixelator image;

public void setup(){
  size(1000, 700);
  PImage img = loadImage("dog.png");
  img.resize(720, 0);
  image = new Pixelator(img);
  image(img, 0, 0);
}

public void draw(){
  background(255);
  image(image.pixelate(mouseX/2), 0, 0);
  println(frameCount);
}
