import 'package:complexgestures/image_edit_state_bloc.dart';
import 'package:flutter/material.dart';

enum EditType {
  OPACITY
}

class EditControlsView extends StatefulWidget {
  EditControlsView({Key key}) : super(key: key);

  @override
  _EditControlsViewState createState() => _EditControlsViewState();
}

class _EditControlsViewState extends State<EditControlsView> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: EditType.OPACITY,
      childWhenDragging: _buildIconWhenDragging(),
      child: _buildIcon(),
      onDraggableCanceled: (velocity, offset) {
        ImageEditStateBloc().cancelEdit();
      },
      feedback: _buildIcon(),
    );
  }

  Widget _buildIconWhenDragging() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Icon(Icons.edit, color: Colors.grey)
    );
  }

  Widget _buildIcon() {
    return Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey,
        child: Icon(Icons.edit, color: Colors.black)
    );
  }
}