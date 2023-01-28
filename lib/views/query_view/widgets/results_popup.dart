import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class ResultPopup extends StatelessWidget {
  ResultPopup(this.queryResult, {super.key});

  Future<QueryResult> queryResult;

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
            const Text("Result"),
            Expanded(
              child: FutureBuilder(
                future: queryResult,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    throw snapshot.error.toString();
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data == null) return const Text("No Results");
                    var data = snapshot.data!.results as List<ResultSetRow>;
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data[index].assoc().toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.brown,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: data.length);
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
      ),
    );
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
  bool hasData;
  dynamic results;

  QueryResult({required this.hasData, required this.results});
}
