import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'cube_provider.dart';

/// {@template multicubeprovider}
/// Merges multiple [CubeProvider] widgets into one widget tree.
///
/// [MultiCubeProvider] improves the readability and eliminates the need
/// to nest multiple [CubeProvider]s.
///
/// By using [MultiCubeProvider] we can go from:
///
/// ```dart
/// CubeProvider<CubeA>(
///   create: (_) => CubeA(),
///   child: CubeProvider<CubeB>(
///     create: (_) => CubeB(),
///     child: CubeProvider<CubeC>(
///       create: (_) => CubeC(),
///       child: ChildA(),
///     )
///   )
/// )
/// ```
///
/// to:
///
/// ```dart
/// MultiCubeProvider(
///   providers: [
///     CubeProvider<CubeA>(
///       create: (_) => CubeA(),
///     ),
///     CubeProvider<CubeB>(
///       create: (_) => CubeB(),
///     ),
///     CubeProvider<CubeC>(
///       create: (_) => CubeC(),
///     ),
///   ],
///   child: ChildA(),
/// )
/// ```
///
/// [MultiCubeProvider] converts the [CubeProvider] list into a tree of nested
/// [CubeProvider] widgets.
/// As a result, the only advantage of using [MultiCubeProvider] is improved
/// readability due to the reduction in nesting and boilerplate.
/// {@endtemplate}
class MultiCubeProvider extends MultiProvider {
  /// {@macro multicubeprovider}
  MultiCubeProvider({
    Key? key,
    required List<CubeProviderSingleChildWidget> providers,
    required Widget child,
  })  : assert(providers != null),
        assert(child != null),
        super(key: key, providers: providers, child: child);
}
