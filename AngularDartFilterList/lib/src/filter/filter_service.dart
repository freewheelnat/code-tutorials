import 'dart:async';

class FilterService {

  StreamController<String> _filterValueEvents = StreamController.broadcast<String>();

  void updateSearch(String str) async {
    _filterValueEvents.add(str);
  }

  Stream<String> getFilterEvents() {
    return _filterValueEvents.stream;
  }

}