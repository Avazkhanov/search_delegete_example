import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:search_delegete_example/data/model/region_model.dart';
import 'package:search_delegete_example/data/network_responce/network_responce.dart';
import 'package:sqflite/sqflite.dart';

class PlacesDatabase {
  static final PlacesDatabase instance = PlacesDatabase._init();

  PlacesDatabase._init();

  factory PlacesDatabase() {
    return instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await createAndInitializeDatabase();
      return _database!;
    }
  }

  Future<Database> createAndInitializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final databaseFilePath = join(databasePath, 'my_database.db');

    final database = await openDatabase(databaseFilePath, version: 1,
        onCreate: (Database db, int version) async {
          // Read and execute SQL script here
          final scriptContent =
          await rootBundle.loadString('assets/sql/places.sql');
          final statements = scriptContent.split(';');

          for (final statement in statements) {
            if (statement.trim().isNotEmpty) {
              await db.execute(statement);
            }
          }

          // Create a table to store search queries if not already created in places.sql
          await db.execute('''
        CREATE TABLE IF NOT EXISTS search_queries (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          query TEXT
        )
      ''');
        });

    return database; // Return the created database
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query) async {
    final db = await instance.database;
    return await db.rawQuery(query);
  }

  Future<NetworkResponse> getAllRegions() async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      List<RegionModel> allRegions = [];
      final db = await instance.database;
      allRegions = (await db.query('regions'))
          .map((e) => RegionModel.fromJson(e))
          .toList();
      networkResponse.data = allRegions;
      return networkResponse;
    } catch (error) {
      networkResponse.errorText = error.toString();
      return networkResponse;
    }
  }

  Future<NetworkResponse> getAllDistricts() async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      List<RegionModel> allDistricts = [];
      final db = await instance.database;
      allDistricts = (await db.query('districts'))
          .map((e) => RegionModel.fromJson(e))
          .toList();
      networkResponse.data = allDistricts;
      return networkResponse;
    } catch (error) {
      networkResponse.errorText = error.toString();
      return networkResponse;
    }
  }

  Future<NetworkResponse> getAllQuarters() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      List<RegionModel> allQuarters = [];
      final db = await instance.database;
      allQuarters = (await db.query('quarters'))
          .map((e) => RegionModel.fromJson(e))
          .toList();
      networkResponse.data = allQuarters;
      return networkResponse;
    } catch (error) {
      networkResponse.errorText = error.toString();
      return networkResponse;
    }
  }

  // Yangi metod: qidiruv so'rovini saqlash
  Future<void> saveSearchQuery(String query) async {
    final db = await instance.database;
    await db.insert('search_queries', {'query': query});
  }

  // Yangi metod: saqlangan qidiruv so'rovlarini olish
  Future<List<String>> getSearchQueries() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('search_queries');
    return List.generate(maps.length, (i) {
      return maps[i]['query'];
    });
  }
}
