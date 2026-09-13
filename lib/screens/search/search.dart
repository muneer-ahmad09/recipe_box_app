import 'package:flutter/material.dart';

import '../../widgets/custom_search_bar.dart';
import '../../widgets/options_tab.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String? selectedTabOption;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          CustomSearchBar(
            hintText: "Search recipes and users",
            onSearch: () {},
          ),
          OptionsTabs(options: ["Recipe","User"], changeValue: (String value) {
            setState(() {
              selectedTabOption = value;
            });
          },),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {

              }),
          )

        ],
      ),
    );
  }
}