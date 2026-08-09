import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────
//  Assignment 2 — Row, Column & Stack  |  FreshBasket Grocery UI
// ──────────────────────────────────────────────────────────────
//  Demonstrates:
//    • Row   → app bar, search bar, category strip, price rows
//    • Column → vertical page layout, product-card contents
//    • Stack  → discount badges, favourite icon, floating cart
// ──────────────────────────────────────────────────────────────

void main() => runApp(const FreshBasketApp());

// ─── Root Widget ─────────────────────────────────────────────
class FreshBasketApp extends StatelessWidget {
  const FreshBasketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshBasket — Grocery Ordering',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6A0DAD),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

// ─── Home Screen ─────────────────────────────────────────────
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ╔══════════════════════════════════════════════════════╗
      // ║  STACK #1 — outer Stack keeps the cart bar floating ║
      // ║  above the scrollable Column of content.            ║
      // ╚══════════════════════════════════════════════════════╝
      body: Stack(
        children: [
          // ── Scrollable content arranged in a Column ──
          Column(
            children: [
              buildAppBar(),
              buildSearchBar(),
              buildCategoryRow(),
              const SizedBox(height: 8),
              Expanded(child: buildProductGrid()),
            ],
          ),

          // ── Floating cart bar (Stack-positioned) ──
          Positioned(
            left: 14,
            right: 14,
            bottom: 10,
            child: buildFloatingCartBar(),
          ),
        ],
      ),
    );
  }

  // ─── App Bar : ROW ─────────────────────────────────────────
  //  A Row with MainAxisAlignment.spaceBetween places the
  //  delivery info on the left and a cart icon on the right.
  Widget buildAppBar() {
    return Container(
      color: const Color(0xFF6A0DAD), // rich purple
      padding: const EdgeInsets.fromLTRB(14, 48, 14, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side — Column (vertical) for two text lines
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery in 9 minutes',
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
              Text(
                'Home — 221B Baker Street',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Right side — cart icon
          const Icon(Icons.shopping_cart_outlined, color: Colors.white),
        ],
      ),
    );
  }

  // ─── Search Bar : ROW ──────────────────────────────────────
  //  A Row containing a search icon followed by hint text.
  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEF5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.grey, size: 18),
          SizedBox(width: 8),
          Text(
            'Search for atta, dal, oil...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ─── Category Strip : horizontally scrollable ROW ──────────
  //  Each category icon is itself a Column (icon + label).
  Widget buildCategoryRow() {
    final categories = [
      {'icon': Icons.apple, 'label': 'Fruits'},
      {'icon': Icons.egg_alt, 'label': 'Dairy'},
      {'icon': Icons.cookie, 'label': 'Snacks'},
      {'icon': Icons.bakery_dining, 'label': 'Bakery'},
      {'icon': Icons.local_drink, 'label': 'Drinks'},
      {'icon': Icons.rice_bowl, 'label': 'Grains'},
    ];

    return SizedBox(
      height: 85,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        children: categories
            .map(
              (c) => Padding(
                padding: const EdgeInsets.only(right: 14),
                // Column — icon on top, label below
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: const Color(0xFFF0EEF5),
                      child: Icon(
                        c['icon'] as IconData,
                        color: const Color(0xFF6A0DAD),
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['label'] as String,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // ─── Product Grid : Column of Rows ─────────────────────────
  //  A ListView (vertical Column) where each child is a Row
  //  holding two ProductCard widgets side by side.
  Widget buildProductGrid() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      children: const [
        // ── Row 1 — two product cards ──
        Row(
          children: [
            Expanded(
              child: ProductCard(
                name: 'Fresh Bananas',
                price: 48,
                mrp: 60,
                discount: '20% OFF',
                bgColor: Color(0xFFFFF3E0),
                icon: Icons.energy_savings_leaf,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ProductCard(
                name: 'Amul Milk',
                price: 27,
                mrp: 30,
                discount: '10% OFF',
                bgColor: Color(0xFFE8F5E9),
                icon: Icons.local_drink,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // ── Row 2 — two product cards ──
        Row(
          children: [
            Expanded(
              child: ProductCard(
                name: 'Wheat Bread',
                price: 45,
                bgColor: Color(0xFFFBEEE0),
                icon: Icons.bakery_dining,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ProductCard(
                name: 'Onion (1 kg)',
                price: 34,
                mrp: 40,
                discount: '15% OFF',
                bgColor: Color(0xFFFCE4EC),
                icon: Icons.grass,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // ── Row 3 — two more product cards (unique addition) ──
        Row(
          children: [
            Expanded(
              child: ProductCard(
                name: 'Basmati Rice',
                price: 165,
                mrp: 190,
                discount: '13% OFF',
                bgColor: Color(0xFFE3F2FD),
                icon: Icons.rice_bowl,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ProductCard(
                name: 'Farm Eggs (6)',
                price: 52,
                mrp: 60,
                discount: '13% OFF',
                bgColor: Color(0xFFFFF8E1),
                icon: Icons.egg,
              ),
            ),
          ],
        ),

        // Extra bottom padding so content isn't hidden behind cart bar
        SizedBox(height: 72),
      ],
    );
  }

  // ─── Floating Cart Bar : positioned via STACK ──────────────
  //  A Row with spaceBetween alignment inside a rounded green
  //  container.  Placed using Positioned inside the outer Stack.
  Widget buildFloatingCartBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1DA751), Color(0xFF0D8F3F)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1DA751).withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left — items count & total
          Row(
            children: [
              Icon(Icons.shopping_bag, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                '4 items  |  ₹ 154',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Right — CTA text
          Row(
            children: [
              Text(
                'View Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
            ],
          ),
        ],
      ),
    );
  }
}

// ╔════════════════════════════════════════════════════════════╗
// ║  ProductCard Widget  —  uses STACK for overlapping badges ║
// ╚════════════════════════════════════════════════════════════╝
//  The card itself is a Column (image area → details area).
//  Inside the image area, a Stack layers:
//    • Base coloured container
//    • Product icon centred
//    • Positioned discount badge (top-left)
//    • Positioned favourite icon (top-right)

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final int? mrp;
  final String? discount;
  final Color bgColor;
  final IconData icon;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.mrp,
    this.discount,
    this.bgColor = const Color(0xFFFBEEE0),
    this.icon = Icons.shopping_basket,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image area: STACK ──
          Stack(
            children: [
              // Base — coloured container with product icon
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
                child: Icon(icon, size: 44, color: Colors.grey.shade600),
              ),

              // ── Positioned: discount badge (top-left) ──
              if (discount != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      discount!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // ── Positioned: favourite icon (top-right) ──
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

          // ── Details area: Column ──
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                // Row — price on the left, ADD button on the right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price + MRP Row
                    Row(
                      children: [
                        Text(
                          '₹$price',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (mrp != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '₹$mrp',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    // ADD button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6A0DAD),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
