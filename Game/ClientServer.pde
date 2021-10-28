import java.util.*;

public class ClientServer {
  boolean isHost;
  String gameState;
  String answer;
  ArrayList<String> players;
  Map<Client, String>  clientMap;
  Map<String, Integer> unusedLetters;
  int port = 12345;
  Client client;
  Server server;
  ClientServer(boolean b) {
    if (b) {
      isHost = true;
      clientMap = new HashMap<Client, String>();
      players = new ArrayList<String>();
      server = mainServer;
    } else {
      isHost = false;
      client = mainClient;
    }
  }

  public String read() {
    if (isHost) {
      Client client;
      client = server.available();
      if (client != null)
      {
        if(clientMap.keySet().contains(client)){
          String s = parseInput(client.readString()); //<>//
          println(s);
          clientMap.put(client, s); //<>//
          return s;
        } else {
          String s = parseInput(client.readString());
          clientMap.put(client, "");
          players.add(s);
        }
      }
    } else {
      String s = client.readString();
      return s;
    }
    return null;
  }
  
  public void write(String s){
    if(isHost){
      server.write(s);
    } else {
      try{
        client.write(s);
      } catch (Exception e){
        println(e);
        e.printStackTrace();
      }
    }
  }
  
  public String encodeOutput(){
    return null;
  }
  
  public String parseInput(String in){
    if(in.indexOf("/m") == 0){
      return in.substring(2, in.length());
    }
    return null;
  }
}
