import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

class DatabaseHelper {
  // Singleton
  DatabaseHelper._init();

  static final DatabaseHelper instance =
      DatabaseHelper._init();

  static Database? _database;

  // Lấy database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDB(
      "smart_library.db",
    );

    return _database!;
  }

  // Tạo file database
  Future<Database> _initDB(
    String filePath,
  ) async {
    final dbPath =
        await getDatabasesPath();

    final path =
        join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Tạo bảng
  Future<void> _createDB(
    Database db,
    int version,
  ) async {
    // USER
    await db.execute('''
      CREATE TABLE USER(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        fullname TEXT NOT NULL,
        email TEXT,
        avatar TEXT
      )
    ''');

    // CATEGORY
    await db.execute('''
      CREATE TABLE CATEGORY(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryName TEXT NOT NULL,
        description TEXT
      )
    ''');

    // BOOK
    await db.execute('''
      CREATE TABLE BOOK(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookName TEXT NOT NULL,
        author TEXT NOT NULL,
        price INTEGER,
        image TEXT,
        categoryId INTEGER,

        FOREIGN KEY(categoryId)
        REFERENCES CATEGORY(id)
      )
    ''');

    // BORROW
    await db.execute('''
      CREATE TABLE BORROW(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookId INTEGER,
        borrowDate TEXT,
        returnDate TEXT,
        status TEXT,

        FOREIGN KEY(bookId)
        REFERENCES BOOK(id)
      )
    ''');

    // ===== DỮ LIỆU MẪU =====

    // USER
    await db.insert("USER", {
      "username": "admin",
      "password": "123",
      "fullname": "Administrator",
      "email": "admin@gmail.com",
      "avatar": "",
    });

    // CATEGORY
    await db.insert("CATEGORY", {
      "categoryName": "CNTT",
      "description": "Sach CNTT",
    });

    await db.insert("CATEGORY", {
      "categoryName": "Kinh Te",
      "description": "Sach Kinh Te",
    });

    await db.insert("CATEGORY", {
      "categoryName": "Ngoai Ngu",
      "description": "Sach Ngoai Ngu",
    });

    // BOOK
    await db.insert("BOOK", {
      "bookName": "Flutter Co Ban",
      "author": "Nguyen Van A",
      "price": 120000,
      "image": "",
      "categoryId": 1,
    });

    await db.insert("BOOK", {
      "bookName": "Java Programming",
      "author": "Tran Van B",
      "price": 200000,
      "image": "",
      "categoryId": 1,
    });

    // BORROW
    await db.insert("BORROW", {
      "bookId": 1,
      "borrowDate": "2026-10-01",
      "returnDate": "2026-10-15",
      "status": "Returned",
    });
  }

  // ==========================
  // USER CRUD
  // ==========================

  Future<int> insertUser(
    User user,
  ) async {
    final db = await database;

    return await db.insert(
      "USER",
      user.toMap(),
    );
  }

  Future<User?> getUserByUsername(
    String username,
  ) async {
    final db = await database;

    final result = await db.query(
      "USER",
      where: "username = ?",
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return User.fromMap(
        result.first,
      );
    }

    return null;
  }

  Future<User?> login(
    String username,
    String password,
  ) async {
    final db = await database;

    final result = await db.query(
      "USER",
      where:
          "username = ? AND password = ?",
      whereArgs: [
        username,
        password,
      ],
    );

    if (result.isNotEmpty) {
      return User.fromMap(
        result.first,
      );
    }

    return null;
  }

  Future<List<User>> getAllUsers()
  async {
    final db = await database;

    final result =
        await db.query("USER");

    return result
        .map(
          (e) => User.fromMap(e),
        )
        .toList();
  }

  Future<int> updateUser(
    User user,
  ) async {
    final db = await database;

    return await db.update(
      "USER",
      user.toMap(),
      where: "id=?",
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(
    int id,
  ) async {
    final db = await database;

    return await db.delete(
      "USER",
      where: "id=?",
      whereArgs: [id],
    );
  }

  // Đóng DB
  Future close() async {
    final db =
        await instance.database;

    db.close();
  }
}