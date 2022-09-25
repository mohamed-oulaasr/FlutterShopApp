// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/layout/cubit/cubit.dart';
import 'package:flutter_shop_app/layout/cubit/states.dart';
import 'package:flutter_shop_app/modules/search/search_screen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var shopCubit = ShopCubit.get(context)!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'InstaShop',
            ),
            actions:
            [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: ()
                {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
              ),
            ],
          ),
          body: shopCubit.bottomScreens[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentIndex,
            onTap: (index)
            {
              shopCubit.changeBottom(index);
            },
            items:
            [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
