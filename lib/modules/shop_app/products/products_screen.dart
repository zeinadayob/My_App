
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/shop_app/cubite/cubite.dart';
import 'package:my_app/layout/shop_app/cubite/state.dart';
import 'package:my_app/models/shop_model/categories_model.dart';
import 'package:my_app/models/shop_model/home_model.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/stayles/colores.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state)
      {
        if(state is ShopSuccessChangeFavouritesState)
        {
          if(!state.model.status!)
          {
            showToast(
                text: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context,state){
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&  ShopCubit.get(context).categoriesModel != null,
          builder:(context) => productsBuilder (ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!,context ),
          fallback:(context) =>   Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
  Widget productsBuilder (HomeModel model,CategoriesModel categoriesModel, context)=> SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data!.banners.map((e) =>
              Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
          ).toList(),
          options: CarouselOptions(
            height: 250,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data![index],context),
                  separatorBuilder:(context,index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: categoriesModel.data!.data!.length,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1/1.7,
            children: List.generate(
                model.data!.products.length,
                    (index) =>buildGridProduct(model.data!.products[index],context)),
          ),
        ),
      ],
    ),
  );
  Widget buildGridProduct(ProductModel model,context  ) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image:NetworkImage(model.image!),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount !=0)
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
        Padding(
          padding: const EdgeInsets.all(10),
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
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
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
                  if(model.discount!=0)
                    Text(
                      '${model.oldPrice.round()}',
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
                        backgroundColor: ShopCubit.get(context).favourite![model.id]! ? defualtColor: Colors.grey ,
                        child: Icon(
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
  ) ;
  Widget buildCategoryItem(DataModel model,context ) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image:NetworkImage(model.image!),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100,
        child:Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}