import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class GetStorageFunctions {
   setSignedUser(String key, dynamic value) async {
    final storage = GetStorage();
    await storage.write(key, value);
    
    log("Added to GET STORAGE $value");
  }

  getSignedUser(String key) async {
    final storage = GetStorage();
    await storage.read(key);
  }
}
