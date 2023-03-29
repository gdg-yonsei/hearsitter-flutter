import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart'; // db에 접근하기 위해
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtil {
  final String tableName = AppDatabase.tableName;
  final int version = AppDatabase.version;
  static Database? _database; //SQLite database

  static final DatabaseUtil db = DatabaseUtil._internal();

  // 처음 인스턴스 만들 때 실행되는 코드로 1회 발생 (초기화 코드)
  DatabaseUtil._internal();

  // singleton 패턴 구현에 사용
  // 새로운 인스턴스를 생성하지 않고, 클래스의 인스턴스 반환 (무조건 하나의 인스턴스)
  factory DatabaseUtil() => db;

  Future<Database> get database async =>
      // db가 null인 경우 openDatabase를 통해 데이터베이스 열어야함
      _database ??= await _initDB('$tableName.db');

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // onCreate 버전이 다른 경우, 지정된 경로의 데이터베이스를 찾을 수 없을 경우
    return await openDatabase(path, version: version, onCreate: _createDB);
  }

  // table 생성
  Future _createDB(Database database, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const realType = 'REAL';
    const boolType = 'BOOLEAN';

    await database.execute(
        '''CREATE TABLE $tableName (id $idType, Alarm $boolType, Label $textType, Tagging_rate $realType, date $textType)''');
  }

  Future<dynamic> getAllHistory() async {
    final db = await database;

    const orderBy = 'id DESC';

    var res = await db.query(tableName, orderBy: orderBy);

    if (res.isEmpty) {
      return [];
    }
    return res.map((e) => AudioTaggingModel.fromJson(e)).toList();
  }

  Future<void> addHistory(
      AudioTaggingModel audioTagging, int currentDecibel) async {
    final db = await database;

    audioTagging = audioTagging.copyWith(
        date: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
        decibel: currentDecibel);

    db.insert(tableName, audioTagging.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteHistory(int id) async {
    final db = await database;
    await db.rawDelete("DELETE FROM $tableName WHERE id = ?", [id]);
  }


  // 앱이 종료되면, DB 자동으로 닫히지만,
  // 원할 때 종료하고 싶은 경우  사용됨.
  Future close() async {
    final db = await database;

    db.close();
  }
}
