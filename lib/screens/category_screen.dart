import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,

      padding: const EdgeInsets.all(10),

      children: [

        _buildCategory(
          title: "CNTT",
          image:
              "assets/book.jpg",
        ),

        _buildCategory(
          title: "Kinh Tế",
          image:
              "assets/book.jpg",
        ),

        _buildCategory(
          title: "Ngoại Ngữ",
          image:
              "assets/book.jpg",
        ),

        _buildCategory(
          title: "Marketing",
          image:
              "assets/book.jpg",
        ),
      ],
    );
  }

  Widget _buildCategory({
    required String title,
    required String image,
  }) {
    return Card(

      elevation: 5,

      child: Column(
        children: [

          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.all(8),

            child: Text(
              title,

              style:
                  const TextStyle(
                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}