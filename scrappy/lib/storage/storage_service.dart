class Storage<E>{

  final String boxName;
  E _box = null;
  Storage(this.boxName);

  /*bool isOpen(){
    return _box!=null?_box.isOpen:false;
  }*/

  /*
   * Generalizzazione della funzione openBox di hive in modo da avere sempre almeno la strategia di compattamento di default

  Future<void> openBox({int compactDeletedEntries = 20, bool Function(int,int) compactionStrategy = null}) async {
    //print(['open',boxName]);
    if(!isOpen()){
      _box = await Hive.openBox<E>(boxName, compactionStrategy: compactionStrategy ?? (entries, delEntries) {
          return delEntries > compactDeletedEntries;
      });
    }
  }
  */

  Future<void> closeBox() async {
    //print(['close',boxName]);
    if(!isOpen())
      throw('$boxName is aready closed');
    else {
      await _box.close();
    }
  }

  /**
   * aggiungi in testa all lista
   */
  Future<void> unshift(E element) async {
    //print(['unshift',boxName]);
    if(!isOpen())
      throw('$boxName is not open');
    if(_box.isEmpty)
      await _box.add(element);
    else
      //todo controllare se sovrascrive l'elemento in zero
      await _box.putAt(0,element);
  }

  Future<void> unshiftAsync(E element, {bool close = true}) async {
    await openBox();
    await this.unshift(element);
    if(close)
      await closeBox();
  }

  int length(){
    if(!isOpen())
      throw('$boxName is not open');
    return _box.length;
  }
  
  E first() {
    //print(['get first',boxName]);
    if(!isOpen())
      throw('$boxName is not open');
    if(_box.length>0)
      return _box.getAt(0);
    return null;
  }

  Future<E> firstAsync({bool close = true}) async {
    await openBox();
    E value = this.first();
    if(close)
      await closeBox();
    return value;
  }

  Future<bool> removeAsync({bool close = true, int index = 0}) async {
    await openBox();
    if(_box.length > index) {
      await _box.deleteAt(index);
      return true;
    }
    return false;
  }

  static Future<void> reset() async {
    //devo aprire tutti i box
    await Storage<License>(Constants.boxLicense).openBox();
    await Storage<int>(Constants.boxRefreshOrderTime).openBox();
    await Storage<bool>(Constants.boxRememberUsername).openBox();
    await Storage<String>(Constants.boxUsername).openBox();
    //rimuove dal disco tutti  i box aperti
    await Hive.deleteFromDisk();
  }
}