import 'package:flutter/material.dart';
import 'models/food.dart';

class FoodDetailPage extends StatelessWidget {
  final Food food;

  const FoodDetailPage({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(food.imageUrl),
            SizedBox(height: 20),
            Text(food.name, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
