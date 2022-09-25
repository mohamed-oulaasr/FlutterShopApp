// ignore_for_file: avoid_print, slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/login/login_screen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/network/local/cache_helper.dart';

const defaultColor = Colors.blue;

dynamic token = '';

int categoryId = 0;

Map<int, bool> favorites = {};

/**
 * Sign Out
 */
void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if(value)
    {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

/**
 * Print Full Text
 */
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');  // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));

}