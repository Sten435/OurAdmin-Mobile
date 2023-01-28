import 'package:flutter/material.dart';
import 'package:ouradmin_mobile/domein/database.dart';

import 'custom_input.dart';

class DatabasePopup extends StatelessWidget {
  DatabasePopup({super.key, Database? database}) {
    if (database != null) {
      this.database = database;
    }
  }
  Database? database;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomInput("Hostname", initialValue: database?.getConnectionInfo().host),
              const SizedBox(height: 20),
              CustomInput("Database", initialValue: database?.name),
              const SizedBox(height: 20),
              CustomInput("User", initialValue: database?.getConnectionInfo().username),
              const SizedBox(height: 20),
              CustomInput("Password", initialValue: database?.getConnectionInfo().password),
              const SizedBox(height: 20),
              CustomInput("Port", numberOnly: true, initialValue: database?.getConnectionInfo().port.toString()),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => closePopup(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Close", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  ElevatedButton(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Save", style: TextStyle(fontSize: 20)),
                    ),
                    onPressed: () => saveChanges(context, formKey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveChanges(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return;
    closePopup(context);
  }

  closePopup(BuildContext context) {
    Navigator.pop(context);
  }
}
