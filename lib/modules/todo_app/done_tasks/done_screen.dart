
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/shared/components/components.dart';

import '../../../shared/cubites/cubite.dart';
import '../../../shared/cubites/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var tasks =AppCubit.get(context).doneTasks;
        return tasksBuilder(
          tasks: tasks,
        );
      },

    ) ;
  }
}