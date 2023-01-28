import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ouradmin_mobile/views/databases_view/widgets/database_list_view_card.dart';

class DatabasesView extends StatelessWidget {
  const DatabasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DatabaseListViewCard(),
        DatabaseListViewCard(),
        DatabaseListViewCard(),
        DatabaseListViewCard(),
        DatabaseListViewCard(),
        DatabaseListViewCard(),
      ],
    );
  }
}
