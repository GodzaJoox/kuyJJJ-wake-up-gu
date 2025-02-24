import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_project/Screen/pizza_detail.dart';

class ShopScreen extends StatelessWidget {
  final String? email; // รับ email จากหน้าหลัก

  const ShopScreen({super.key, required this.email});

  final List<Map<String, dynamic>> pizzas = const [
    {
      "name": "Hawaiian",
      "image": "assets/images/Hawaiian.png",
      "price": 399,
      "discountPrice": 299,
      "macros": {"calories": 280, "protein": 14, "fat": 9, "carbs": 35},
      "description": "Hawaiian pizza lovers will enjoy the sweet and savory flavor!",
      "isVeg":  true,
      "isBALANCE": true
    },
    {
      "name": "Pepperoni",
      "image": "assets/images/Pepperoni.png",
      "price": 429,
      "discountPrice": 349,
      "macros": {"calories": 320, "protein": 16, "fat": 14, "carbs": 38},
      "description": "Classic Pepperoni pizza with a burst of flavors.",
      "isVeg":  false,
      "isBALANCE": false
    },
    {
      "name": "Margherita",
      "image": "assets/images/Margherita.png",
      "price": 379,
      "discountPrice": 289,
      "macros": {"calories": 260, "protein": 12, "fat": 8, "carbs": 33},
      "description": "Simple yet delicious Margherita pizza.",
      "isVeg":  true,
      "isBALANCE": true
    },
    {
      "name": "BBQ Chicken",
      "image": "assets/images/BBQChicken.png",
      "price": 449,
      "discountPrice": 359,
      "macros": {"calories": 300, "protein": 18, "fat": 10, "carbs": 36},
      "description": "Smoky BBQ Chicken pizza for meat lovers.",
      "isVeg":  true,
      "isBALANCE": false
    },
    {
      "name": "Veggie",
      "image": "assets/images/Veggie.png",
      "price": 359,
      "discountPrice": 279,
      "macros": {"calories": 240, "protein": 10, "fat": 6, "carbs": 32},
      "description": "Healthy and tasty Veggie pizza.",
      "isVeg":  true,
      "isBALANCE": true
    },
    {
      "name": "Meat Lovers",
      "image": "assets/images/MeatLovers.png",
      "price": 469,
      "discountPrice": 389,
      "macros": {"calories": 350, "protein": 20, "fat": 18, "carbs": 40},
      "description": "Loaded with meats for the ultimate experience.",
      "isVeg":  true,
      "isBALANCE": true
    },
    {
      "name": "Cheese",
      "image": "assets/images/Cheese.png",
      "price": 389,
      "discountPrice": 319,
      "macros": {"calories": 270, "protein": 13, "fat": 9, "carbs": 34},
      "description": "Rich and creamy cheese pizza.",
      "isVeg":  false,
      "isBALANCE": false
    },
    {
      "name": "Supreme",
      "image": "assets/images/Supreme.png",
      "price": 489,
      "discountPrice": 399,
      "macros": {"calories": 330, "protein": 17, "fat": 12, "carbs": 39},
      "description": "Supreme pizza with everything you love.",
      "isVeg":  true,
      "isBALANCE": false

    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                "assets/images/pizzalogo.png",
                scale: 15,
              ),
              const SizedBox(width: 10),
              const Text(
                "PIZZA",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.keyboard_tab))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 9 / 16),
            itemCount: pizzas.length,
            itemBuilder: (context, int i) {
              return Material(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDetail(
                          name: pizzas[i]["name"],
                          image: pizzas[i]["image"],
                          price: pizzas[i]["price"],
                          discountPrice: pizzas[i]["discountPrice"],
                          macros: pizzas[i]["macros"],
                          email: email!, // ส่ง email ไปด้วย
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(pizzas[i]["image"]!),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: pizzas[i]["isVeg"] ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: Text(
                                  pizzas[i]["isVeg"] ? "VEG" : "NOT VEG",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: pizzas[i]["isBALANCE"] ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child:  Padding(
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: Text(
                                  pizzas[i]["isBALANCE"] ? "BALANCE" : "NOT BALANCE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          pizzas[i]["name"]!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          pizzas[i]["description"]!,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${pizzas[i]["discountPrice"]} Bath",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${pizzas[i]["price"]} Bath",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                      decorationThickness: 2.0,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_circle))
                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
