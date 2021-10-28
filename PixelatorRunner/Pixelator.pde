class Pixelator{
  PImage image;
  Pixelator(PImage p){
    image = p;
  }
  
  public PImage pixelate(float level){
    PImage out = image.copy();
    int ogLevel = (int)level;
    if(level > image.width || level > image.height){
      return image;
    } 
    if(level < 1){
      level = 1;
    }
      level = image.width/(level * image.width);
      for(int i = 0; i < image.width; i += image.width * level){
        for(int j = 0; j < image.height; j += image.height * level){
          int intWidth = (int) (image.width * level) + 1;
          int intHeight = (int) (image.height * level) + 1;
          float red = 0;
          float green = 0;
          float blue = 0;
          int[] pixels = image.get(i, j, intWidth, intHeight).pixels;
          for(int p : pixels){
            red += red(p);
            green += green(p);
            blue += blue(p);
          }
          red/=pixels.length; //<>//
          green/=pixels.length;
          blue/=pixels.length;
          color col = color(red, green, blue);
          PImage img = createImage(intWidth, intHeight, RGB);
          for(int ii = 0 ; ii < img.pixels.length; ii++){
            img.pixels[ii] = col;
          }
          out.copy(img, 0, 0, intWidth, intHeight, i, j, intWidth, intHeight);
        }
      }
      int crop = 20;
      out = out.get(crop, crop, out.width - crop * 2, out.height - crop * 2);
      return out;
  }
}
