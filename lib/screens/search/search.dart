import 'package:flutter/material.dart';

import '../../widgets/custom_search_bar.dart';
import '../../widgets/options_tab.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  late String? selectedTabOption;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          CustomSearchBar(
            controller: _searchController,
            hintText: "Search recipes and users",
            onSearch: (query) {print(query);},
          ),
          OptionsTabs(options: ["Recipe","User"], changeValue: (String value) {
            setState(() {
              selectedTabOption = value;
            });
          },),
          // Expanded(
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //
          //     }),
          // )

        ],
      ),
    );
  }
}