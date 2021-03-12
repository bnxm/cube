import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'cube.dart';

/// A function that creates a `Cube` of type [T].
typedef CreateCube<T extends Cube> = T Function(
  BuildContext _,
);

/// Mixin which allows `MultiCubeProvider` to infer the types
/// of multiple [CubeProvider]s.
mixin CubeProviderSingleChildWidget on SingleChildWidget {}

/// {@template cubitprovider}
/// Takes a `ValueBuilder` that is responsible for creating the `cubit` and
/// a [child] which will have access to the `cubit` via
/// `CubeProvider.of(context)`.
/// It is used as a dependency injection (DI) widget so that a single instance
/// of a `cubit` can be provided to multiple widgets within a subtree.
///
/// Automatically handles closing the `cubit` when used with `create` and lazily
/// creates the provided `cubit` unless [lazy] is set to `false`.
///
/// ```dart
/// CubitProvider(
///   create: (BuildContext context) => CubitA(),
///   child: ChildA(),
/// );
/// ```
/// {@endtemplate}
class CubeProvider<T extends Cube> extends SingleChildStatelessWidget with CubeProviderSingleChildWidget {
  /// {@macro cubitprovider}
  CubeProvider({
    Key? key,
    required CreateCube<T> create,
    Widget? child,
    bool? lazy,
  }) : this._(
          key: key,
          create: (context) => create(context)..onCreate(),
          dispose: (_, cubit) => cubit.dispose(),
          child: child,
          lazy: lazy,
        );

  /// Takes a `cubit` and a [child] which will have access to the `cubit` via
  /// `CubitProvider.of(context)`.
  ///
  /// When `CubitProvider.value` is used, the `cubit` will not be automatically
  /// closed. As a result, `CubitProvider.value` should mainly be used for providing
  /// existing `cubit`s to new routes.
  ///
  /// A new `cubit` should not be created in `CubitProvider.value`.
  /// `cubit`s should always be created using the default constructor within
  /// `create`.
  ///
  /// ```dart
  /// CubitProvider.value(
  ///   value: CubitProvider.of<CubitA>(context),
  ///   child: ScreenA(),
  /// );
  /// ```
  CubeProvider.value({
    Key? key,
    required T value,
    Widget? child,
  }) : this._(
          key: key,
          create: (_) => value,
          child: child,
        );

  /// Internal constructor responsible for creating the [CubeProvider].
  /// Used by the [CubeProvider] default and value constructors.
  CubeProvider._({
    Key? key,
    required Create<T> create,
    Dispose<T>? dispose,
    this.child,
    this.lazy,
  })  : _create = create,
        _dispose = dispose,
        super(key: key, child: child);

  /// [child] and its descendants which will have access to the `cubit`.
  final Widget? child;

  /// Whether or not the `cubit` being provided should be lazily created.
  /// Defaults to `true`.
  final bool? lazy;

  final Dispose<T>? _dispose;

  final Create<T> _create;

  /// Method that allows widgets to access a `cubit` instance as long as their
  /// `BuildContext` contains a [CubeProvider] instance.
  ///
  /// If we want to access an instance of `CubitA` which was provided higher up
  /// in the widget tree we can do so via:
  ///
  /// ```dart
  /// CubitProvider.of<CubitA>(context)
  /// ```
  static T of<T extends Cube?>(BuildContext context) {
    try {
      return Provider.of<T>(context, listen: false);
    } on ProviderNotFoundException catch (e) {
      if (e.valueType != T) rethrow;
      throw FlutterError(
        '''
CubeProvider.of() called with a context that does not contain a Cube of type $T.
No ancestor could be found starting from the context that was passed to CubitProvider.of<$T>().

This can happen if the context you used comes from a widget above the CubitProvider.

The context used was: $context
        ''',
      );
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return InheritedProvider<T>(
      lazy: lazy,
      create: _create,
      dispose: _dispose,
      child: child,
    );
  }
}

extension CubeProviderExtension on BuildContext {
  /// Performs a lookup using the `BuildContext` to obtain
  /// the nearest ancestor `Cube` of type [C].
  ///
  /// Calling this method is equivalent to calling:
  ///
  /// ```dart
  /// CubeProvider.of<C>(context)
  /// ```
  C cube<C extends Cube?>() => CubeProvider.of<C>(this);
}
