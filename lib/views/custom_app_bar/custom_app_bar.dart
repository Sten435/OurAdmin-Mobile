import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../databases_view/widgets/edit_database_popup.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = GoRouter.of(context).location;
    return AppBar(
      title: const Text(
        "<DB>",
        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        if (["/database", "/"].contains(route))
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => showBottomSheet(
                context: context,
                builder: ((context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: DatabasePopup(),
                      ),
                    ))),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
