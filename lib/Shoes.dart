import 'package:flutter/material.dart';

class Shoes extends StatefulWidget {
  final String image;
  final String tag;
  final String brand;
  final String model;

  const Shoes({
    Key? key,
    required this.image,
    required this.tag,
    required this.brand,
    required this.model,
  }) : super(key: key);

  @override
  State<Shoes> createState() => _ShoesState();
}

class _ShoesState extends State<Shoes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen FULLSCREEN con Hero
          Hero(
            tag: widget.tag,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Botón de retroceso
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),

          // Contenido principal
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.3, 1.0],
                    ),
                  ),
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        30 * (1 - _opacityAnimation.value),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.brand,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Available Sizes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: ['S', 'M', 'L', 'XL'].map((size) {
                                return Container(
                                  width: 50,
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color: size == 'M'
                                        ? Colors.white
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: size == 'M' ? 0 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      size,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: size == 'M'
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'BUY NOW',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
