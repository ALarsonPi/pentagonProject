import 'package:flutter/material.dart';
import 'package:polygon/polygon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dynamic Pentagons'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double topValue = 1;
  double rightValue = 1;
  double bottomRightValue = 1;
  double bottomLeftValue = 1;
  double leftValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          // Here's the entire gridview
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 0.0,
                crossAxisCount: 3,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Top Value:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Slider(
                          value: topValue,
                          max: 100,
                          divisions: 100,
                          label: topValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              topValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Right Value:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Slider(
                          value: rightValue,
                          max: 100,
                          divisions: 100,
                          label: rightValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              rightValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Bottom Right:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Slider(
                          value: bottomRightValue,
                          max: 100,
                          divisions: 100,
                          label: bottomRightValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              bottomRightValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Bottom Left:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Slider(
                          value: bottomLeftValue,
                          max: 100,
                          divisions: 100,
                          label: bottomLeftValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              bottomLeftValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Left Value:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Slider(
                          value: leftValue,
                          max: 100,
                          divisions: 100,
                          label: leftValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              leftValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Here's the stack with both pentagons
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: PentagonPainter(
                        top: 100,
                        right: 100,
                        bottomRight: 100,
                        bottomLeft: 100,
                        left: 100,
                        fillColor: Colors.yellow.shade400,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: PentagonPainter(
                        top: topValue,
                        right: rightValue,
                        bottomRight: bottomRightValue,
                        bottomLeft: bottomLeftValue,
                        left: leftValue,
                        fillColor: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PentagonPainter extends CustomPainter {
  double top;
  double right;
  double bottomRight;
  double bottomLeft;
  double left;
  Color fillColor;
  PentagonPainter(
      {required this.top,
      required this.right,
      required this.bottomLeft,
      required this.bottomRight,
      required this.left,
      required this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    double proportionTop = top / 100;
    double proportionRight = right / 100;
    double proportionBottomRight = bottomRight / 100;
    double proporitionBottomLeft = bottomLeft / 100;
    double proportionLeft = left / 100;

    var polygon = Polygon([
      Offset(0, -1 * proportionTop),
      Offset(-1 * proportionLeft, -0.15 * proportionLeft),
      Offset(-0.6 * proporitionBottomLeft, 1 * proporitionBottomLeft),
      Offset(0.6 * proportionBottomRight, 1 * proportionBottomRight),
      Offset(1 * proportionRight, -0.15 * proportionRight),
    ]);

    canvas.drawPath(
      polygon.computePath(rect: Offset.zero & size),
      Paint()..color = fillColor,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      1,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
