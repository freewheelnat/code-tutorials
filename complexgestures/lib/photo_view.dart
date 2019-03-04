import 'package:complexgestures/edit_controls_view.dart';
import 'package:complexgestures/edit_view.dart';
import 'package:complexgestures/image_edit_state_bloc.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatelessWidget {
  PhotoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget(
        onAccept: (EditType type) {
          ImageEditStateBloc().finishEdit();
        },
        onWillAccept: (EditType type) {
          ImageEditStateBloc().startEdit();
          return true;
        },
        builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
            ) {
          return StreamBuilder<EditStateData>(
            stream: ImageEditStateBloc().editStateData,
            initialData: EditStateData(EditState.NONE, 0.0),
            builder: (BuildContext context, AsyncSnapshot<EditStateData> snapshot){
              if (snapshot.data.isInProgress()) {
                return Stack(
                    children: <Widget> [
                      Center(child: _buildImage()),
                      Center(child: EditView()),
                    ]);
              } else {
                return _buildImage();
              }
            },
          );
        }
    );
  }

  Widget _buildImage() {
    return Image.network("https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png");
  }
}
