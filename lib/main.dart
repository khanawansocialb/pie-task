import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_task/cart/cubit/cart_cubit.dart';
import 'package:pie_task/config/app_size.dart';
import 'package:pie_task/config/routes.dart';
import 'package:pie_task/home/cubit/products_cubit.dart';
import 'package:pie_task/home/service/product_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.appHeight = MediaQuery.of(context).size.height;
    AppSize.appWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ProductsCubit(productService: ProductService())),
          BlocProvider(create: (context) => CartCubit()),
        ],
        child: const MaterialApp(
          onGenerateRoute: Routes.generateRoutes,
        ));
  }
}
