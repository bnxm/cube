part of 'rx_impl.dart';

abstract class RxIterable<E> extends _Rx<Iterable<E>> implements Iterable<E> {
  RxIterable([Iterable<E> iterable]) : super(iterable);

  @override
  bool any(bool Function(E element) test) => value.any(test);

  @override
  Iterable<R> cast<R>() => value.cast<R>();

  @override
  bool contains(Object element) => value.contains(element);

  @override
  E elementAt(int index) => value.elementAt(index);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E) f) => value.expand(f);

  @override
  E get first => value.first;

  @override
  E firstWhere(bool Function(E element) test, {E Function() orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    return value.fold(initialValue, combine);
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) => value.followedBy(other);

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  String join([String separator = ""]) => value.join(separator);

  @override
  E get last => value.last;

  @override
  E lastWhere(bool Function(E element) test, {E Function() orElse}) =>
      value.lastWhere(test, orElse: orElse);

  @override
  int get length => value.length;

  @override
  Iterable<T> map<T>(T Function(E e) f) => value.map(f);

  @override
  E reduce(E Function(E value, E element) combine) => value.reduce(combine);

  @override
  E get single => value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function() orElse}) =>
      value.singleWhere(test, orElse: orElse);

  @override
  Iterable<E> skip(int count) => value.skip(count);

  @override
  Iterable<E> skipWhile(bool Function(E value) test) => value.skipWhile(test);

  @override
  Iterable<E> take(int count) => value.take(count);

  @override
  Iterable<E> takeWhile(bool Function(E value) test) => value.takeWhile(test);

  @override
  List<E> toList({bool growable = true}) => value.toList(growable: true);

  @override
  Set<E> toSet() => value.toSet();

  @override
  Iterable<E> where(bool Function(E element) test) => value.where(test);

  @override
  Iterable<T> whereType<T>() => value.whereType<T>();

  @override
  bool every(bool Function(E element) test) => value.every(test);

  @override
  void forEach(void Function(E element) f) => _value.forEach(f);
}
