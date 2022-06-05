import 'package:realm/realm.dart';
part 'product.g.dart';

@RealmModel()
class _Product {
  @PrimaryKey()
  late int id;
  late String details;
  late String name;
  late String expiryDate;
  late bool isActive;
  late String imageFile ;
  late List<String> availability;



}