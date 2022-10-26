import 'package:flutter/material.dart';

class MenuItems extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  const MenuItems(
      {Key? key,
      required this.icon,
      required this.isActive,
      required this.onPressed})
      : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      color: isHovered
          ? Colors.white.withOpacity(0.1)
          : widget.isActive
              ? Colors.white.withOpacity(0.1)
              : Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true),
              onExit: (_) => setState(() => isHovered = false),
              child: Icon(widget.icon, color: Colors.white.withOpacity(0.9)),
            ),
          ),
        ),
      ),
    );
  }
}
