import 'dart:async';

RxInterface<dynamic>? rxGlobal;

abstract class RxInterface<T> {
  StreamController<T> get subject;

  /// Adds a listener to the [Stream]
  void addListener(Stream<T> rxGetx);

  /// Closes the [Stream]
  void close() => subject.close();

  /// Calls [callback] with current value, when the value changed.
  StreamSubscription<T> listen(void Function(T value) onData);
}
