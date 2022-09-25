// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/category_products_model.dart';
import 'package:flutter_shop_app/modules/category_products/cubit/states.dart';
import 'package:flutter_shop_app/shared/components/constants.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/end_points.dart';

class GetProductsCubit extends Cubit<GetProductsStates>
{
  GetProductsCubit() : super(GetProductsInitialState());

  static GetProductsCubit? get(context) => BlocProvider.of(context);

  CategoryProductsModel? categoryProductsModel;

  void getProducts({
    required int categoryId
  })
  {
    emit(GetProductsLoadingState());

    DioHelper.getData(
      url: GET_CATEGORY_PRODUCTS,
      query:
      {
        'category_id' : categoryId,
      },
      token: token,
    ).then((value)
    {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);

      printFullText(categoryProductsModel!.data!.products!.toString());

      categoryProductsModel!.data!.products!.forEach((element)
      {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      emit(GetProductsSuccessState());

    }).catchError((error) {
      print(error.toString());

      emit(GetProductsErrorState());
    });
  }
}