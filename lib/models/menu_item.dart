enum MenuItemType { sandwich, fries, drink }

class MenuItem {
  final String name;
  final double price;
  final MenuItemType type;
  final String imageUrl;
  final String description;

  const MenuItem({
    required this.name,
    required this.price,
    required this.type,
    required this.imageUrl,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
