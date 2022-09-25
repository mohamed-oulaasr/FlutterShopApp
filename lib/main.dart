// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, unnecessary_null_comparison, curly_braces_in_flow_control_structures, unnecessary_null_in_if_null_operators, unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/home_layout.dart';
import 'package:flutter_shop_app/modules/login/login_screen.dart';
import 'package:flutter_shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:flutter_shop_app/shared/bloc_observer.dart';
import 'package:flutter_shop_app/shared/components/constants.dart';
import 'package:flutter_shop_app/shared/cubit/cubit.dart';
import 'package:flutter_shop_app/shared/cubit/states.dart';
import 'package:flutter_shop_app/shared/network/local/cache_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/styles/themes.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async
{
  // kait2kd blli kolchi t executa mn b3ed kai ft7 app f runApp(MyApp)
  WidgetsFlutterBinding.ensureInitialized();

  // https Certificate
  HttpOverrides.global = new MyHttpOverrides();

  // Bloc Observer
  Bloc.observer = MyBlocObserver();

  // Dio Helper
  DioHelper.init();

  // Cache Helper
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;   // for Null Safety

  Widget? widget;

  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding') ?? null;   // for Null Safety
  token = CacheHelper.getData(key: 'token') ?? null;   // for Null Safety

  if(onBoarding != null)
  {
    if(token != null)
      widget = HomeLayout();
    else
      widget = LoginScreen();
  }
  else
  {
    widget = OnBoardingScreen();
  }

  //print('This is onBoarding : $onBoarding');

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));

}

class MyApp extends StatelessWidget
{
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()
          ..changeAppMode(
              fromShared: isDark
          )
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'InstaShop',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}


