import 'package:flutter_getx_todo/app/core/utils/keys.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.writeIfNull(taskKey, []);
    return this;
  }
}
