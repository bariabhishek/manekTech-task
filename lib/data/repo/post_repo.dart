import 'dart:convert';
import 'dart:developer';
import 'package:task/data/model/post_model.dart';
import 'package:task/data/repo/api.dart';

class PostRepository{

  API api = API();

  Future<ItemData?> fetchItem() async {
    try{
     var response = await api.sendRequest.post("product_list.php",data: {
        "page": 1,
        "perPage": 5
      });
      return ItemData.fromJson(jsonDecode(response.data));
    }catch(cx){
      print(cx);
      return null;
    }
  }
  Future<ItemData?> fetchItemPaggination(int page) async {
    try{
     var response = await api.sendRequest.post("product_list.php",data: {
        "page": page,
        "perPage": 5
      });
      return ItemData.fromJson(jsonDecode(response.data));
    }catch(cx){
      print(cx);
      return null;
    }
  }
}