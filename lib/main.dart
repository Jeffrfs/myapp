import 'package:flutter/material.dart';
import 'models/food.dart';
import 'services/food_service.dart';
import 'food_detail_page.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FoodListPage(),
    );
  }
}

class FoodListPage extends StatelessWidget {
  final FoodService foodService = FoodService();

  FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> barcodes = [
  '3017620422003', // Nutella
  '737628064502',  // Coca-Cola
  '8851661250455', // M&M's
  '0660920329513', // Oreo Cookies
  '0010082071418', // Peanut Butter
  '021000000145',  // Kraft Macaroni & Cheese
  '028400050464',  // Doritos
  '5449000100483', // Fanta Orange
  '028400020020',  // Lay's Potato Chips
  '7610500244188', // Toblerone
];


    return Scaffold(
      appBar: AppBar(title: Text('Food List')),
      body: FutureBuilder<List<Food?>>(
        future: foodService.fetchFoods(barcodes),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Data Found'));
          } else {
            final foods = snapshot.data!;
            return ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                final food = foods[index];
                if (food == null) {
                  return ListTile(title: Text('Food not found'));
                }
                return ListTile(
                  title: Text(food.name),
                  leading: Image.network(food.imageUrl, width: 50, height: 50),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailPage(food: food),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
