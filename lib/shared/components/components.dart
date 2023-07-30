

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/layout/News_app/Cubit/cubite.dart';
import 'package:my_app/layout/shop_app/cubite/cubite.dart';
import 'package:my_app/modules/news_app/web_view/web_view_screen.dart';
import 'package:my_app/shared/cubites/cubite.dart';
import 'package:my_app/shared/stayles/colores.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  bool isUpperCase= true,
  double radius= 10,
  required void Function()? function,
  required String text,
}) => Container(

  width: width,

  height: 40,

  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(radius),

    color: background,

  ),

  child: MaterialButton(

    onPressed:(){

      function!();

    },

    child:  Text(

      isUpperCase? text.toUpperCase():text,

      style:  const TextStyle(

        color: Colors.white,

      ),),



  ),

);


Widget defualtTextButton({
  required Function function,
  required String text
})=>TextButton(
   onPressed:(){

function();

}, child: Text(text.toUpperCase()));


Widget defaultFormField({
  required TextEditingController ? controller,
  Function(String val)? onSubmit,
  Function(String val)? onChanged,
  Function()? onTap,
  required  String? Function(String?)? validator,
  required String? label,
  required IconData? prefix,
  TextInputType? type,
  IconData? suffix,
  Function()? suffixpressed,
  bool isPassword= false,
  bool isClickable=true,
}) {
  return TextFormField(
    style: const TextStyle(
        decorationColor: Colors.blue
    ),
    controller: controller,
    obscureText: isPassword,
    onFieldSubmitted:onSubmit,
    onChanged: onChanged,
    onTap: onTap,
    enabled:isClickable,
    validator:validator,
    decoration: InputDecoration(
      labelText: label,

      border: const OutlineInputBorder(),
      prefixIcon:Icon(
          prefix
      ),
      suffixIcon: suffix != null? IconButton(
        onPressed: (){
          suffixpressed!();
        }, icon: Icon(suffix),
      ): null,
    ),
  );
}
Widget defualtAppBar({
  required BuildContext? context,
  String ? title,
  List<Widget> ?actions,
})=> AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context!);
    },
    icon: const Icon(
      Icons.arrow_back_outlined
    ),
  ),
  title: Text(
    title!,
  ),
  actions: actions,
);
Widget buildTaskItem( Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        CircleAvatar
          (
          radius: 40,
          child: Text(
              '${model['time']}'
          ),
        ),
        const SizedBox(
          width: 20,

        ),
        Expanded(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20,

        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateDatabase(
                  status: 'done',
                  id: model['id']);
            },
            icon: const Icon(Icons.check_box,
              color: Colors.green,)),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateDatabase(
                  status: 'archive',
                  id: model['id']);
            },
            icon: const Icon(Icons.archive,
              color: Colors.black45,))
      ],
    ),
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase(id: model ['id']);
  },
);

Widget tasksBuilder({
  required List<Map> tasks
})=> ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context) =>ListView.separated(
      itemBuilder: (context,index)=> buildTaskItem(tasks[index],context),
      separatorBuilder: (context,index)=> myDivider(),
      itemCount: tasks.length),
  fallback:(context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center
      ,
      children: const [
        Icon(
          Icons.menu,size: 100,
          color: Colors.grey,
        ),
        Text(
          'Not tasks yet please Add some tasks',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),

);


Widget  buildArticleItem(article, context,index) => Container(
  color: NewsCubit.get(context).businessSelectedItem[index] ?Colors.grey[200] : null,
  child:   InkWell(

    onTap: ()

    {

      //navigateTo(context, WebViewScreen(article['url']));
      NewsCubit.get(context).selectBusinessItem(index);
    },

    child: Padding(

      padding: const EdgeInsets.all(20),

      child: Row(

        children: [

          Container(

            width: 120,

            height: 120,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),

                image:  DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover,



                )

            ),

          ),

          const SizedBox(

            width: 20,

          ),

          Expanded(

            child: Container(

              height: 120,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.start,

                children: [

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

                    style: const TextStyle(

                        color: Colors.grey

                    ),

                  ),

                ],

              ),

            ),

          ),

        ],

      ),

    ),

  ),
);

Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(
      start:20),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list,context, {isSearch=false})=>  ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=> ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context,index) =>buildArticleItem(list[index],context,index),
    separatorBuilder: (context,index)=> myDivider(),
    itemCount: 10,
  ),
  fallback: (context) => const Center(
    child: CircularProgressIndicator(

    ),
  ),
);

void navigateTo(context,widget) =>   Navigator.push(context,
  MaterialPageRoute(
    builder:(context)=> widget,
  ),
);

void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context)=> widget),
      (rout)=> false,
);

void showToast({
  required String text,
  required ToastStates state
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToastStates{SUCCESS, ERROR,WARNING}
Color ? chooseToastColor(ToastStates state){
  switch(state) {
    case ToastStates.SUCCESS:
      return Colors.green;
      break;
    case ToastStates.ERROR:
      return Colors.red;
      break;
    case ToastStates.WARNING:
      return Colors.amber;
      break;
  }
}
Widget buildListProduct(model,context,{bool isOldPrice=true})=> Padding(
  padding: const EdgeInsets.all(20),
  child: Container(
    height: 120,
    child: Row(

      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image!),
              height: 120,
              width:120,
              fit: BoxFit.cover,
            ),
            if(model.discount!=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                    horizontal: 5
                ),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),
                ),
              )
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price!.toString() ,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: defualtColor,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if(model.discount !=0&& isOldPrice)
                    Text(
                      model.oldPrice!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavourites(model.id!);
                        print(model.id);
                      },
                      icon:  CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favourite![model.id!]! ? defualtColor: Colors.grey ,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: Colors.white,
                        ),
                        radius: 15,
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);