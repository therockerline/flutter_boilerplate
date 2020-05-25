import 'package:localstorage/localstorage.dart';

class Storage<E>{
  static LocalStorage _storage;

  static Future<bool> initStorage() async {
    _storage = LocalStorage('scrappyStore');
    return await _storage.ready;
  }

  static Future<void> reset() async {
    _check();
    await _storage.clear();
  }

  static void _check(){
    if(_storage==null)
      throw('Storage not ready');
  }

  final String boxName;

  Storage(this.boxName){
      _check();
  }

  E get value{
    _check();
    return _storage.getItem(boxName) ?? null;
  }

  set value(E value) {
    _check();
    _storage.setItem(boxName, value);
  }

}