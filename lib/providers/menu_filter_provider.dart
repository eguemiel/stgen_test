import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MenuFilter { all, sandwiches, extras }

final menuFilterProvider = StateProvider<MenuFilter>((ref) {
  return MenuFilter.all;
});
