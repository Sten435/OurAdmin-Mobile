import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/bloc/databases/databases_bloc.dart';

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
    final isServerSelected = context.read<DatabaseBloc>().state.connectionInfo != null;
    final isDatabaseSelected = context.read<DatabaseBloc>().state.selectedDatabase != null;
    final isTableSelected = context.read<DatabaseBloc>().state.selectedTable != null;

    bool _isEnabled() {
      if (route.key == ERoutes.database && !isServerSelected) {
        return false;
      }

      if (route.key == ERoutes.tables && !isDatabaseSelected) {
        return false;
      }

      if (route.key == ERoutes.structure && !isTableSelected) {
        return false;
      }

      return true;
    }

    Color _isEnabledColor() {
      final color = Colors.grey.withOpacity(.4);
      if (route.key == ERoutes.database && !isServerSelected) {
        return color;
      }

      if (route.key == ERoutes.tables && !isDatabaseSelected) {
        return color;
      }

      if (route.key == ERoutes.structure && !isTableSelected) {
        return color;
      }

      return selected ? Colors.white : Colors.white;
    }

    return ListTile(
      enabled: _isEnabled(),
      selected: selected,
      minLeadingWidth: 10,
      leading: Icon(
        route.value,
        color: _isEnabledColor(),
      ),
      title: Text(route.key.name.toUpperCase(),
          style: TextStyle(
            color: _isEnabledColor(),
            fontWeight: selected ? FontWeight.bold : FontWeight.w600,
            fontSize: 20,
          )),
      onTap: () {
        context.go('/${route.key.name}');
      },
    );
  }
}
