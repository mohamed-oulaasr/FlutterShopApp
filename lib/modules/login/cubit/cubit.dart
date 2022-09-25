// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/models/login_model.dart';
import 'package:flutter_shop_app/modules/login/cubit/states.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit? get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email' : email,
        'password' : password,
      },
    ).then((value) 
    {
      //print(value.data);
      //print(value.data['message']);
      loginModel = LoginModel.fromJson(value.data);
      // print('Status : ${loginModel.status}');
      // print('Message : ${loginModel.message}');
      // print('Token : ${loginModel.data!.token!}');

      emit(LoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());

      emit(LoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;

    //emit(LoginChangePasswordVisibilityState());
  }

}