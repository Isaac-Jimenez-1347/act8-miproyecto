import 'package:flutter/material.dart';
import 'package:act8/Shoes.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class HomePage extends StatelessWidget {
  final List<Map<String, String>> watches = [
    {
      "image":
          "https://raw.githubusercontent.com/Isaac-Jimenez-1347/Relojeria-TempusLux-_imgs_app_Flutter/main/reloj1.jpg",
      "brand": "TempusLux",
      "model": "Elegance",
      "tag": "watch1",
    },
    {
      "image":
          "https://raw.githubusercontent.com/Isaac-Jimenez-1347/Relojeria-TempusLux-_imgs_app_Flutter/main/reloj2.jpg",
      "brand": "TempusLux",
      "model": "Classic",
      "tag": "watch2",
    },
    {
      "image":
          "https://raw.githubusercontent.com/Isaac-Jimenez-1347/Relojeria-TempusLux-_imgs_app_Flutter/main/reloj3.jpg",
      "brand": "TempusLux",
      "model": "Sport",
      "tag": "watch3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watches", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.shopping_cart, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: watches.length,
        itemBuilder: (context, index) {
          final watch = watches[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Shoes(
                            image: watch["image"]!,
                            tag: watch["tag"]!,
                            model: watch["model"]!,
                            brand: watch["brand"]!,
                          )));
            },
            child: Hero(
              tag: watch["tag"]!,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(watch["image"]!),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        offset: Offset(0, 10))
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite_border),
                        )
                      ],
                    ),
                    Text(
                      watch["model"]!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      watch["brand"]!,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
