import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});


  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
    //   padding: EdgeInsets.zero,
    //   physics: const ClampingScrollPhysics(),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 3,
    //     crossAxisSpacing: 2,
    //     mainAxisSpacing: 2,
    //   ),
    //   itemCount: 50,
    //   itemBuilder: (context, index) {
    //     return _GridItem(
    //       index: index,
    //       icon: Icons.image,
    //     );
    //   },
    return Text("Saved Post");
  }
}