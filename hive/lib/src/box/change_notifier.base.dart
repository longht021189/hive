part of 'change_notifier.dart';

class _ChangeNotifierImpl implements ChangeNotifier {
  final StreamController<BoxEvent> _streamController;

  _ChangeNotifierImpl() 
    : _streamController = StreamController<BoxEvent>.broadcast();

  _ChangeNotifierImpl.debug(this._streamController);

  @override
  void notify(Frame frame) {
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
}

class _DefaultFactory implements ChangeNotifierFactory {
  @override
  ChangeNotifier create() {
    return _ChangeNotifierImpl();
  }

  @override
  ChangeNotifier debug(StreamController<BoxEvent> controller) {
    return _ChangeNotifierImpl.debug(controller);
  }
}
