import 'package:task/data/local_data_model/cart_item_model.dart';

abstract class CartState{}

class DataLoadingState extends CartState{}

class DataLoadedState extends CartState{
  List<CartProductItemData>? list;
  DataLoadedState(this.list);
}