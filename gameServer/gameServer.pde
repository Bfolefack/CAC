import processing.net.*;
import java.util.*;

Client c;
Server s;
String input;
String answer;
String name;
String winner;
PImage image;
boolean running = false;
Map<Client,String> cMap = new HashMap<Client,String>();

void setup()
{
  String[] images = new String[]{};
  image = loadImage(images[(int)Math.random()*images.length]);
  size(1200, 900);
  background(255);
  stroke(0);
  frameRate(5);
  fill(0);
  textSize(50);
  text("enter your name", 400, 300);
  s = new Server(this, 1);
}

void draw()
{
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
