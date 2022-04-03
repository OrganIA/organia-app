import 'package:hive_flutter/hive_flutter.dart';
import 'package:organia/src/models/hive/current_hive_user.dart';

MyHive hive = MyHive();

class MyHive {
  late Box box;
  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CurrentHiveUserAdapter());
    }
    box = await Hive.openBox('organia');
  }
}
