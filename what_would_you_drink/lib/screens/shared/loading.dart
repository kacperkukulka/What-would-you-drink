import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:what_would_you_drink/displayData/data_colors.dart' as dc;

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dc.colorBgDark,
      child: Center(
        child: SpinKitCubeGrid(
          color: dc.colorPrimary,
          size: 50.0,
        ),
      ),
    );
  }
}