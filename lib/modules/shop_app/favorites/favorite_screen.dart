import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/shop_app/cubite/cubite.dart';
import 'package:my_app/layout/shop_app/cubite/state.dart';
import 'package:my_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavState && cubit.favoritesModel!.data!.data!.length>0,
          builder:(context)=>ListView.separated (
              itemBuilder: (context, index) => buildListProduct(cubit.favoritesModel!.data!.data![index].product!,context),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount:cubit.favoritesModel!.data!.data!.length),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,

        );
      },
    ) ;
  }

}
