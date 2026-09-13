import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onSearch,
    this.elevateSearchBar = false,
  });

  final bool elevateSearchBar;
  final String hintText;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText,
      leading: IconButton(
        icon: const Icon(Icons.search_outlined),
        onPressed: onSearch,
      ),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      side:WidgetStatePropertyAll(
        BorderSide(
          width: 1.5,
            color: const Color(0xFFBDBDBD),
        ),
      ),
      elevation: elevateSearchBar ? const WidgetStatePropertyAll(2): const WidgetStatePropertyAll(0),
    );
  }
}
