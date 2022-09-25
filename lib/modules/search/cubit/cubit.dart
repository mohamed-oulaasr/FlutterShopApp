// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/search_model.dart';
import 'package:flutter_shop_app/modules/search/cubit/states.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/end_points.dart';


class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit? get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      //token: token,
      data:
      {
        'text' : text,
      },
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());

    }).catchError((error)
    {
      print(error.toString());

      emit(SearchErrorState());
    });

  }




}