import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/databases/databases_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = GoRouter.of(context).location;
    return BlocBuilder(
      bloc: context.read<DatabaseBloc>(),
      builder: (context, DatabaseState state) {
        var title = state.selectedDatabase?.name;
        var table = state.selectedTable?.name;
        return AppBar(
          title: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title ?? 'Select a database'),
                Text(table ?? 'Select a table', style: const TextStyle(fontSize: 12)),
              ],
            ),
            onTap: () {
              if (route != '/') {
                GoRouter.of(context).go('/');
              }
            },
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
