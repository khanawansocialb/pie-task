import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_task/cart/cubit/cart_cubit.dart';
import 'package:pie_task/config/app_size.dart';
import 'package:pie_task/config/routes.dart';
import 'package:pie_task/home/cubit/products_cubit.dart';
import 'package:pie_task/home/service/product_service.dart';
import 'package:pie_task/user/service/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _userService.setUserStatus(UserStatus.online);
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _userService.setUserStatus(UserStatus.away);
    } else if (state == AppLifecycleState.detached) {
      _userService.setUserStatus(UserStatus.offline);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize.appHeight = MediaQuery.of(context).size.height;
    AppSize.appWidth = MediaQuery.of(context).size.width;
    AppSize.isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
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
