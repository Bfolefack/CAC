import java.util.*;

public class ClientServer {
  boolean isHost;
  String gameState;
  String name;
  ArrayList players;
  Map<Client,String>  clientMap = new HashMap<Client,String>();
  int port = 12345;
  Client client;
  Server server;
  ClientServer(boolean b, String name) {
    if (b) {
      isHost = true;
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
        String s = client.readString();
        println(s);
        clientMap.put(client, s);
        return s;
      }
    } else {
      String s = client.readString();
      return s;
    }
    return null;
  }
  
  public Collection<String> players(){
    if(isHost){
      return clientMap.values();
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
        printnln(e);
        e.printStackTrace();
      }
    }
  }
}
