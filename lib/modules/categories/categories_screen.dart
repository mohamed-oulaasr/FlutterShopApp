// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/cubit/states.dart';
import 'package:flutter_shop_app/models/categories_model.dart';
import 'package:flutter_shop_app/modules/category_products/category_products_screen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/components/constants.dart';

class CategoriesScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    var shopCubit = ShopCubit.get(context)!;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: shopCubit.categoriesModel!.data!.data! != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
              shopCubit.categoriesModel!.data!.data![index],
              context,
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: shopCubit.categoriesModel!.data!.data!.length,
          ),
          fallback: (context) => Center(
              child: CircularProgressIndicator()
          ),
        );
      },
    );
  }

  Widget buildCatItem(CategoryModel categoryModel, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(
          image: NetworkImage(categoryModel.image!),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          categoryModel.name!,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
          ),
          onPressed: ()
          {
            categoryId = categoryModel.id!;

            navigateTo(
              context,
              CategoryProductsScreen(categoryId: categoryModel.id!),
            );
          },
        ),
      ],
    ),
  );

}
