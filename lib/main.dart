import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/model/post_model.dart';
import 'package:task/data/repo/post_repo.dart';
import 'package:task/logic/cubit/products_cubit/products_cubit.dart';
import 'package:task/presentation/products_screen.dart';

import 'data/local_database/new_db.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DataBase handler;
  @override
  void initState() {
    handler = DataBase();
    handler.initializedDB().whenComplete(() async {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductScreen(),));
  }
}
