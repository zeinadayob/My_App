
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/layout/News_app/Cubit/cubite.dart';
import 'package:my_app/layout/News_app/Cubit/states.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state) {
        var list= NewsCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: articleBuilder(list,context),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Expanded(

                  child: articleBuilder(list,context)
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Details',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
              ),

            ],
          ),
          breakpoints: const ScreenBreakpoints(
              desktop: 850, tablet: 600, watch:100),
        );

      },);


  }
}