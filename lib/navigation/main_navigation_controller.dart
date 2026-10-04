import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainNavigationProvider =
NotifierProvider<MainNavigationController, int>(
  MainNavigationController.new,
);

class MainNavigationController extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void selectTab(int index) {
    state = index;
  }
}