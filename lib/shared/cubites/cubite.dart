import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/modules/todo_app/archived_tasks/archived_screen.dart';
import 'package:my_app/modules/todo_app/new_tasks/new_screen.dart';
import 'package:my_app/shared/cubites/states.dart';
import 'package:my_app/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/done_tasks/done_screen.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitialState());
  static AppCubit get (context) => BlocProvider.of(context);

  int currentIndex=0;
  List<Widget> screen=[
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titels=[
    'Tasks',
    'DoneTasks',
    'ArchivedTasks'
  ];
  void changeIndex (int index)
  {
    currentIndex=index;
    emit(AppChangeBottomNavBarState());
  }
  Database? database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];

  void createDatabase()
  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version)
      {
        print('database created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT,status TEXT)').
        then((value)
        {
          print('table created');
        }).catchError((error){
          print('Error when cresting table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getFromDatabase(database);
      },
    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }
  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }

      ) async
  {
    await database!.transaction((txn)
    {
      return txn.rawInsert('INSERT INTO tasks(title, date, time,status) VALUES("$title","$date","$time","new")').
      then((value)
      {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getFromDatabase(database);
      }).catchError((error)
      {
        print( 'Error when Inserting New Record${error.toString()}');
      });
    });
  }
  void getFromDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
    emit(AppGetDatabaseLoadingState());
    database!.rawQuery('SELECT * FROM tasks').then((value) {


      value.forEach((element) {
        if(element['status']== 'new') {
          newTasks.add(element);
        } else if(element['status']== 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
        print(element['status']);
      });
      emit(AppGetDatabaseState());
    });

  }
  void updateDatabase({
    required String status,
    required int id,
  }) async
  {
    database!.rawUpdate(
        'UPDATE tasks SET status =? WHERE id =?',
        ['$status',id]
    ).then((value)
    {
      getFromDatabase(database);
      emit(AppUpdateDatabaseState());

    });
  }
  void deleteDatabase({
    required int id,
  }) async
  {
    database!.rawDelete(
        'DELETE from tasks WHERE id =?',
        [id]
    ).then((value)
    {
      getFromDatabase(database);
      emit(AppDeleteDatabaseState());

    });
  }
  bool isBottomSheetShown=false;
  IconData fabIcon=Icons.add;
  void ChangeBottomSheetState (
      @required bool isShow,
      @required IconData icon,
      ) async {
    isBottomSheetShown=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared!= null)
    {isDark=fromShared ;}
    else{
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState ());
      });

    }}}