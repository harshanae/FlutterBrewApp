import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown.shade100,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.brown,
          size: 50,
        ),
      ),
    );
  }
}
