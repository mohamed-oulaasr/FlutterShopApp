// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, constant_identifier_names, prefer_is_empty, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/layout/cubit/cubit.dart';
import 'package:flutter_shop_app/modules/category_products/cubit/cubit.dart';
import 'package:flutter_shop_app/shared/components/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

// reusable components :

// 1. timing
// 2. refactor
// 3. quality
// 4. clean code

Widget defaultButton ({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double border = 10.0,
  required VoidCallback? function,
  required String text,
}) => Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
          color: Colors.white
      ),
    ),
  ),
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(
        border
    ),
  ),
);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
          text.toUpperCase(),
      ),
    );

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix
    ),
    suffixIcon: suffix != null ? IconButton(
      icon: Icon(
        suffix,
      ),
      onPressed: suffixPressed!(),
    )
    : null,
    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model, context) =>  Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
          onPressed: ()
          {
            // AppCubit.get(context).updateData(
            //   status: 'done',
            //   id: model['id'],
            // );
          },
          icon: Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ),
        IconButton(
          onPressed: ()
          {
            // AppCubit.get(context).updateData(
            //   status: 'archive',
            //   id: model['id'],
            // );
          },
          icon: Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction)
  {
    //AppCubit.get(context).deleteData(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: ()
  {
    // navigateTo(
    //   context,
    //   WebViewScreen(article['url']),
    // );
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0,),
            image: DecorationImage(
              image: NetworkImage(
                '${article['urlToImage']}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(
         list,
         context,
         {isSearch = false}
       )
=> ConditionalBuilder(
     condition: list.length > 0,
     builder: (context) => ListView.separated(
       physics: BouncingScrollPhysics(),
       itemBuilder: (context, index) => buildArticleItem(list[index], context),
       separatorBuilder: (context, index) => myDivider(),
       itemCount: list.length,
     ),
     fallback: (context) => isSearch ? Container(): Center(child: CircularProgressIndicator()),
   );

void navigateTo(
       context,
       widget,
     )
=> Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => widget,
     ),
   );

void navigateAndFinish(
       context,
       widget,
     )
=> Navigator.pushAndRemoveUntil(
     context,
     MaterialPageRoute(
       builder: (context) => widget,
     ),
     (Route<dynamic> route)
     {
       return false;
     },
   );

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildGridProduct(productModel, context) =>  Container(
  color: Colors.white,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(productModel.image!),
            width: double.infinity,
            height: 160.0,
          ),
          if(productModel.discount != 0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productModel.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),
            ),
            Row(
              children:
              [
                Text(
                  '${productModel.price.round()}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: defaultColor,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if(productModel.discount != 0)
                  Text(
                    '${productModel.oldPrice.round()}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                  onPressed: ()
                  {
                    ShopCubit.get(context)!.changeFavorites(productModel.id!);

                    GetProductsCubit.get(context)!.getProducts(categoryId: categoryId);

                    //print(productModel.id);
                  },
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: favorites[productModel.id]! ? defaultColor : Colors.grey,
                    child: Icon(
                      Icons.favorite_border,
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget buildListProduct(
  product,
  context,
  {bool isOldPrice = true,}
)
=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
              image: NetworkImage(product.image!),
              width: 120.0,
              height: 120.0,
            ),
            if(product.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children:
                [
                  Text(
                    product.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(product.discount != 0 && isOldPrice)
                    Text(
                      product.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context)!.changeFavorites(product.id!);

                      GetProductsCubit.get(context)!.getProducts(categoryId: categoryId);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                      favorites[product.id]!
                          ? defaultColor
                          : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

