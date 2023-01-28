import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ouradmin_mobile/views/custom_app_bar/custom_app_bar.dart';
import 'package:ouradmin_mobile/views/custom_drawer_view/custom_drawer_view.dart';
import 'package:ouradmin_mobile/views/databases_view/databases_view.dart';
import 'package:ouradmin_mobile/views/query_view/query_view.dart';
import 'package:ouradmin_mobile/views/structuur_view/structuur_view.dart';
import 'package:ouradmin_mobile/views/tables_view/tables_view.dart';

enum ERoutes {
  database,
  tables,
  structure,
  query,
  about,
}

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return page(ERoutes.database);
      },
    ),
    ...ERoutes.values.map((route) => GoRoute(
        path: '/${route.name}',
        builder: (BuildContext context, GoRouterState state) {
          return page(route);
        })),
  ],
);

page(ERoutes route) {
  final routes = <ERoutes, Widget>{
    ERoutes.database: const DatabasesView(),
    ERoutes.tables: const TablesView(),
    ERoutes.structure: const StructuurView(),
    ERoutes.query: QueryView(),
    ERoutes.about: const Text("about"),
  };

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.brown,
    statusBarIconBrightness: Brightness.light,
  ));

  return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: routes[route]!,
    ),
  );
}
