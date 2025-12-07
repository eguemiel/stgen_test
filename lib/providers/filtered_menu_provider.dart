import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stgen_test/api/services/menu_service.dart';
import '../models/menu_item.dart';
import 'menu_filter_provider.dart';

final filteredMenuProvider = FutureProvider<List<MenuItem>>((ref) async {
  final filter = ref.watch(menuFilterProvider);

  switch (filter) {
    case MenuFilter.sandwiches:
      return (await MenuService().fetchMenu())
          .where((item) => item.type == MenuItemType.sandwich)
          .toList();
    case MenuFilter.extras:
      return (await MenuService().fetchMenu())
          .where(
            (item) =>
                item.type == MenuItemType.drink ||
                item.type == MenuItemType.fries,
          )
          .toList();
    case MenuFilter.all:
    default:
      return (await MenuService().fetchMenu());
  }
});
