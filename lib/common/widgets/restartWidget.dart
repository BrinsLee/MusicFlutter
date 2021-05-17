import 'package:flutter/material.dart';
import 'package:music_flutter/common/routes/router.dart' as router;

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({this.child});

  @override
  _RestartWidgetState createState() => _RestartWidgetState();

  static void restartApp(BuildContext context) {
    router.navStack = ["Home"];
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }
}
