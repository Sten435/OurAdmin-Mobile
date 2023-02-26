import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/router/router.dart';

import 'custom_drawer_list_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Map<ERoutes, IconData> routesDictionary = {
    ERoutes.server: Icons.electrical_services_rounded,
    ERoutes.database: Icons.data_saver_off,
    ERoutes.tables: Icons.table_view,
    ERoutes.structure: Icons.table_rows,
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.brown,
      child: ListView(
        children: [
          const SizedBox(
            height: 60,
            child: Center(
              child: DrawerHeader(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "OurAdmin Mobile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.white24,
            thickness: 2,
          ),
          ...routesDictionary.entries.map((route) => CustomDrawerListTile(route: route, selected: GoRouter.of(context).location == "/${route.key.name}")).toList()
        ],
      ),
    );
  }
}
