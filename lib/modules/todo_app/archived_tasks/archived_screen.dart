
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/shared/components/components.dart';
import 'package:my_app/shared/cubites/cubite.dart';
import 'package:my_app/shared/cubites/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks =AppCubit.get(context).archiveTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },

    ) ;
  }
}