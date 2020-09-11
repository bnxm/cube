import 'package:flutter/material.dart';
import 'package:cube/cube.dart';

import 'cube.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubit Counter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Cubit Counter')),
        body: Column(
          children: const [
            Expanded(child: UsingProvider()),
            Expanded(child: Init()),
          ],
        ),
      ),
    );
  }
}

class UsingProvider extends StatelessWidget {
  const UsingProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CubeProvider<CounterCube>(
      create: (_) => CounterCube(),
      child: Cubx<CounterCube>(
        builder: (_, cubit) => InkWell(
          onTap: cubit.setList,
          child: Center(
            child: Text(
              '${cubit.list.first}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }
}

class Init extends StatefulWidget {
  const Init({Key key}) : super(key: key);

  @override
  _InitState createState() => _InitState();
}

class _InitState extends State<Init> {
  final cubit = CounterCube();

  @override
  Widget build(BuildContext context) {
    return Cubx<CounterCube>(
      cube: cubit,
      builder: (_, cubit) {
        print('onBuild');

        return InkWell(
          onTap: () => cubit.increment(),
          onLongPress: () => cubit.longCount++,
          child: Center(
            child: Text(
              '${cubit.count}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
