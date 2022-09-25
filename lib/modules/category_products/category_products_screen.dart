// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, prefer_const_constructors_in_immutables, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/category_products/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/category_products/cubit/states.dart';
import 'package:flutter_shop_app/shared/components/components.dart';


class CategoryProductsScreen extends StatelessWidget
{
  final int categoryId;

  CategoryProductsScreen({required this.categoryId});

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => GetProductsCubit()..getProducts(categoryId: categoryId),
      child: BlocConsumer<GetProductsCubit, GetProductsStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          var getProductsCubit = GetProductsCubit.get(context)!;

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Products',
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! GetProductsLoadingState,
                builder: (context) => Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.75,
                    children: List.generate(
                      getProductsCubit.categoryProductsModel!.data!.products!.length,
                      (index) => buildGridProduct(getProductsCubit.categoryProductsModel!.data!.products![index], context),
                    ),
                  ),
                ),
                fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                ),
              ),
          );
        },
      ),
    );
  }

}