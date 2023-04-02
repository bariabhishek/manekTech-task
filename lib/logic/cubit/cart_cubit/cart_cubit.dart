import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/local_data_model/cart_item_model.dart';
import 'package:task/data/local_database/new_db.dart';
import 'package:task/logic/cubit/cart_cubit/cart_state.dart';

class CartCubit extends Cubit<CartState>{
  CartCubit() : super(DataLoadingState()){
    getLocalCartData();
  }
  List<CartProductItemData>? list;
  DataBase handler = DataBase();


  void getLocalCartData() async {
    list = await handler.retrieveCartItem();
    print(list);
    emit(DataLoadedState(list));
  }

}