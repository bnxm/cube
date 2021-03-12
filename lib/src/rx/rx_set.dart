part of 'rx_impl.dart';

extension CubeSetExtension<E> on Set<E> {
  RxSet<E> get rx => RxSet<E>() << this;
}

class RxSet<E> extends RxIterable<E> implements Set<E> {
  RxSet([Set<E>? initial]) : super(initial);

  @override
  Set<E> get value => super.value as Set<E>;

  @override
  set value(Iterable<E>? value) => super.value = value!.toSet();

  @override
  bool add(E item) {
    final r = value.add(item);
    _emit();
    return r;
  }

  @override
  void addAll(Iterable<E> item) {
    value.addAll(item);
    _emit();
  }

  @override
  bool remove(Object? item) {
    final hasRemoved = value.remove(item);
    if (hasRemoved) _emit();
    return hasRemoved;
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
  Set<R> cast<R>() => _value!.cast<R>() as Set<R>;

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    _emit();
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    value.removeAll(elements);
    _emit();
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    value.retainAll(elements);
    _emit();
  }

  @override
  bool containsAll(Iterable<Object?> other) => value.containsAll(other);

  @override
  Set<E> difference(Set<Object?> other) => value.difference(other);

  @override
  Set<E> intersection(Set<Object?> other) => value.intersection(other);

  @override
  Set<E> union(Set<E> other) => value.union(other);

  @override
  E? lookup(Object? object) => value.lookup(object);

  @override
  RxSet<E> operator <<(Iterable<E> value) {
    this.value = value;
    return this;
  }
}
