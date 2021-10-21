import processing.net.*;
import java.util.*;
import java.net.InetAddress;
int port = (int) random(65535);
Server mainServer;
Client mainClient;
String gameState;
String imageListLocation;
String name;
String joinIP;
String joinPort;
boolean pKeyPressed;

ClientServer me;
Game game = this;

void setup() {
  size(800, 600);
  background(255);
  pushMatrix();
  pushStyle();
  noStroke();
  textSize(50);
  popStyle();
  popMatrix();
  textAlign(CENTER, CENTER);
  try {
    joinIP = InetAddress.getLocalHost().getHostAddress();
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
  joinPort = port + "";
  name = "";
  gameState = "name";
}

public void draw() {
  background(255);
  //println(gameState);
  switch(gameState) {
  case "name":
    fill(0);
    textSize(50);
    name = type(name);
    text("Enter your name:", width/2, height/3);
    text(name, width/2, height/2);
    break;
  case "init":
    //TODO: CONVERT TO UI ********************************************************************************************************************
    Button host=new Button(width/2-120,height/2-40,60,30,"Host");
    host.display();
    host.selected(mouseX,mouseY);
    if (keyPressed) {
      if (key == 'h') {
        mainServer = new Server(this, port);
        me = new ClientServer(true, name);
        gameState = "invite";
      } else if (key == 'p') {
        gameState = "codeIP";
        joinIP = "";
        joinPort = "";
        //mainClient = new Client(this, "10.224.29.54", port);
        //me = new ClientServer(false, name);
      }
    }
    break;
  case "invite":
    text(joinIP, width/2, height/3);
    text(joinPort, width/2, height/2);
    String str = "";
    for(String s : me.players()){
      str += s;
    }
    drawHost();
    break;
    //TODO: CREATE A SCREEN THAT SHOWS WHO IS IN THE GAME ********************************************************************************************************************
  case "codeIP":
    joinIP = type(joinIP);
    text("IP: " + joinIP, width/2, height/3);
    text("Port: " + joinPort, width/2, height/2);
    break;
  case "codePort":
    joinPort = type(joinPort);
    text("IP: " + joinIP, width/2, height/3);
    text("Port: " + joinPort, width/2, height/2);
    break;
  default:
    drawHost();
    drawPlayer();
  }
}

public String type(String s) {
  if (keyPressed && keyPressed != pKeyPressed) {
    if (key == BACKSPACE) {
      if (s.length() > 0) {
        s = s.substring(0, s.length() - 1);
      }
    } else if (key == ENTER) {
      delay(200);
      switch(gameState) {
      case "codeIP":
        gameState = "codePort";
        break;
      case "codePort":
        gameState = "" ;
        println("(" + joinIP + ")");
        mainClient = new Client(this, joinIP, Integer.parseInt(joinPort));
        println("done");
        me = new ClientServer(false, name);
        break;
      case "name":
        gameState = "init";
        break;
      }
    } else if (key != CODED) {
      s += key;
    }
  }
  pKeyPressed = keyPressed;
  if (keyCode == SHIFT) {
    pKeyPressed = false;
  }

  return s;
}

public void drawHost() {
  if(me.isHost){
    String str = "";
    for(String s : me.players()){
      str += s;
    }
    println(me.read());
    text(str, width/2, height/4);
  }
}


public void drawPlayer() {
  if(!me.isHost){
    text("name", width/2, height/2);
    me.write(name);
  }
}
