import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/router/router.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Map<ERoutes, IconData> routesDictionary = {
    ERoutes.database: Icons.data_saver_off,
    ERoutes.tables: Icons.table_view,
    ERoutes.structure: Icons.table_rows,
    ERoutes.query: Icons.table_chart,
    ERoutes.about: Icons.accessibility_outlined,
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
          ...routesDictionary.entries
              .map((route) => CustomListTile(route: route))
              .toList()
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.route,
    Key? key,
  }) : super(key: key);

  final MapEntry<ERoutes, IconData> route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        minLeadingWidth: 10,
        leading: Icon(
          route.value,
          color: Colors.white,
        ),
        title: Text(route.key.name.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        onTap: () => context.go("/${route.key.name}"));
  }
}
