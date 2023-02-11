import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:ouradmin_mobile/views/custom_app_bar/custom_app_bar.dart';
import 'package:ouradmin_mobile/views/custom_drawer_view/custom_drawer_view.dart';
import 'package:ouradmin_mobile/views/databases_view/databases_view.dart';
import 'package:ouradmin_mobile/views/query_view/query_view.dart';
import 'package:ouradmin_mobile/views/server_view/server_view.dart';
import 'package:ouradmin_mobile/views/structuur_view/structuur_view.dart';
import 'package:ouradmin_mobile/views/tables_view/tables_view.dart';

enum ERoutes {
  server,
  database,
  tables,
  structure,
  query,
  about,
}

final GoRouter routerConfig = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (context, state) {
        if (state.fullpath == '/') {
          return '/server';
        }
        return null;
      },
      routes: [
        ...ERoutes.values.map(
          (route) => GoRoute(
            path: route.name,
            pageBuilder: (context, state) => NoTransitionPage<void>(
              key: state.pageKey,
              child: page(route),
            ),
          ),
        )
      ],
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: page(ERoutes.server),
      ),
    ),
  ],
);

page(ERoutes route) {
  final routes = <ERoutes, Widget>{
    ERoutes.server: ServerView(),
    ERoutes.database: DatabasesView(),
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
