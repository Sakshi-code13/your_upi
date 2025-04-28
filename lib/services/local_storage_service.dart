import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/scan_data.dart';

class LocalStorageService {
  static final LocalStorageService instance = LocalStorageService._init();

  static Database? _database;

  LocalStorageService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('scan_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE scans (
        id $idType,
        payeeName $textType,
        upiId $textType,
        merchantCode TEXT,
        transactionId TEXT,
        transactionRefId TEXT,
        transactionNote TEXT,
        amount TEXT,
        scanDate $textType
      )
    ''');
  }

  Future<int> insertScan(ScanData scan) async {
    final db = await instance.database;
    return await db.insert('sc<create_file>
<path>lib/services/local_storage_service.dart</path>
<content>
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/scan_data.dart';

class LocalStorageService {
  static final LocalStorageService instance = LocalStorageService._init();

  static Database? _database;

  LocalStorageService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('your_upi.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE scans (
      id $idType,
      payeeName $textType,
      upiId $textType,
      merchantCode TEXT,
      transactionId TEXT,
      transactionRefId TEXT,
      transactionNote TEXT,
      amount TEXT,
      scanDate TEXT NOT NULL
    )
    ''');
  }

  Future<int> insertScan(ScanData scan) async {
    final db = await instance.database;
    return await db.insert('scans', scan.toMap());
  }

  Future<List<ScanData>> getAllScans() async {
    final db = await instance.database;
    final result = await db.query('scans', orderBy: 'scanDate DESC');
    return result.map((json) => ScanData.fromMap(json)).toList();
  }

  Future<List<ScanData>> searchScans(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'scans',
      where: 'payeeName LIKE ? OR upiId LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'scanDate DESC',
    );
    return result.map((json) => ScanData.fromMap(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
