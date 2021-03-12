part of 'rx_impl.dart';

extension CubeMapExtension<K, V> on Map<K, V> {
  RxMap<K, V> get rx => RxMap<K, V>() << this;
}

class RxMap<K, V> extends _Rx<Map<K, V>> implements Map<K, V> {
  RxMap([Map<K, V>? initial]) : super(initial);

  @override
  V? operator [](dynamic key) => value[key];

  @override
  void operator []=(K key, V value) {
    _value![key] = value;
    _emit();
  }

  @override
  void addAll(Map<K, V> other) {
    _value!.addAll(other);
    _emit();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> entries) {
    _value!.addEntries(entries);
    _emit();
  }

  @override
  void clear() {
    _value!.clear();
    _emit();
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    final V value = _value!.putIfAbsent(key, ifAbsent);
    _emit();
    return value;
  }

  @override
  V? remove(Object? key) {
    final value = _value!.remove(key);
    _emit();
    return value;
  }

  @override
  void removeWhere(bool Function(K, V) test) {
    _value!.removeWhere(test);
    _emit();
  }

  @override
  V update(K key, V Function(V) update, {V Function()? ifAbsent}) {
    final V value = _value!.update(key, update, ifAbsent: ifAbsent);
    _emit();
    return value;
  }

  @override
  void updateAll(V Function(K, V) update) {
    _value!.updateAll(update);
    _emit();
  }

  @override
  Map<RK, RV> cast<RK, RV>() => _value!.cast<RK, RV>();

  @override
  bool containsKey(Object? key) {
    _attachListener();
    return _value!.containsKey(key);
  }

  @override
  bool containsValue(Object? value) => this.value.containsValue(value);

  @override
  Iterable<MapEntry<K, V>> get entries => value.entries;

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterable<K> get keys => value.keys;

  @override
  int get length => value.length;

  @override
  Iterable<V> get values => value.values;

  @override
  void forEach(void Function(K key, V value) f) => value.forEach(f);

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(K key, V value) m) => value.map(m);

  @override
  bool operator ==(dynamic o) => const DeepCollectionEquality().equals(value, o);

  @override
  int get hashCode => super.hashCode;

  @override
  RxMap<K, V> operator <<(Map<K, V> value) {
    this.value = value;
    return this;
  }
}
