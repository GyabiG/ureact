// import 'package:capstone_project/main.dart';
import 'package:capstone_project/tests_page.dart';
import 'package:capstone_project/api/test_api.dart';
import 'package:flutter/material.dart';

class StaticResultsPage extends StatefulWidget {
  const StaticResultsPage(
      {super.key,
      required this.tlSolidML,
      required this.tlFoamML,
      required this.slSolidML,
      required this.slFoamML,
      required this.tandSolidML,
      required this.tandFoamML,
      required this.tID});

  final double tlSolidML;
  final double tlFoamML;
  final double slSolidML;
  final double slFoamML;
  final double tandSolidML;
  final double tandFoamML;

  final int tID;

  @override
  State<StaticResultsPage> createState() => _StaticResultsPage();
}

class _StaticResultsPage extends State<StaticResultsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Results',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Results'),
          centerTitle: true,
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TestsPage(
                  tID: widget.tID,
                ),
              ),
            );
          }),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Administered by John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromRGBO(255, 220, 212, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: const Text(
                        'Two Leg Stance (Solid)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        widget.tlSolidML.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromRGBO(255, 220, 212, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: const Text(
                        'Two Leg Stance (Foam)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        widget.tlFoamML.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromRGBO(255, 220, 212, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: const Text(
                        'Tandem Stance (Solid)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        widget.tandSolidML.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromRGBO(255, 220, 212, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: const Text(
                        'Tandem Stance (Foam)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        widget.tandFoamML.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromRGBO(255, 220, 212, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: const Text(
                        'Single Leg Stance (Solid)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        widget.slSolidML.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: const Color.fromRGBO(255, 220, 212, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ListTile(
                      title: const Text(
                        'Single Leg Stance (Foam)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: Text(
                        widget.slFoamML.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}