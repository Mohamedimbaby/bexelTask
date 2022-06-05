import 'package:bexel_task/data/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

class ProductDatabase {
  static late Configuration _config;
  static late Realm _realm;
  static setDBConfiguration (){
    _config = Configuration([Product.schema],inMemory: true);
    _realm = Realm(_config);
  }
  static insertProduct (Product item){
    _realm.write(() {
      _realm.add(item);
    });
    debugPrint("Saved");
  }
  static deleteProduct (Product item){
    _realm.write(() {
      _realm.delete<Product>(item);
    });
  }
  static updateProduct (Product item,Product newItem){
    _realm.write(() {
      item.details = newItem.details;
      item.name = newItem.name;
      item.isActive = newItem.isActive;
      item.imageFile = newItem.imageFile;
      item.expiryDate = newItem.expiryDate;
    });
  }


  static RealmResults<Product> getAllProduct (){
    RealmResults<Product> results = _realm.all<Product>();
    return results;
  }

  static closeConnection(){
    if(!_realm.isClosed){
      _realm.close();
    }
  }
}
