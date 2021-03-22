import 'package:mongo_dart/mongo_dart.dart';
import 'main.dart';

class Database {
  static passwordByEmail(String mail) async {
    var password =
        await coll.findOne(where.eq("Email", mail).fields(['Password']));
    return password;
  }
}
