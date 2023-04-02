import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/local_data_model/cart_item_model.dart';
import 'package:task/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:task/logic/cubit/cart_cubit/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart"),centerTitle: true,),
      body: BlocBuilder<CartCubit,CartState>(
        builder: (context,state){
          if(state is DataLoadingState){
            return const CircularProgressIndicator();
          }
          if(state is DataLoadedState){
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.list!.length,
                      itemBuilder: (BuildContext context , int index){
                        return buildCartItemList(state.list![index],context,state);
                      }),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                  color: Colors.lightBlue[200],
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text("Total Items : "),
                          Text("${state.list!.length}"),
                        ],
                      ),
                      Row(
                        children: [
                          const Text("Grand Total : ₹"),
                          Text(totalPrice(state.list!)),
                        ],
                      ),
                    ],
                  ),
                )

              ],
            );
          }
          return const Text("An error jkndrg");
        },
      )



    );
  }

  Widget buildCartItemList(CartProductItemData list, BuildContext context, DataLoadedState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: "${list.featuredImage}",
          fit: BoxFit.cover,
          height: 100,
          placeholder: (context, url) => const Center(child:  CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text("${list.title}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400),)),
                    IconButton(onPressed: (){
                      BlocProvider.of<CartCubit>(context).handler.deleteCartItem(list.id!);
                      BlocProvider.of<CartCubit>(context).getLocalCartData();
                    }, icon: const Icon(Icons.delete))

                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Price"),
                    Text("₹ ${list.price}"),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                     Text("Quantity"),
                     Text("1"),
                  ],
                ),
              ],
            ),
          ),
        ),
        ],
    );
  }

  String totalPrice(List<CartProductItemData> itemList){
    double totalAmount = 0.0;

    itemList.forEach((element) {
      totalAmount = totalAmount+element.price!.toDouble();
    });
    return totalAmount.toString();
  }
}
