import 'package:flutter/material.dart';
import 'package:derma_ai/constants/colors.dart';

class NavCard extends StatelessWidget {
  final Icon icon;
  final bool? isSelected;
  final VoidCallback onTapCallback;

  const NavCard({
    Key? key,
    required this.icon,
    this.isSelected,
    required this.onTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected != null
              ? (isSelected! ? kSelected : ksecondaryDark)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: icon,
      ),
    );
  }
}
