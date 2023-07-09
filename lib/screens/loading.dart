import 'package:flutter/material.dart';
import 'dart:async';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

enum IconType { sunny, snowing, cloud }

class _LoadingState extends State<Loading> {
  IconType _currentIcon = IconType.sunny;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        switch (_currentIcon) {
          case IconType.sunny:
            _currentIcon = IconType.snowing;
            break;
          case IconType.snowing:
            _currentIcon = IconType.cloud;
            break;
          case IconType.cloud:
            _currentIcon = IconType.sunny;
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  IconData _getIconData(IconType iconType) {
    switch (iconType) {
      case IconType.sunny:
        return Icons.sunny;
      case IconType.snowing:
        return Icons.snowing;
      case IconType.cloud:
        return Icons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Icon(
            _getIconData(_currentIcon),
            size: 90,
          ),
        );
  }
}