import 'package:flutter/material.dart';
import 'package:ouradmin_mobile/domein/database.dart';

import 'edit_database_popup.dart';

class DatabaseListViewCard extends StatefulWidget {
  DatabaseListViewCard({super.key});
  Database? database;

  @override
  State<DatabaseListViewCard> createState() => _DatabaseListViewCard();
}

class _DatabaseListViewCard extends State<DatabaseListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("<database>", overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: TextStyle(fontSize: 24)),
          const Divider(color: Colors.white24, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "<host>",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => showBottomSheet(
                    context: context,
                    builder: ((context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: DatabasePopup(database: widget.database),
                          ),
                        ))),
                child: const Icon(Icons.settings),
              ),
            ],
          )
        ],
      ),
    );
  }
}
