import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class ResultPopup extends StatefulWidget {
  ResultPopup(this.queryResult, {super.key});

  Future<QueryResult> queryResult;

  @override
  State<ResultPopup> createState() => _ResultPopupState();
}

class _ResultPopupState extends State<ResultPopup> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                hasError == true ? "Error" : "Results",
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder(
                  future: widget.queryResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          hasError = true;
                        });
                      });
                      return SelectableText(snapshot.error.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.bold,
                          ));
                    }
                    if (snapshot.hasData && !snapshot.hasError) {
                      if (snapshot.data == null) {
                        return const Text("No Results");
                      }
                      var data = snapshot.data!.results as List<ResultRow>;

                      var rows = data.map((e) => e.fields.values.toList()).toList();
                      var columns = data[0].fields.keys.map((e) => DataColumn(label: Text(e))).toList();

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              border: TableBorder.all(color: Theme.of(context).colorScheme.primary, width: 2),
                              columns: columns,
                              rows: rows
                                  .map((e) => DataRow(
                                      cells: e
                                          .map((e) => DataCell(
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(e.toString()),
                                                ),
                                              ))
                                          .toList()))
                                  .toList()),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => closePopup(context),
                child: const Text("Close", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ));
  }

  saveChanges(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return;
    closePopup(context);
  }

  closePopup(BuildContext context) {
    Navigator.pop(context);
  }
}

class QueryResult {
  late bool hasData;
  dynamic results;

  QueryResult({required this.results}) {
    if (results != null) {
      hasData = true;
    } else {
      hasData = false;
    }
  }
}
