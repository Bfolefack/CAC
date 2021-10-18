import processing.net.*;
import java.util.*;

Client c;
PImage img;
String name;
String data;
String guess;
boolean nameTyping = true;
boolean gameTyping = false;
String[] temp;

void setup()
{
  size(1200, 900);
  background(255);
  stroke(0);
  frameRate(5);
  fill(0);
  textSize(50);
  text("enter your name", 400, 300);
  c = new Client(this, "10.224.27.51", 1);
}

void keyTyped()
{
  if(nameTyping)
  {
    name += key;
    c.write(name);
  }
  else if(!gameTyping)
  {
    c.write(guess);
    gameTyping = true;
  }
  else if(gameTyping)
    guess += key;
}

void keyPressed()
{
  if(key == ENTER)
  {
    nameTyping = false;
    gameTyping = true;
  }
}

void draw()
{
  if(c.available() > 0)
  {
    data = c.readString();
    temp = data.split(" ");
    img = loadImage(temp[0]);
    image(img, 0, 0);
  }
}
