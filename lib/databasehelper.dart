import 'dart:async';
import 'dart:io';

import 'package:bakraw/model/internalcart.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbname = 'CustomerOrder.db';
  static final _tbl_name = 'CartOrders';
  static final _id = 'id';
  static final productid = 'productid';
  static final optionname = 'optionname';
  static final optionid = 'optionid';
  static final productpriceincreased = 'productpriceincreased';
  static final optionvalueid = 'optionvalue';
  static final optionlable = 'optionlable';
  static final price = 'price';
  static final quantity = 'quantity';
  static final _dbversion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String path = join(_directory.path, _dbname);

    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    return db.execute('''
        CREATE TABLE $_tbl_name (
        $_id INTEGER PRIMARY KEY,
        $productid TEXT NOT NULL,
        $optionid TEXT NOT NULL,
        $optionname TEXT NOT NULL,
        $optionvalueid TEXT NOT NULL,
        $optionlable TEXT NOT NULL,
        $productpriceincreased TEXT NOT NULL,
        $quantity TEXT NOT NULL,
        $price TEXT NOT NULL )       
      ''');
  }

  Future<int> addtoCart(Map<String, dynamic> row) async {
    Database db = await instance.database;
    var prod = row[productid];
    var opt = row[optionvalueid];

    var samp = await db.query(_tbl_name,
        where: '$productid =? AND $optionvalueid=?', whereArgs: [prod, opt]);
    if (samp.isEmpty) {
      return await db.insert(_tbl_name, row);
    } else {
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getCartitem() async {
    Database db = await instance.database;
    return await db.query(_tbl_name);
  }

  Future updateCartitem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String prodid = row[productid];
    String opti = row[optionvalueid];
    return await db.update(_tbl_name, row,
        where: '$productid = ? AND $optionvalueid=?',
        whereArgs: [prodid, opti]);
  }

  Future<int> deleteCartItem(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String prodid = row[productid];
    String opti = row[optionvalueid];
    return await db.delete(_tbl_name,
        where: '$productid = ? AND $optionvalueid = ? ',
        whereArgs: [prodid, opti]);
  }

  Future<int> getCount() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $_tbl_name');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<CartsModel>> getcartItems() async {
    var cartlist = await getCartitem();
    int count = cartlist.length;
    List<CartsModel> noteList = List<CartsModel>();
    for (int i = 0; i < count; i++) {
      noteList.add(CartsModel.fromMapObject(cartlist[i]));
    }
    return noteList;
  }
}
