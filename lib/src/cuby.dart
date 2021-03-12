import 'dart:async';

import 'package:flutter/widgets.dart';

import 'rx/rx_impl.dart';
import 'rx/rx_interface.dart';

class Cuby extends StatefulWidget {
  final Widget Function() builder;
  const Cuby(
    this.builder, {
    Key? key,
  }) : super(key: key);

  @override
  _CubyState createState() => _CubyState();
}

class _CubyState extends State<Cuby> {
  final RxInterface _observer = Rx();

  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _observer.subject.stream.listen(
      (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previousObs = rxGlobal;
    rxGlobal = _observer;
    final child = widget.builder();
    rxGlobal = previousObs;
    return child;
  }

  @override
  void dispose() {
    _subscription.cancel();
    _observer.close();
    super.dispose();
  }
}
