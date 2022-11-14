import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Connect extends StatefulWidget {
  final Widget child;

  const Connect({Key? key, required this.child}) : super(key: key);
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      debounceDuration: Duration.zero,
      connectivityBuilder: (context, connectivity, child) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/images/no-internet-animation.gif",
                    width: 300,
                    height: 300,
                  ),
                  const Text(
                    'You are offline',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w200),
                  ),
                  Text(
                    'Please check your internet connection and try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          );
        }
        return child;
      },
      child: widget.child,
    );
  }
}
