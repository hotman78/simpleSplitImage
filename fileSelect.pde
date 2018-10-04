private final static int CHOSE_FILE_CODE = 12345; 
class FileSelect {
  void get() {
    Intent intent = new Intent(Intent.ACTION_GET_CONTENT); 
    intent.setType("file/*"); 
    getActivity().startActivityForResult(intent, CHOSE_FILE_CODE);
  }
}

void onActivityResult(int requestCode, int resultCode, Intent data) { 
  try { 
    if (requestCode == CHOSE_FILE_CODE && resultCode == Activity.RESULT_OK) { 
      String filePath = data.getDataString().replace("file://", ""); 
      decodedfilePath = URLDecoder.decode(filePath, "utf-8");
      et.setText(decodedfilePath);
    }
  } 
  catch (Exception e) {
    log("fileSelectError:"+e);
  }
}
