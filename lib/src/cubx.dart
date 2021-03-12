import 'dart:async';

import 'package:flutter/widgets.dart';

import 'cube.dart';
import 'cube_provider.dart';
import 'rx/rx_impl.dart';
import 'rx/rx_interface.dart';

typedef CubeBuilder<T> = Widget Function(BuildContext _, T cube);

class Cubx<T extends Cube?> extends StatefulWidget {
  final T? cube;
  final CubeBuilder<T> builder;
  const Cubx({
    required this.builder,
    this.cube,
  }) : assert(builder != null);

  @override
  _CubxState<T> createState() => _CubxState<T>();
}

class _CubxState<C extends Cube?> extends State<Cubx<C?>> {
  RxInterface? _rx;
  late StreamSubscription _subscription;
  C? _cube;

  bool get _creator => widget.cube != null;

  @override
  void initState() {
    super.initState();

    _rx = Rx();
    _cube = widget.cube ?? context.cube<C>();

    if (_creator) {
      _cube?.onInit();
    }

    _subscription = _rx!.subject.stream.listen(
      (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rx = rxGlobal;
    rxGlobal = _rx;
    final result = widget.builder(context, _cube);
    rxGlobal = rx;
    return result;
  }

  @override
  void dispose() {
    if (_creator) {
      _cube?.dispose();
    }

    _subscription.cancel();
    _rx!.close();
    super.dispose();
  }
}

class Cubx2<A extends Cube, B extends Cube> extends StatelessWidget {
  final A? first;
  final B? second;
  final Widget Function(BuildContext _, A first, B second) builder;
  const Cubx2({
    Key? key,
    this.first,
    this.second,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Cubx<A>(
      cube: first,
      builder: (_, firstCube) => Cubx<B>(
        cube: second,
        builder: (context, secondCube) => builder(context, firstCube, secondCube),
      ),
    );
  }
}
