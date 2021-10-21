class Button{
  ///INSTANCE VARIABLES
  float x,y; //position
  float w,h; //size
  boolean selected; //is the button selected / on? true/false
  color selectedColor, defaultColor, currentColor;
  String label; 
  ///CONSTRUCTORS - no return type declared - match Class-name
  Button(float x, float y, float w, float h, String label ){
    this.x = x-w/2;
    this.y = y-h/2;
    this.w = w;
    this.h = h;
    this.label = label;
    selected = false;
    selectedColor = color( 280, 100, 100); ///must be HSB color
    defaultColor = color( 280, 70, 70); //slightly darker?
    currentColor = defaultColor; 
  }
  void display(){
    fill( currentColor);
    rect( x, y, w, h);
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text(label, x + w/2, y+7 + (h/2));
  }
  void selected( int mx, int my){
    if(mx>x && mx<x+w && my>y && my<y+h){
      selected=!selected;
      if(selected)
        currentColor=selectedColor;
      else
        currentColor=defaultColor;
    }
  }
    //if( mx > x && mx < x + w  && my > y && my < y+h){
    //  selected = !selected;  //toggle the value between true and false
    //  if(selected){
    //      currentColor = selectedColor;
    //  }else{
    //      currentColor = defaultColor;
    //  }
    //}
}
