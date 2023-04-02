import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/local_data_model/cart_item_model.dart';
import 'package:task/data/local_database/new_db.dart';
import 'package:task/data/model/post_model.dart';
import 'package:task/data/repo/post_repo.dart';
import 'package:task/logic/cubit/products_cubit/products_state.dart';
class ProductCubit extends Cubit<ProductsState>{
  ProductCubit() : super( ProductsLoadingState() ){
    fetchData();
  }

  PostRepository postRepository = PostRepository();
  int pageCount = 1;
  ItemData? itemData;

  List<CartProductItemData> cartProductItemData = [];

  void fetchData() async {
    try{
      ItemData? itemData = await postRepository.fetchItem();
      emit(ProductsLoadedState(itemData));
    }catch(ex){
      emit(ProductErrorsState(ex.toString()));
    }
  }

  void fetchItemPaggination() async {
    try{
      itemData = await postRepository.fetchItemPaggination(pageCount);
      pageCount++;
      emit(ProductsLoadedState(itemData));
    }catch(ex){
      emit(ProductErrorsState(ex.toString()));
    }
  }


  Future<bool> addToCart({int? id , String? title , String? image, int? price , String? dis,String? slug}) async {
    cartProductItemData.add(CartProductItemData(id:id , title: title , featuredImage: image,price: price,description: dis,slug: "",createdAt: "",status: ""));
    var data =  await DataBase().insertCartItem(cartProductItemData);
    return  data !=0;
  }


}