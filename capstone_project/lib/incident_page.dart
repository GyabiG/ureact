import 'package:capstone_project/patient_page.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/create_test_page.dart';
import 'package:capstone_project/patient_page.dart';
import 'package:capstone_project/tests_page.dart';
import 'package:capstone_project/models/incident.dart';
import 'package:capstone_project/api/incident_api.dart';

class IncidentPage extends StatefulWidget {
  const IncidentPage({super.key, this.iID = -1});
  final int iID;

  @override
  State<IncidentPage> createState() => _IncidentPage();
}

class _IncidentPage extends State<IncidentPage> {
  late Incident incident;
  final TextEditingController _date = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  bool editMode = false;
  String mode = 'Edit';

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Baseline", child: Text("Baseline")),
      const DropdownMenuItem(value: "Concussion", child: Text("Concussion")),
    ];
    return menuItems;
  }

  Future<dynamic> getIncident(int iID) async {
    try {
      dynamic jsonIncident = await get(iID);
      incident = Incident.fromJson(jsonIncident[0]);
      return incident;
    } catch (e) {
      print("Error fetching incidents: $e");
    }
  }

  Future<dynamic> updateIncident(
      int iID, Map<String, dynamic> saveIncident) async {
    try {
      await update(iID, saveIncident);
    } catch (e) {
      print("Error updating incident: $e");
    }
  }

  Widget incidentPageContent(
      BuildContext context, Incident incident, String selectedValue) {
    _date.text = incident.iDate.toString();
    _notes.text = incident.iNotes!;
    return MaterialApp(
      title: 'Incident',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Incident'),
          centerTitle: true,
          leading: BackButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientPage(pID: incident.pID),
              ),
            );
          }),
          actions: <Widget>[
            if (editMode)
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                ),
                onPressed: () {
                  delete(incident.iID);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IncidentPage(iID: widget.iID),
                    ),
                  );
                },
              ),
            TextButton(
              onPressed: () {
                if (!editMode) {
                  setState(() {
                    mode = 'Save';
                    editMode = true;
                  });
                } else if (editMode) {
                  editMode = false;

                  var saveIncident = {
                    "iName": selectedValue,
                    "iDate": _date.text,
                    "iNotes": _notes.text,
                    "pID": incident.pID
                  };
                  setState(() {
                    mode = 'Edit';
                    updateIncident(incident.iID, saveIncident);
                  });
                }
              },
              child: Text(mode),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: DropdownButtonFormField(
                  disabledHint: Text(selectedValue),
                  value: selectedValue,
                  items: dropdownItems,
                  onChanged: editMode
                      ? (String? value) {
                          setState(() {
                            selectedValue = value!;
                            if (editMode) {
                              incident.iName = selectedValue;
                            }
                          });
                        }
                      : null,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Type *",
                    contentPadding: EdgeInsets.all(11),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: TextField(
                  readOnly: !editMode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Date *",
                    contentPadding: EdgeInsets.all(11),
                  ),
                  controller: _date,
                  onTap: () async {
                    if (editMode) {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _date.text =
                              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                          if (editMode) {
                            incident.iDate =
                                "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                          }
                        });
                      }
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  readOnly: !editMode,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Notes",
                  ),
                  controller: _notes,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: const Text(
                  'Tests',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: incident.tests!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(incident.tests![index].tName),
                      subtitle: Text(incident.tests![index].tDate),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TestsPage(tID: incident.tests![index].tID),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTestPage(iID: widget.iID),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (editMode) {
      _date.text = incident.iDate;
      String selectedValue = incident.iName;

      return incidentPageContent(context, incident, selectedValue);
    } else {
      return FutureBuilder(
          future: getIncident(widget.iID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Incident incident = snapshot.data!;
              _date.text = incident.iDate;
              String selectedValue = incident.iName;

              return incidentPageContent(context, incident, selectedValue);
            }
          });
    }
  }
}
