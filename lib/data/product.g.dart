// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Product extends _Product with RealmEntity, RealmObject {
  Product(
    int id,
    String details,
    String name,
    String expiryDate,
    bool isActive,
    String imageFile, {
    Iterable<String> availability = const [],
  }) {
    RealmObject.set(this, 'id', id);
    RealmObject.set(this, 'details', details);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'expiryDate', expiryDate);
    RealmObject.set(this, 'isActive', isActive);
    RealmObject.set(this, 'imageFile', imageFile);
    RealmObject.set<RealmList<String>>(
        this, 'availability', RealmList<String>(availability));
  }

  Product._();

  @override
  int get id => RealmObject.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String get details => RealmObject.get<String>(this, 'details') as String;
  @override
  set details(String value) => RealmObject.set(this, 'details', value);

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  String get expiryDate =>
      RealmObject.get<String>(this, 'expiryDate') as String;
  @override
  set expiryDate(String value) => RealmObject.set(this, 'expiryDate', value);

  @override
  bool get isActive => RealmObject.get<bool>(this, 'isActive') as bool;
  @override
  set isActive(bool value) => RealmObject.set(this, 'isActive', value);

  @override
  String get imageFile => RealmObject.get<String>(this, 'imageFile') as String;
  @override
  set imageFile(String value) => RealmObject.set(this, 'imageFile', value);

  @override
  RealmList<String> get availability =>
      RealmObject.get<String>(this, 'availability') as RealmList<String>;
  @override
  set availability(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Product>> get changes =>
      RealmObject.getChanges<Product>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Product._);
    return const SchemaObject(Product, [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('details', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('expiryDate', RealmPropertyType.string),
      SchemaProperty('isActive', RealmPropertyType.bool),
      SchemaProperty('imageFile', RealmPropertyType.string),
      SchemaProperty('availability', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
