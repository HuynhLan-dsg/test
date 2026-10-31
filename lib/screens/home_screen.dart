import 'package:flutter/material.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Smart Library"),
      ),

      drawer: Drawer(
        child: ListView(
          children: [

            const UserAccountsDrawerHeader(
              accountName:
                  Text("Administrator"),

              accountEmail:
                  Text(
                "admin@gmail.com",
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.category,
              ),

              title:
                  const Text(
                "Danh mục",
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.book,
              ),

              title:
                  const Text(
                "Sách",
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.logout,
              ),

              title:
                  const Text(
                "Đăng xuất",
              ),
            ),
          ],
        ),
      ),

      body: const CategoryScreen(),
    );
  }
}