import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_bar_index.g.dart';

@riverpod
class NavigationBarIndex extends _$NavigationBarIndex {
  int build() {
    return 0;
  }

  void move(int index) {
    state = index;
  }
}
