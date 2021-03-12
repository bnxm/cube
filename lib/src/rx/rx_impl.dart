import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';

import 'package:cube/cube.dart';

import 'rx_interface.dart';

part 'rx_iterable.dart';
part 'rx_list.dart';
part 'rx_map.dart';
part 'rx_set.dart';

abstract class _Rx<T> implements RxInterface<T?> {
  _Rx([T? initial]) : _value = initial;

  @override
  final StreamController<T?> subject = StreamController.broadcast();
  final Map<Stream<T?>, StreamSubscription> _subscriptions = {};

  void _emit() => subject.add(value);
  void _attachListener() => rxGlobal?.addListener(subject.stream);

  bool _firstRebuild = true;

  T? _value;
  T? get value {
    _attachListener();
    return _value;
  }

  set value(T? value) {
    if (_value == value && !_firstRebuild) return;
    _firstRebuild = false;
    _value = value;
    _emit();
  }

  // ignore: use_setters_to_change_properties
  void call(T value) => this.value = value;

  _Rx<T> operator <<(T value) {
    this.value = value;
    return this;
  }

  bool get hasValue => _value != null;

  @override
  void addListener(Stream<T?> rx) {
    if (_subscriptions.containsKey(rx)) return;

    _subscriptions[rx] = rx.listen(subject.add);
  }

  Stream<T?> get stream => subject.stream;

  @override
  StreamSubscription<T?> listen(
    void Function(T?) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  void bindStream(Stream<T> stream) => stream.listen((v) => value = v);

  @override
  void close() {
    _subscriptions
      ..forEach((observable, subscription) => subscription.cancel())
      ..clear();

    subject.close();
  }
}

class Rx<T> extends _Rx<T> {
  Rx([T? initial]) : super(initial);

  Stream<R> map<R>(R Function(T? data) mapper) => stream.map(mapper);
}

extension CubeExtensions<T> on T {
  Rx<T> get rx => Rx<T>(this);
}
