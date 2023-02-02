import 'package:flutter/material.dart';

class CustomListViewCard extends StatelessWidget {
  CustomListViewCard({super.key, required this.leading, required this.tailingIcon, required this.leadingClick, bool? selected}) {
    this.selected = selected ?? false;
  }
  String leading;
  Widget? tailingIcon;
  bool selected = false;
  Function() leadingClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            blurStyle: BlurStyle.solid,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading, overflow: TextOverflow.ellipsis, maxLines: 1, softWrap: false, style: const TextStyle(fontSize: 24)),
          const Divider(color: Colors.white24, thickness: 1),
          selected
              ? Icon(Icons.check_circle_outline_rounded, color: Theme.of(context).colorScheme.primary)
              : GestureDetector(
                  onTap: () => leadingClick(),
                  child: tailingIcon,
                ),
        ],
      ),
    );
  }
}
