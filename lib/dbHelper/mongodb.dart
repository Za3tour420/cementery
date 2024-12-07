import 'dart:developer';
import 'package:cementery/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection productCollection;
  static late DbCollection userCollection;
  static late DbCollection clientCollection;

  static Future<void> connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    productCollection = db.collection(PRODUCT_COLLECTION);
    userCollection = db.collection(USER_COLLECTION);
    clientCollection = db.collection(CLIENT_COLLECTION);
  }
}
