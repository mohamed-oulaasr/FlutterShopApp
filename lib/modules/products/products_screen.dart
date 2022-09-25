// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/cubit/states.dart';
import 'package:flutter_shop_app/models/categories_model.dart';
import 'package:flutter_shop_app/models/home_model.dart';
import 'package:flutter_shop_app/shared/components/components.dart';

class ProductsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavoritesState)
        {
          if(!state.changeFavoritesModel.status!)
          {
            showToast(
              text: state.changeFavoritesModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition: ShopCubit.get(context)!.homeModel != null && ShopCubit.get(context)!.categoriesModel != null,
          builder: (context) => builderWidget(ShopCubit.get(context)!.homeModel!, ShopCubit.get(context)!.categoriesModel!, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget builderWidget(HomeModel homeModel, CategoriesModel categoriesModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
          items: homeModel.data!.banners!.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data![index]),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10.0,
                  ),
                  itemCount: categoriesModel.data!.data!.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.66,
            children: List.generate(
              homeModel.data!.products!.length,
              (index) => buildGridProduct(homeModel.data!.products![index], context),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem(CategoryModel categoryModel) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:
      [
        Image(
          image: NetworkImage(categoryModel.image!),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(.8,),
          width: 100.0,
          child: Text(
            categoryModel.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ]
  );

}
