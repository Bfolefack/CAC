import processing.net.*;
import java.util.*;

Client c;
Server s;
String input;
String imgName;
String answer;
String name;
String winner;
PImage img;
boolean running = false;
Map<Client,String> cMap = new HashMap<Client,String>();

void setup()
{
  String[] images = new String[]{}; //add filenames for images and names
  int index = (int)Math.random()*images.length;
  String[] temp = images[index].split(" ");
  img = loadImage(temp[0]);
  imgName = temp[1];
  size(1200, 900);
  background(255);
  stroke(0);
  frameRate(5);
  fill(0);
  textSize(50);
  text("enter your name", 400, 300);
  s = new Server(this, 1); //make code to find a port instead of having it always be "1"
}

void draw()
{
  image(img, 0, 0);
  
  if(!running)
  {
    c = s.available();
    if(c != null)
    {
      name = c.readString();
      cMap.put(c, name);
    }
  }
  if(running)
  {
    
    c = s.available();
    if(c != null)
    {
      input = c.readString();
      if(input==answer);
      {
        winner = cMap.get(c);
        end();
        noLoop();
      }
    }
  }
}

void end()
{
  background(255);
  fill(0);
  textSize(50);
  text("Winner: " + winner, 400, 300);
}
