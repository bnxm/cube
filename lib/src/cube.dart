import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

abstract class Cube {
  // bool _didCreate = false;

  /// Called at the exact moment that the widget is allocated in memory.
  /// Do not overwrite this method.
  @nonVirtual
  void onCreate() {
    // if (!_didCreate) {
      onInit();
      SchedulerBinding.instance?.addPostFrameCallback((_) => onReady());
      // _didCreate = true;
    // }
  }

  /// Called Called immediately after the widget is allocated in memory.
  void onInit() {}

  /// Called after rendering the screen. It is the perfect place to enter navigation events,
  /// be it snackbar, dialogs, or a new route.
  void onReady() {}

  /// Called before the onDelete method. dispose is used to close events
  /// before the controller is destroyed, such as closing streams, for example.
  void dispose() {}
}

