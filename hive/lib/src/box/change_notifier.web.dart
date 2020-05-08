import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:hive/src/binary/frame.dart';
import 'change_notifier.dart';

class WebChangeNotifier implements ChangeNotifier {
  final StreamController<BoxEvent> _streamController;

  WebChangeNotifier() 
    : _streamController = StreamController<BoxEvent>.broadcast();

  WebChangeNotifier.debug(this._streamController);

  @override
  void notify(Frame frame) {
    window.localStorage;
    _streamController.add(BoxEvent(frame.key, frame.value, frame.deleted));
  }

  @override
  Stream<BoxEvent> watch({dynamic key}) {
    if (key != null) {
      return _streamController.stream.where((it) => it.key == key);
    } else {
      return _streamController.stream;
    }
  }

  @override
  Future<void> close() {
    return _streamController.close();
  }

  static final _id = '${Random.secure().nextDouble()}_${DateTime.now()}';
}

class WebChangeNotifierFactory implements ChangeNotifierFactory {
  @override
  ChangeNotifier create() {
    return WebChangeNotifier();
  }

  @override
  ChangeNotifier debug(StreamController<BoxEvent> controller) {
    return WebChangeNotifier.debug(controller);
  }
}
