import 'dart:async';

import 'package:hive/hive.dart';
import 'package:hive/src/binary/frame.dart';
import 'package:meta/meta.dart';

part 'change_notifier.base.dart';

/// Not part of public API
abstract class ChangeNotifier {
  /// Not part of public API
  factory ChangeNotifier() => _factory.create();

  /// Not part of public API
  @visibleForTesting
  factory ChangeNotifier.debug(
    StreamController<BoxEvent> controller
  ) => _factory.debug(controller);

  /// Not part of public API
  void notify(Frame frame);

  /// Not part of public API
  Stream<BoxEvent> watch({dynamic key});

  /// Not part of public API
  Future<void> close();

  /// Not part of public API
  static ChangeNotifierFactory _factory = _DefaultFactory();

  /// Not part of public API
  static void updateFactory(ChangeNotifierFactory factory) {
    if (factory != null) {
      _factory = factory;
    }
  }
}

/// Not part of public API
abstract class ChangeNotifierFactory {
  /// Not part of public API
  ChangeNotifier create();

  /// Not part of public API
  ChangeNotifier debug(StreamController<BoxEvent> controller);
}