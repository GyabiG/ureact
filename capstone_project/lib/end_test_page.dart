import 'dart:convert';
// import 'dart:io';
import 'package:capstone_project/start_test_page.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/test_results_page.dart';
import 'package:capstone_project/tests_page.dart';
import 'package:capstone_project/models/reactive.dart';
import 'sensor_recorder.dart';
import 'dart:async';
import 'api/test_api.dart';

class EndTestPage extends StatefulWidget {
  const EndTestPage(
      {super.key,
      required this.title,
      required this.direction,
      required this.forward,
      required this.left,
      required this.right,
      required this.backward,
      required this.tID});

  final String title;
  final String direction;

  final String forward;
  final String left;
  final String right;
  final String backward;

  final int tID;

  @override
  State<EndTestPage> createState() => _EndTestPageState();
}

class _EndTestPageState extends State<EndTestPage> {
  late String timeToStab;
  late SensorRecorder sensorRecorder;

  Future getTTS() async {
    var sensorData = sensorRecorder.endRecording();

    var decodedData = await runReactiveTestScript({
      'dataAcc': sensorData.formattedAccData(),
      'dataRot': sensorData.formattedGyrData(),
      'timeStamps': sensorData.timeStamps,
      'fs': sensorData.fs
    });

    timeToStab = decodedData['TTS'].toString();
  }

  Future<dynamic> createReactiveTest(String median) async {
    try {
      return await createReactive({
        "fTime": widget.forward,
        "rTime": widget.right,
        "lTime": widget.left,
        "bTime": widget.backward,
        "mTime": median,
        "tID": widget.tID,
      });
    } catch (e) {
      print("Error creating reactive test: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
            leading: BackButton(onPressed: () {
              Navigator.pop(context);
            }),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TestsPage(tID: -1),
                      ),
                    );
                  },
                  child: const Text('Cancel'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Directions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Text(
                    '1. Attach phone to lumbar spine',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Text(
                    '2. Press the start button',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Text(
                    '3. Lean participant until you hear the chime',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Text(
                    '4. Hold participant steady and release after 2-5 seconds',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Text(
                    '5. Press the end test button once the participant has regained their balance',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: const Text(
                    '6. Repeat for each direction',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 100, 0, 5),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Lean ${widget.direction}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              margin: const EdgeInsets.all(
                                  30), // Modify this till it fills the color properly
                              color: Colors.black54, // Color
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.pause_circle_filled_rounded,
                              color: Color.fromRGBO(255, 220, 212, 1),
                              size: 75,
                            ),
                            onPressed: () async {
                              await getTTS();
                              if (context.mounted) {
                                if (widget.direction == 'Forward') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StartTestPage(
                                        title: 'Reactive',
                                        direction: 'Right',
                                        forward: timeToStab,
                                        left: widget.left,
                                        right: widget.right,
                                        backward: widget.backward,
                                        tID: widget.tID,
                                      ),
                                    ),
                                  );
                                } else if (widget.direction == 'Right') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StartTestPage(
                                        title: 'Reactive',
                                        direction: 'Left',
                                        forward: widget.forward,
                                        left: widget.left,
                                        right: timeToStab,
                                        backward: widget.backward,
                                        tID: widget.tID,
                                      ),
                                    ),
                                  );
                                } else if (widget.direction == 'Left') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StartTestPage(
                                        title: 'Reactive',
                                        direction: 'Backward',
                                        forward: widget.forward,
                                        left: timeToStab,
                                        right: widget.right,
                                        backward: widget.backward,
                                        tID: widget.tID,
                                      ),
                                    ),
                                  );
                                } else if (widget.direction == 'Backward') {
                                  List<double> vals = [
                                    double.parse(widget.forward),
                                    double.parse(widget.left),
                                    double.parse(widget.right),
                                    double.parse(widget.backward)
                                  ];
                                  double median = (vals[1] + vals[2]) / 2;
                                  String medianString = median.toString();
                                  Reactive? createdReactive =
                                      await createReactiveTest(medianString);
                                  if (createdReactive != null &&
                                      context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TestResultsPage(
                                          forward: widget.forward,
                                          left: widget.left,
                                          right: widget.right,
                                          backward: timeToStab,
                                          median: medianString,
                                          tID: widget.tID,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    timeToStab = "";
    if (widget.forward == "0") {
      sensorRecorder = SensorRecorder("forward");
    } else if (widget.right == "0") {
      sensorRecorder = SensorRecorder("right");
    } else if (widget.left == "0") {
      sensorRecorder = SensorRecorder("left");
    } else if (widget.backward == "0") {
      sensorRecorder = SensorRecorder("backward");
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }
}
