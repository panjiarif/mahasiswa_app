import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:mahasiswa_app/models/mahasiswa.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'mahasiswa.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mahasiswa(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nim TEXT,
        nama TEXT,
        jurusan TEXT,
        tanggal_lahir TEXT,
        no_telp TEXT,
        email TEXT,
        jenis_kelamin TEXT,
        alamat TEXT
      )
    ''');
  }

  // Operasi CRUD (Create, Read, Update, Delete)

  // CREATE (Tambah data baru)
  Future<int> insertMahasiswa(Mahasiswa mahasiswa) async {
    Database db = await instance.database;
    return await db.insert('mahasiswa', mahasiswa.toMap());
  }

  // READ (Ambil semua data)
  Future<List<Mahasiswa>> getMahasiswaList() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('mahasiswa');
    return List.generate(maps.length, (i) {
      return Mahasiswa.fromMap(maps[i]);
    });
  }
  
  // Update
  Future<int> updateMahasiswa(Mahasiswa mahasiswa) async {
    Database db = await instance.database;
    return await db.update(
      'mahasiswa',
      mahasiswa.toMap(),
      where: 'id = ?',
      whereArgs: [mahasiswa.id],
    );
  }
  
  // Delete
  Future<int> deleteMahasiswa(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'mahasiswa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}