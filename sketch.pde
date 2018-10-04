import android.content.Intent;
import android.app.Activity;
import android.text.InputType;
import java.net.URLDecoder;
import android.view.*;
import android.widget.*;
import android.widget.TextView.BufferType;
import android.webkit.WebView; 
import android.webkit.WebViewClient;
String decodedfilePath="";
String directory=Environment.getExternalStorageDirectory() + "/" + Environment.DIRECTORY_PICTURES + "/SimpleSplitImage";
boolean UISettingCompleated;
EditText et,et1,et2;
TextView log;
View surfaceView;
import android.widget.Button;
FileSelect fs=new FileSelect();
Output o=new Output();
FrameLayout fl;

FrameLayout.LayoutParams getLP(int x,int y,int w,int h){
  FrameLayout.LayoutParams lp = new FrameLayout.LayoutParams(w,h); 
  lp.leftMargin = x;
  lp.topMargin = y; 
  return lp;
}
void draw() {
}
@Override
public void onPause() {
  super.onPause();
  
}
void onResume(){
  super.onResume();
  UISettingCompleated=false;
  runOnUiThread(new Runnable() {
    public void run() {
      setUI();
      UISettingCompleated=true;
    }
  });
  for(;;){
    if(UISettingCompleated)break;
    try{Thread.sleep(1);}catch(InterruptedException e){println(e);}
  }
}
void setup() {
  UISettingCompleated=false;
  runOnUiThread(new Runnable() {
    public void run() {
      settingSurface();
      addSelectButton();
      addURLSetter();
      addEditText();
      addOutputButton();
      addLog();
      addAd();
      UISettingCompleated=true;
    }
  });
  for(;;){
    if(UISettingCompleated)break;
    try{Thread.sleep(1);}catch(InterruptedException e){println(e);}
  }
  log("保存先:"+directory);
}
void setUI() { 
  getSurface().getSurfaceView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE);
  //getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
}

void settingSurface() {
  fl=new FrameLayout(getContext());
  surfaceView=getSurface().getSurfaceView(); 
  ViewGroup parent=(ViewGroup)surfaceView.getParent(); 
  parent.removeView(surfaceView); 
  parent.addView(fl); 
  fl.addView(surfaceView);
}
void addSelectButton(){
  Button select=new Button(getContext());
  select.setText("選択");
  select.setOnClickListener(new View.OnClickListener() { 
    public void onClick(View v) {
      fs.get();
    } 
  });
  fl.addView(select,getLP(0,0,width,200));
}void addURLSetter(){
  et=new EditText(getContext());
  et.setHint("ファイルパス");
  fl.addView(et,getLP(0,200,width,200));
}
void addEditText(){
  et1=new EditText(getContext());
  et2=new EditText(getContext());
  et1.setInputType(InputType.TYPE_CLASS_NUMBER);
  et2.setInputType(InputType.TYPE_CLASS_NUMBER);
  et1.setHint("横分割数");
  et2.setHint("縦分割数");
  fl.addView(et1,getLP(0,400,width/2,200));
  fl.addView(et2,getLP(width/2,400,width/2,200));
  
}
void addOutputButton(){
  Button output=new Button(getContext());
  output.setText("出力");
  output.setOnClickListener(new View.OnClickListener() { 
    public void onClick(View v) {
      o.permissionRequest();
    } 
  });
  fl.addView(output,getLP(0,600,width,200));
}
void addLog(){
  log=new TextView(getContext());
  log.setTextIsSelectable(true);
  fl.addView(log,getLP(0,800,width,height-800-width*5/32));
}

void addAd(){
  WebView ad=new WebView(getContext());
  ad.setBackgroundColor(#000000);
  ad.loadUrl("file:///android_asset/ad.html"); 
  ad.getSettings().setJavaScriptEnabled(true);
  fl.addView(ad,getLP(0,height-width*5/32,width,width*5/32));
}
void log(String text){
  log.setText(log.getText()+"\n"+text);
}