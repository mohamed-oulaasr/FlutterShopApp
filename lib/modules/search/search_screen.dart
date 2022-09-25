// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/search/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/search/cubit/states.dart';
import 'package:flutter_shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'enter text to search';
                        }

                        return null;
                      },
                      onSubmit: (text)
                      {
                        SearchCubit.get(context)!.search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context)!.searchModel!.data!.data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)!.searchModel!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
