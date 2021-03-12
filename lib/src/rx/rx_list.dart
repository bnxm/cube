part of 'rx_impl.dart';

extension CubeListExtension<E> on List<E> {
  RxList<E> get rx => RxList<E>() << this;
}

class RxList<E> extends RxIterable<E> implements List<E> {
  RxList([List<E>? initial]) : super(initial);

  @override
  List<E> get value => super.value as List<E>;

  @override
  set value(Iterable<E>? value) => super.value = value!.toList();

  @override
  E operator [](int index) => value[index];

  @override
  void operator []=(int index, E item) {
    value[index] = item;
    _emit();
  }

  @override
  set last(E value) {
    this.value.last = value;
    _emit();
  }

  @override
  void add(E item) {
    value.add(item);
    _emit();
  }

  @override
  void addAll(Iterable<E> item) {
    value.addAll(item);
    _emit();
  }

  @override
  List<E> operator +(List<E> other) => value + other;

  @override
  void insert(int index, E item) {
    value.insert(index, item);
    _emit();
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    _emit();
  }

  @override
  bool remove(Object? item) {
    final hasRemoved = value.remove(item);
    if (hasRemoved) _emit();
    return hasRemoved;
  }

  @override
  E removeAt(int index) {
    final item = value.removeAt(index);
    _emit();
    return item;
  }

  @override
  E removeLast() {
    final item = value.removeLast();
    _emit();
    return item;
  }

  @override
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    _emit();
  }

  @override
  void removeWhere(bool Function(E) test) {
    value.removeWhere(test);
    _emit();
  }

  @override
  void clear() {
    value.clear();
    _emit();
  }

  @override
  void sort([Comparator<E>? compare]) {
    value.sort();
    _emit();
  }

  @override
  List<R> cast<R>() => value.cast<R>();

  @override
  Map<int, E> asMap() => value.asMap();

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    _emit();
  }

  @override
  set first(E value) {
    this.value.first = value;
    _emit();
  }

  @override
  Iterable<E> getRange(int start, int end) => value.getRange(start, end);

  @override
  int indexOf(E element, [int start = 0]) => value.indexOf(element, start);

  @override
  int indexWhere(bool Function(E elemen) test, [int start = 0]) =>
      value.indexWhere(test, start);

  @override
  int lastIndexOf(E element, [int? start]) => value.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) =>
      value.lastIndexWhere(test, start);

  @override
  set length(int newLength) => value.length = newLength;

  @override
  void replaceRange(int start, int end, Iterable<E> replacement) {
    value.replaceRange(start, end, replacement);
    _emit();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    _emit();
  }

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    _emit();
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    _emit();
  }

  @override
  void shuffle([Random? random]) {
    value.shuffle(random);
    _emit();
  }

  @override
  List<E> sublist(int start, [int? end]) => value.sublist(start, end);

  @override
  RxList<E> operator <<(Iterable<E> value) {
    this.value = value;
    return this;
  }
}
