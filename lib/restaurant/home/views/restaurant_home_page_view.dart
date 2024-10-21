import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/core.dart';
import '/domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantHomePageView extends StatefulWidget {
  const RestaurantHomePageView({super.key});

  @override
  State<RestaurantHomePageView> createState() => _RestaurantHomePageViewState();
}

class _RestaurantHomePageViewState extends State<RestaurantHomePageView> {
  final List<_MenuItem> menuItems = [
    _MenuItem(
      title: "Restoran Ekle",
      icon: Icons.add_business,
      onTap: (context) => context.push(AppRouteName.addRestaurant.path),
    ),
    _MenuItem(
      title: "Restoran Düzenle",
      icon: Icons.edit_road,
    ),
    _MenuItem(
      title: "Menü Düzenle",
      icon: Icons.coffee,
    ),
    _MenuItem(
      title: "Yorumlarım",
      icon: Icons.comment,
    ),
    _MenuItem(
      title: "Çıkış Yap",
      icon: Icons.logout,
      onTap: (context) => _logout(context),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _RestaurantHomePageViewBody(menuItems: menuItems),
    );
  }
}

class _RestaurantHomePageViewBody extends StatelessWidget {
  final List<_MenuItem> menuItems;

  const _RestaurantHomePageViewBody({required this.menuItems, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: menuItems.map((item) => _MenuItemWidget(item: item)).toList(),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Function(BuildContext)? onTap;

  _MenuItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class _MenuItemWidget extends StatelessWidget {
  final _MenuItem item;

  const _MenuItemWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap != null ? () => item.onTap!(context) : null,
      child: Card(
        child: ListTile(
          leading: Icon(item.icon),
          title: Text(item.title),
        ),
      ),
    );
  }
}

void _logout(BuildContext context) async {
  final storageRepository = getIt<IStorageRepository>();

  await storageRepository.setToken(null);
  await storageRepository.setIsLogged(isLogged: false);

  context.go(AppRouteName.login.path);
}
