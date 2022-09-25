// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/cubit/states.dart';
import 'package:flutter_shop_app/models/categories_model.dart';
import 'package:flutter_shop_app/models/change_favorites_model.dart';
import 'package:flutter_shop_app/models/favorites_model.dart';
import 'package:flutter_shop_app/models/home_model.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/categories/categories_screen.dart';
import 'package:flutter_shop_app/modules/category_products/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/favorites/favorites_screen.dart';
import 'package:flutter_shop_app/modules/products/products_screen.dart';
import 'package:flutter_shop_app/modules/settings/settings_screen.dart';
import 'package:flutter_shop_app/shared/components/constants.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit? get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element)
      {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      //print(favorites.toString());

      //printFullText(homeModel!.data!.banners![0].image!);
      //print(homeModel!.status!);

      //printFullText(value.data.toString());

      emit(ShopSuccessHomeDataState());

    }).catchError((error)
    {
      print(error.toString());

      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories()
  {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());

    }).catchError((error)
    {
      print(error.toString());

      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data:
      {
        'product_id' : productId,
      },
      token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      //print(value.data);

      if(!changeFavoritesModel!.status!)
      {
        favorites[productId] = !favorites[productId]!;
      }
      else
      {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);

      //printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());

    }).catchError((error)
    {
      print(error.toString());

      emit(ShopErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel = LoginModel.fromJson(value.data);

      //printFullText(userModel!.data!.name!);

      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error)
    {
      print(error.toString());

      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  })
  {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name'  : name,
        'email' : email,
        'phone' : phone,
      }
    ).then((value)
    {
      userModel = LoginModel.fromJson(value.data);

      //printFullText(userModel!.data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));

    }).catchError((error)
    {
      print(error.toString());

      emit(ShopErrorUpdateUserState());
    });
  }



}