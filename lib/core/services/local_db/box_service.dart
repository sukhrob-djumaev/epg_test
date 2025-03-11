import 'package:hive_ce/hive.dart';

abstract class IBoxService {
  Future<void> initBox<T>(String boxKey);
  Future<void> put<T>(String boxKey, String entryKey, T value);
  T? get<T>(String boxKey, String entryKey);
  Future<void> delete<T>(String boxKey, String entryKey);
  bool containsKey<T>(String boxKey, String entryKey);
}

final class BoxService implements IBoxService {
  final Map<String, Box> _boxes = {};

  @override
  Future<void> initBox<T>(String boxKey) async {
    if (!_boxes.containsKey(boxKey)) {
      final box = await Hive.openBox<T>(boxKey);
      _boxes[boxKey] = box;
    }
  }

  @override
  Future<void> put<T>(String boxKey, String entryKey, T value) async {
    final box = _boxes[boxKey] as Box<T>?;
    if (box != null) {
      await box.put(entryKey, value);
    } else {
      throw Exception("Box for key '$boxKey' is not initialized. Call initBox<T> first.");
    }
  }

  @override
  T? get<T>(String boxKey, String entryKey) {
    final box = _boxes[boxKey] as Box<T>?;
    if (box != null) {
      return box.get(entryKey);
    }
    throw Exception("Box for key '$boxKey' is not initialized. Call initBox<T> first.");
  }

  @override
  Future<void> delete<T>(String boxKey, String entryKey) async {
    final box = _boxes[boxKey] as Box<T>?;
    if (box != null) {
      await box.delete(entryKey);
    } else {
      throw Exception("Box for key '$boxKey' is not initialized. Call initBox<T> first.");
    }
  }

  @override
  bool containsKey<T>(String boxKey, String entryKey) {
    final box = _boxes[boxKey] as Box<T>?;
    if (box != null) {
      return box.containsKey(entryKey);
    }
    throw Exception("Box for key '$boxKey' is not initialized. Call initBox<T> first.");
  }
}
