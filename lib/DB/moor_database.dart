

import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Goals extends Table {

  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  RealColumn get amount => real()();

  DateTimeColumn get dateAdded => dateTime().nullable()();
}
@UseMoor(tables: [Goals])
class AppDatabase extends _$AppDatabase{
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
    path: 'db.sqlite',
    logStatements: true,
  )));
  @override
  int get schemaVersion => 1;

  Future<List<Goal>> getAllGoals() => select(goals).get();

  Stream<List<Goal>> watchAllGoals() => select(goals).watch();

  Future insertGoal(Goal goal) => into(goals).insert(goal);

  Future updateGoal(Goal goal) => update(goals).replace(goal);

  Future deleteGoal(Goal goal) => delete(goals).delete(goal);
}

