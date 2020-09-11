part of 'rx_impl.dart';

abstract class RxIterable<E> extends _Rx<Iterable<E>> implements Iterable<E> {
  RxIterable([Iterable<E> iterable]) : super(iterable);

  @override
  bool any(bool Function(E element) test) => _value.any(test);

  @override
  Iterable<R> cast<R>() => _value.cast<R>();

  @override
  bool contains(Object element) => _value.contains(element);

  @override
  E elementAt(int index) => _value.elementAt(index);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E) f) => _value.expand(f);

  @override
  E get first => _value.first;

  @override
  E firstWhere(bool Function(E element) test, {E Function() orElse}) {
    return _value.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    return _value.fold(initialValue, combine);
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) => _value.followedBy(other);

  @override
  bool get isEmpty => _value.isEmpty;

  @override
  bool get isNotEmpty => _value.isNotEmpty;

  @override
  Iterator<E> get iterator => _value.iterator;

  @override
  String join([String separator = ""]) => _value.join(separator);

  @override
  E get last => _value.last;

  @override
  E lastWhere(bool Function(E element) test, {E Function() orElse}) =>
      _value.lastWhere(test, orElse: orElse);

  @override
  int get length => _value.length;

  @override
  Iterable<T> map<T>(T Function(E e) f) => _value.map(f);

  @override
  E reduce(E Function(E value, E element) combine) => _value.reduce(combine);

  @override
  E get single => _value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function() orElse}) =>
      _value.singleWhere(test, orElse: orElse);

  @override
  Iterable<E> skip(int count) => _value.skip(count);

  @override
  Iterable<E> skipWhile(bool Function(E value) test) => _value.skipWhile(test);

  @override
  Iterable<E> take(int count) => _value.take(count);

  @override
  Iterable<E> takeWhile(bool Function(E value) test) => _value.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => _value.toList(growable: true);

  @override
  Set<E> toSet() => _value.toSet();

  @override
  Iterable<E> where(bool Function(E element) test) => _value.where(test);

  @override
  Iterable<T> whereType<T>() => _value.whereType<T>();

  @override
  bool every(bool Function(E element) test) => _value.every(test);

  @override
  void forEach(void Function(E element) f) => _value.forEach(f);
}
