// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/cubit/states.dart';
import 'package:flutter_shop_app/models/favorites_model.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/components/constants.dart';

class FavoritesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState?,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context)!.favoritesModel!.data!.data![index].product!, context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context)!.favoritesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator()
          ),
        );
      },
    );
  }
}
