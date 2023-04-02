import 'package:task/data/model/post_model.dart';

abstract class ProductsState{}

class ProductsLoadingState extends ProductsState{}

class ProductsLoadedState extends ProductsState{
   ItemData? itemData;
   ProductsLoadedState(this.itemData);
}

class ProductErrorsState extends ProductsState{
  String? error;
  ProductErrorsState(this.error);
}

class ProductAddState extends ProductsState{
  List cartProductItemData;
  ProductAddState(this.cartProductItemData);
}