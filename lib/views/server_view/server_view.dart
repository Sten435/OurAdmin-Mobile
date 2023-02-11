import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ouradmin_mobile/custom_widgets/custom_list_view_card.dart';
import 'package:ouradmin_mobile/domein/connection_info.dart';
import 'package:ouradmin_mobile/views/alert_popups/error_popups.dart';
import 'package:ouradmin_mobile/views/alert_popups/success_popup.dart';
import 'package:ouradmin_mobile/custom_widgets/custom_input.dart';

import '../../bloc/databases/databases_bloc.dart';

class ServerView extends StatefulWidget {
  ServerView({super.key});
  Map<String, dynamic>? storedServers;

  @override
  State<ServerView> createState() => _ServerViewState();
}

class _ServerViewState extends State<ServerView> {
  @override
  void initState() {
    super.initState();
    final box = GetStorage();
    widget.storedServers = box.read("servers") as Map<String, dynamic>? ?? {};
  }

  @override
  Widget build(BuildContext context) {
    final ConnectionInfo? selectedServer = context.read<DatabaseBloc>().state.connectionInfo;
    final servers = widget.storedServers?.keys.map((e) => ConnectionInfo.fromJson(widget.storedServers![e])).toList() ?? [];

    void selectServer(ConnectionInfo? server) {
      if (server == selectedServer) server = null;
      setState(() {
        context.read<DatabaseBloc>().add(SelectedServerChanged(connectionInfo: server));
      });
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: servers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    child: CustomListViewCard(
                      leading: servers[index].host,
                      tailingIcon: const Icon(Icons.settings),
                      selected: servers[index] == selectedServer,
                      leadingClick: () => {},
                    ),
                    onTap: () => selectServer(servers[index]));
              }),
        ),
        Column(
          children: [
            const Divider(color: Colors.brown, height: 0, thickness: 2),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      openAddServerDialog(context);
                    },
                    child: const Text('Add Server', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void openAddServerDialog(BuildContext context) {
    final key = GlobalKey<FormState>();

    String hostText = "";
    String portText = "";
    String usernameText = "";
    String passwordText = "";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Server'),
            content: Form(
              key: key,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  CustomInput(
                    placeholder: "Host",
                    onChange: (String value) {
                      hostText = value.trim();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    placeholder: "Port",
                    numberOnly: true,
                    onChange: (String value) {
                      portText = value.trim();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    placeholder: "Username",
                    onChange: (String value) {
                      usernameText = value.trim();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomInput(
                    placeholder: "Password",
                    onChange: (String value) {
                      passwordText = value.trim();
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  try {
                    if (key.currentState == null || !key.currentState!.validate()) return;

                    var box = GetStorage();
                    var servers = box.read("servers") as Map<String, dynamic>?;
                    servers ??= {};

                    ConnectionInfo connectionInfo = ConnectionInfo(host: hostText, port: int.parse(portText), username: usernameText, password: passwordText);
                    servers[connectionInfo.host] = connectionInfo.toJson();

                    box.write("servers", servers).then((_) => setState(() => widget.storedServers = servers));

                    Navigator.of(context).pop();
                    showSuccessBar(context, "Server added successfully");
                  } catch (e) {
                    print(e);
                    showErrorBar(context, "Error adding server");
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
  }
}
