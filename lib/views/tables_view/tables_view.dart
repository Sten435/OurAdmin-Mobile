import 'package:flutter/material.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  final tableNames = List<String>.generate(10, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tableNames.length,
            itemBuilder: (context, index) {
              final tableName = tableNames[index];
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      blurStyle: BlurStyle.solid,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(tableName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                    onPressed: () => openConformationDialog(context, tableName),
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(color: Colors.brown, height: 0, thickness: 2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            onPressed: () => opennewTableDialog(context),
            child: const Text('Add Table', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }

  openConformationDialog(BuildContext context, String tableName) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Table'),
          content: Text('Are you sure you wanna delete:\n\n\n- $tableName'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  tableNames.remove(tableName);
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  opennewTableDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        final textRef = TextEditingController();
        return AlertDialog(
          title: const Text('Add Table'),
          // ignore: prefer_const_constructors
          content: TextField(
            controller: textRef,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Table Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  tableNames.add(textRef.text);
                });
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
