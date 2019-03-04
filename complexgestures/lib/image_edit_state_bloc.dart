import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ImageEditStateBloc {

  static final ImageEditStateBloc _singleton = new ImageEditStateBloc._internal();

  factory ImageEditStateBloc() {
    return _singleton;
  }

  ImageEditStateBloc._internal();

  BehaviorSubject<EditStateData> _editStateDataController = BehaviorSubject<EditStateData>();
  Stream<EditStateData> get editStateData => _editStateDataController.stream;

  void startEdit() {
    _editStateDataController.sink.add(EditStateData(EditState.IN_PROGRESS, 0.0));
  }

  void editInProgress(double value) {
    _editStateDataController.sink.add(EditStateData(EditState.IN_PROGRESS, value));
  }

  void finishEdit() {
    StreamSubscription sub;
    sub = editStateData.listen((editStateData) {
      if (!editStateData.isInProgress()) {
        // This should not happen. If it does, we simply cancel the editing.
        cancelEdit();
      } else {
        _editStateDataController.sink.add(EditStateData(EditState.COMPLETED, editStateData.value));
      }
      sub.cancel();
    });
  }

  void cancelEdit() {
    _editStateDataController.sink.add(EditStateData(EditState.CANCELLED, 0.0));
  }

  void dispose() {
    _editStateDataController.close();
  }

}

class EditStateData {
  final EditState _editState;
  final double value;

  EditStateData(this._editState, this.value);

  bool isInProgress() {
    return _editState == EditState.IN_PROGRESS;
  }

  bool isCanceled() {
    return _editState == EditState.CANCELLED;
  }

  bool isCompleted() {
    return _editState == EditState.COMPLETED;
  }

  String toString() {
    return _editState.toString() + " " + value.toString();
  }
}

enum EditState {
  NONE, IN_PROGRESS, COMPLETED, CANCELLED
}
