import 'dart:async';

enum CounterEvent { Increment, Decrement }

class CounterBloc {
  int counter = 0;

  final StreamController<CounterEvent> _eventController =
      StreamController<CounterEvent>();
  StreamSink get eventSink => _eventController.sink;

  final StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _counterSink => _counterController.sink;
  Stream<int> get counterStream => _counterController.stream;

  CounterBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    event == CounterEvent.Increment ? counter++ : counter--;
    _counterSink.add(counter);
  }

  void dispose() {
    _eventController.close();
    _counterController.close();
  }
}
