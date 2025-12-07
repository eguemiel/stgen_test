import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stgen_test/models/menu_item.dart';
import 'package:stgen_test/providers/cart_provider.dart';
import 'package:stgen_test/providers/filtered_menu_provider.dart';
import 'package:stgen_test/providers/menu_filter_provider.dart';
import 'package:stgen_test/widgets/menu_item_card.dart';

import 'cart_screen.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = ref.watch(filteredMenuProvider);
    final currentFilter = ref.watch(menuFilterProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GOOD HAMBURGER'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body:
          filteredItems.isLoading && filteredItems.value == null
              ? const Center(child: Text('Loading...'))
              : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Expanded(
                          child: FilterChip(
                            label: const Text('All'),
                            selected: currentFilter == MenuFilter.all,
                            onSelected: (_) {
                              ref.read(menuFilterProvider.notifier).state =
                                  MenuFilter.all;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilterChip(
                            label: const Text('Sandwiches'),
                            selected: currentFilter == MenuFilter.sandwiches,
                            onSelected: (_) {
                              ref.read(menuFilterProvider.notifier).state =
                                  MenuFilter.sandwiches;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilterChip(
                            label: const Text('Extras'),
                            selected: currentFilter == MenuFilter.extras,
                            onSelected: (_) {
                              ref.read(menuFilterProvider.notifier).state =
                                  MenuFilter.extras;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredItems.value?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item =
                            filteredItems.value?.elementAt(index) ??
                            MenuItem(
                              name: '',
                              price: 0,
                              type: MenuItemType.sandwich,
                              imageUrl: '',
                              description: '',
                            );
                        return MenuItemCard(
                          item: item,
                          onTap: () {
                            final error = ref
                                .read(cartProvider.notifier)
                                .addItem(item);
                            if (error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${item.name} added to cart'),
                                  backgroundColor: Colors.green,
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
