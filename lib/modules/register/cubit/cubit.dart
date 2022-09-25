// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/register/cubit/states.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit? get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  })
  {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name' : name,
        'email' : email,
        'phone' : phone,
        'password' : password,
      },
    ).then((value) 
    {
      //print(value.data);

      loginModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());

      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void registerChangePasswordVisibility()
  {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    //emit(RegisterChangePasswordVisibilityState());
  }

}