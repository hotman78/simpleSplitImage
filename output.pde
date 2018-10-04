import android.os.Environment;
import java.util.Calendar;
import java.text.SimpleDateFormat;
class Output{
  void permissionRequest(){
    if (!hasPermission("android.permission.WRITE_EXTERNAL_STORAGE"))requestPermission("android.permission.WRITE_EXTERNAL_STORAGE", "initLocation");
    else output();
  }
  void output(){
    try{
      if (!hasPermission("android.permission.WRITE_EXTERNAL_STORAGE"))return;
      Calendar cal = Calendar.getInstance();
      SimpleDateFormat sdf = new SimpleDateFormat("/yyyyMMddHHmmss");
      String time=sdf.format(cal.getTime());
      File dir = new File(directory+time);
      if(!dir.exists())dir.mkdir();
      PImage img=loadImage(et.getText().toString());
      int splitX=parseInt(et1.getText().toString());
      int splitY=parseInt(et2.getText().toString());
      PImage[][] outputImg=new PImage[splitX][splitY];
      for(int i=0;i<splitX;i++)for(int j=0;j<splitY;j++){
        outputImg[i][j]=img.get((int)img.width*i/splitX,(int)img.height*j/splitY,(int)img.width/splitX,(int)img.height/splitY);
        outputImg[i][j].save(directory+time+"/img"+(i+j*splitX)+".png");
      }
      log("出力しました");
    }catch(Exception e){
      log("outputError:"+e);
    }
  }
}
void initLocation(boolean granted){
  if (granted) {
    log("パーミッションを取得しました");
    o.output();
  }else{
    log("パーミッションを取得出来ませんでした");
  }
}