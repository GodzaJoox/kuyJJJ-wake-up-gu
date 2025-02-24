import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_food_project/Screen/order.dart';
import 'package:flutter_food_project/components/macro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart'; // ใช้สำหรับจัดการเวลาใน Timezone

class PizzaDetail extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final int discountPrice;
  final Map<String, dynamic> macros;
  final String email;


  const PizzaDetail({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.discountPrice,
    required this.macros,
    required this.email,
  });

  Future<void> placeOrder(BuildContext context) async {
    try {
      // สร้าง ID ใหม่แบบ Random โดยใช้ Firestore
      String newOrderId = FirebaseFirestore.instance.collection('orders').doc().id;

      // กำหนดเวลาประเทศไทย (GMT+7)
      final DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
      final String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      // บันทึกข้อมูลลงใน Firestore
      await FirebaseFirestore.instance.collection('orders').doc(newOrderId).set({
        'email': email,
        'name': 'Pizza ${name}',
        'image': image,
        'discountPrice': discountPrice,
        'timestamp': formattedTime,
        'orderId': newOrderId, // ฟิลด์นี้เก็บไว้ลำดับสุดท้าย
      });

      // หากบันทึกสำเร็จ
      print("Order successfully added with ID: $newOrderId");

      // ไปยังหน้าสรุปออเดอร์ (OrderScreen)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderScreen()),
      );
    } catch (e) {
      // แสดงข้อความในคอนโซลถ้ามีข้อผิดพลาด
      print("Error occurred while placing order: $e");

      // แจ้งผู้ใช้ด้วย Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
                image: DecorationImage(
                  image: AssetImage(image),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "$discountPrice Bath",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  "$price Bath",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        MacroWidget(
                          title: "Calories",
                          value: macros["calories"],
                          icon: FontAwesomeIcons.fire,
                        ),
                        const SizedBox(width: 10),
                        MacroWidget(
                          title: "Protein",
                          value: macros["protein"],
                          icon: FontAwesomeIcons.dumbbell,
                        ),
                        const SizedBox(width: 10),
                        MacroWidget(
                          title: "Fat",
                          value: macros["fat"],
                          icon: Icons.opacity,
                        ),
                        const SizedBox(width: 10),
                        MacroWidget(
                          title: "Carbs",
                          value: macros["carbs"],
                          icon: FontAwesomeIcons.breadSlice,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () => placeOrder(context),
                        style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
