import 'dart:math';

import 'package:cube/cube.dart';

class CounterCube extends Cube {
  @override
  void onInit() {
    count = 10;
  }

  final _list = [1, 2, 3, 4, 5].rx;
  List<int> get list => _list.value;
  void setList() => _list.value = List.generate(10, (index) => Random().nextInt(100));

  final _counter = 10.rx;
  set count(int value) => _counter << value;
  int get count => _counter.value;

  final _longCount = 0.rx;
  int get longCount => _longCount.value;
  set longCount(int count) => _longCount.value = count;

  void increment() => count += 1;
  void decrement() => count -= 1;
}
