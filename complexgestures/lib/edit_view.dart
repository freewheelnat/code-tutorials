import 'package:complexgestures/image_edit_state_bloc.dart';
import 'package:flutter/material.dart';

class EditView extends StatefulWidget {
  EditView({Key key}) : super(key: key);

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EditStateData>(
          stream: ImageEditStateBloc().editStateData,
          initialData: EditStateData(EditState.IN_PROGRESS, 0.0),
          builder: (BuildContext context, AsyncSnapshot<EditStateData> snapshot){
            double opacity = snapshot.data.value / MediaQuery.of(context).size.height;
            if (opacity > 1) {
              opacity = 1;
            }
            return Opacity(opacity: opacity, child: Container(color: Colors.red));
          },
    );
  }
}