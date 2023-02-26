import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ouradmin_mobile/bloc/databases/databases_bloc.dart';
import 'router/router.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  await GetStorage.init();
  ErrorWidget.builder = (FlutterErrorDetails details) => Center(
        child: Text(
          details.exceptionAsString(),
          style: const TextStyle(color: Colors.red),
        ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseBloc(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.brown),
        routerConfig: routerConfig,
      ),
    );
  }
}
