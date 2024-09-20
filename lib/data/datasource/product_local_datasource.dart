import 'package:flutter_pos_tab_custom/presentation/home/models/order_model.dart';
import 'package:flutter_pos_tab_custom/presentation/home/models/product_quantity.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product_response_model.dart';

class ProductLocalDatasource {
  ProductLocalDatasource._init();

  static final ProductLocalDatasource instance = ProductLocalDatasource._init();

  final String tableProduct = 'products';
  final String tableOrder = 'orders';
  final String tableOrderItem = 'order_items';

  static Database? _database;

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableProduct (
        id INTEGER PRIMARY KEY,
        productId INTEGER,
        name TEXT,
        categoryId INTEGER,
        categoryName TEXT,
        description TEXT,
        image TEXT,
        price TEXT,
        stock INTEGER,
        status INTEGER,
        isFavorite INTEGER,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrder (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        payment_amount INTEGER,
        sub_total INTEGER,
        tax INTEGER,
        discount INTEGER,
        service_charge INTEGER,
        total INTEGER,
        payment_method TEXT,
        total_item INTEGER,
        id_kasir INTEGER,
        nama_kasir TEXT,
        transaction_time TEXT,
        is_sync INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableOrderItem (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('dbresto1.db');
    return _database!;
  }

  Future<void> saveOrder(OrderModel order) async {
    final db = await instance.database;
    int id = await db.insert(tableOrder, order.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    for (var item in order.orderItems) {
      await db.insert(tableOrderItem, item.toLocalMap(id),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<OrderModel>> getOrderByIsNotSync() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableOrder, where: 'is_sync = ?', whereArgs: [0]);

    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  Future<List<OrderModel>> getAllOrder(
    DateTime start,
    DateTime end,
  ) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableOrder,
      where: 'transaction_time BETWEEN ? AND ?',
      whereArgs: [
        DateFormat.yMd().format(start),
        DateFormat.yMd().format(end),
      ],
    );

    return List.generate(maps.length, (i) {
      return OrderModel.fromMap(maps[i]);
    });
  }

  Future<List<ProductQuantity>> getOrderItemByOrderId(int orderId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db
        .query(tableOrderItem, where: 'id_order = ?', whereArgs: [orderId]);

    return List.generate(maps.length, (i) {
      return ProductQuantity.fromLocalMap(maps[i]);
    });
  }

  Future<void> updateOrderIsSync(int orderId) async {
    final db = await instance.database;
    await db.update(tableOrder, {'is_sync': 1},
        where: 'id = ?', whereArgs: [orderId]);
  }

  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    await db.insert(tableProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertProducts(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProduct, product.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('inserted success ${product.name}');
    }
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableProduct);

    return List.generate(maps.length, (i) {
      return Product.fromLocalMap(maps[i]);
    });
  }

  Future<void> deleteAllProducts() async {
    final db = await instance.database;
    await db.delete(tableProduct);
  }
}
