import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onSearch,
    required this.controller,
    this.onClear,
    this.elevateSearchBar = false,
  });

  final bool elevateSearchBar;
  final String hintText;
  final ValueChanged<String> onSearch;
  final VoidCallback? onClear;
  final TextEditingController controller;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: widget.controller,
      hintText: widget.hintText,

      trailing: widget.controller.text.isNotEmpty
          ? [
        IconButton(
          onPressed: () {
            widget.controller.clear();
            widget.onClear?.call();
          },
          icon: Icon(
            Icons.clear,
            color: Colors.grey.shade500,
          ),
        ),
      ]
          : null,

      leading: IconButton(
        icon: const Icon(Icons.search_outlined),
        onPressed: () {
          widget.onSearch(widget.controller.text);
        },
      ),

      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),

      side: const WidgetStatePropertyAll(
        BorderSide(
          width: 1.5,
          color: Color(0xFFBDBDBD),
        ),
      ),

      elevation: widget.elevateSearchBar
          ? const WidgetStatePropertyAll(2)
          : const WidgetStatePropertyAll(0),
    );
  }
}