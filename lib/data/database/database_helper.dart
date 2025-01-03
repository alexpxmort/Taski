import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite_common_ffi for FFI
import 'package:sqflite/sqflite.dart'; // Still import sqflite for its API
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  // Private constructor
  DatabaseHelper._();

  // Factory constructor for singleton
  factory DatabaseHelper() => _instance;

  // Initialize the database factory to use the FFI version
  static void initializeDatabaseFactory() {
    databaseFactory = databaseFactoryFfi; // Set the database factory to FFI
  }

  // Getter to return the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'taski.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
      },
    );
  }
}
