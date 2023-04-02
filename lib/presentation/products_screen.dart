import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:task/data/model/post_model.dart';
import 'package:task/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:task/logic/cubit/products_cubit/products_cubit.dart';
import 'package:task/logic/cubit/products_cubit/products_state.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
   ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
   BlocProvider.of<ProductCubit>(context).fetchItemPaggination();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4.5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shoping Mall"),
        actions:  [
           InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> BlocProvider(create: (context)=> CartCubit(),child: const CartScreen(),)));
           }, child: const Padding(
             padding:  EdgeInsets.only(right: 8.0),
             child:  Icon(Icons.shopping_cart),
           ))
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ProductCubit,ProductsState>(
          builder: (context, state){
            if(state is ProductsLoadingState){
              return  const Center(child: CircularProgressIndicator(),);
            }
            if(state is ProductsLoadedState ){
              return   SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                header: const WaterDropHeader(),
                enablePullUp: true,
                enablePullDown: true,
                child: GridView.builder(
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (itemWidth / itemHeight),
                    ),
                    itemCount: state.itemData!.data!.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context , int index){
                  return itemUi(state.itemData!.data![index],context,index);
                }),
              );
            }

            return const Text("An Error Occured!");
          },
        ),
      )
    );
  }

  Widget itemUi(ProductItemData data, BuildContext context, int index) {

    return Card(
        color: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
    ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: "${data.featuredImage}",
              fit: BoxFit.contain,
              height: 100,
              width: 200,
              placeholder: (context, url) => const Center(child:  CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  Expanded(child: Text("${data.title}",maxLines: 3,)),
                  InkWell(
                      onTap: () async {
                       bool res = await BlocProvider.of<ProductCubit>(context).addToCart(price: data.price,title: data.title,id: data.id,image: data.featuredImage);
                       const snackBar =  SnackBar(
                         content: Text('Product added to Item'),
                       );
                       if(res) ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Icon(Icons.shopping_cart,color: Colors.black45,))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
