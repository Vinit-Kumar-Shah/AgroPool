import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
class GetResponse{
  static Future<dynamic> getRequest(String url) async{
    http.Response response=await http.get(Uri.parse(url));
    try{
      if(response.statusCode==200){
        String data = response.body;
        var decodedData=jsonDecode(data);
        return decodedData;
      }
      else{
        return "Failed.";
      }
    }
    catch(exp){
      return "Failed.";
    }
  }
}