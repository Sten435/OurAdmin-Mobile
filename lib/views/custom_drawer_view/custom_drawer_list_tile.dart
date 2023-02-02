import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/router.dart';

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile({
    Key? key,
    required this.route,
    required this.selected,
  }) : super(key: key);

  final MapEntry<ERoutes, IconData> route;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        selected: selected,
        selectedTileColor: Colors.brown.shade600,
        minLeadingWidth: 10,
        leading: Icon(
          route.value,
          color: selected ? Colors.brown.shade400 : Colors.white,
        ),
        title: Text(route.key.name.toUpperCase(),
            style: TextStyle(
              color: selected ? Colors.brown.shade400 : Colors.white,
              fontWeight: selected ? FontWeight.bold : FontWeight.w600,
              fontSize: 20,
            )),
        onTap: () => context.go('/${route.key.name}'));
  }
}
