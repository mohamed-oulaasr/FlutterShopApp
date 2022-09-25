// ignore_for_file: avoid_print, unnecessary_string_interpolations, curly_braces_in_flow_control_structures

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/shared/cubit/states.dart';
import 'package:flutter_shop_app/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  // Change App Mode
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;

      emit(AppChangeModeState());
    }
    else
    {
      isDark = !isDark;

      CacheHelper.putBoolean(
        key: 'isDark',
        value: isDark,
      ).then((value)
      {
        emit(AppChangeModeState());
      });
    }
  }

  late Database database;

  // Create Database
  void createDatabase() {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version)
        {
          // id integer
          // title String
          // date String
          // time String
          // stutus String

          print('database created');
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title Text, date Text, time Text, stutus Text)')
              .then((value)
          {
            print('table created');
          }).catchError((error) {
            print('Error When Creating Table ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getDataFromDatabase(database);

          print('database opened');
        },
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());

    });
  }

  // Insert To Database
  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn)
    {
      txn.rawInsert('INSERT INTO tasks (title, date, time, stutus) VALUES ("$title", "$date", "$time", "new")')
         .then((value)
         {
           print('ID : $value Inserted Successfully');
           emit(AppInsertDatabaseState());

           getDataFromDatabase(database);
         })
         .catchError((error)
         {
           print('Error When Inserting New Record ${error.toString()}');
         });

      return Future(() => null);
    });
  }

  // Get Data From Database
  void getDataFromDatabase(database)
  {


    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      //newTasks = value;
      //print('List of tasks : $newTasks');

      value.forEach((element)
      {

      });

      emit(AppGetDatabaseState());
    });
  }

  // Update Data
  void updateData({
    required String status,
    required int id,
  }) async
  {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', ['$status', id])
            .then((value)
            {
              getDataFromDatabase(database);

              emit(AppUpdateDatabaseState());
            });
  }

  // Delete Data
  void deleteData({
    required int id,
  }) async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id])
            .then((value)
            {
              getDataFromDatabase(database);

              emit(AppDeleteDatabaseState());
            });
  }

}