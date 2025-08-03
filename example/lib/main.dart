import 'package:animated_cycler/animated_cycler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedCyclerExampleApp());
}

class AnimatedCyclerExampleApp extends StatelessWidget {
  const AnimatedCyclerExampleApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'AnimatedCycler Examples',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const ExampleHomePage(),
      );
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final GlobalKey<AnimatedCyclerState<String>> _manualControlKey =
      GlobalKey<AnimatedCyclerState<String>>();

  // Sample data for examples
  final List<String> _rankingData = <String>[
    '🥇 Alice - 2,580 points',
    '🥈 Bob - 2,420 points',
    '🥉 Charlie - 2,350 points',
    '4️⃣ Diana - 2,180 points',
    '5️⃣ Eve - 2,120 points',
  ];

  final List<ProductModel> _productData = <ProductModel>[
    const ProductModel('Gaming Headset', r'$89.99', Colors.blue, Icons.headset),
    const ProductModel('Wireless Mouse', r'$45.99', Colors.green, Icons.mouse),
    const ProductModel(
        'Mechanical Keyboard', r'$129.99', Colors.red, Icons.keyboard),
    const ProductModel('4K Monitor', r'$299.99', Colors.purple, Icons.monitor),
    const ProductModel('USB-C Hub', r'$69.99', Colors.orange, Icons.hub),
  ];

  final List<String> _newsData = <String>[
    '📈 Market reaches all-time high',
    '🚀 New space mission launched',
    '🔬 Scientific breakthrough announced',
    '🌱 Green energy milestone achieved',
    '💡 Tech innovation revolutionizes industry',
  ];

  final List<String> _notificationData = <String>[
    'New message received',
    'Update available',
    'Payment processed',
    'Backup completed',
    'System maintenance scheduled',
  ];

  // New message data for horizontal example
  final List<String> _messageData = <String>[
    '🎉 Welcome to AnimatedCycler!',
    '🚀 Smooth animations made easy',
    '💡 Perfect for banners and tickers',
    '⚡ High performance guaranteed',
    '🎨 Customizable and flexible',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedCycler Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('🏆 Vertical Ranking Ticker'),
            _buildVerticalRankingExample(),
            const SizedBox(height: 32),
            _buildSectionTitle('💬 Horizontal Message Banner'),
            _buildHorizontalMessageExample(),
            const SizedBox(height: 32),
            _buildSectionTitle('🛍️ Horizontal Product Carousel'),
            _buildHorizontalProductExample(),
            const SizedBox(height: 32),
            _buildSectionTitle('📰 News Feed Ticker'),
            _buildNewsFeedExample(),
            const SizedBox(height: 32),
            _buildSectionTitle('🔧 Manual Control Example'),
            _buildManualControlExample(),
            const SizedBox(height: 32),
            _buildSectionTitle('🔔 Notification Bell'),
            _buildNotificationExample(),
            const SizedBox(height: 32),
            _buildSectionTitle('⚙️ Customization Options'),
            _buildCustomizationExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      );

  Widget _buildVerticalRankingExample() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: AnimatedCycler<String>.vertical(
        items: _rankingData,
        height: 60,
        displayDuration: const Duration(seconds: 2),
        itemBuilder: (context, ranking, index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                ranking,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // NEW: Horizontal Message Banner Example (사용자 제안 반영)
  Widget _buildHorizontalMessageExample() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo.shade50,
            Colors.purple.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: AnimatedCycler<String>(
        direction: Axis.horizontal,
        items: _messageData,
        size:
            MediaQuery.of(context).size.width - 64, // Full width minus padding
        displayDuration: const Duration(seconds: 3),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCubic,
        itemBuilder: (context, message, index) => Center(
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        onItemTap: (message, index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Message tapped: $message'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalProductExample() => SizedBox(
        height: 180,
        child: AnimatedCycler<ProductModel>.horizontal(
          items: _productData,
          width: MediaQuery.of(context).size.width - 32,
          displayDuration: const Duration(seconds: 3),
          onItemTap: (product, index) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tapped: ${product.name}'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          itemBuilder: (context, product, index) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: product.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: product.color.withValues(alpha: 0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  product.icon,
                  size: 48,
                  color: product.color,
                ),
                const SizedBox(height: 12),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: product.color.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildNewsFeedExample() => Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.orange.shade50],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: AnimatedCycler<String>.vertical(
          items: _newsData,
          height: 40,
          displayDuration: const Duration(seconds: 2, milliseconds: 500),
          animationCurve: Curves.easeOutCubic,
          itemBuilder: (context, news, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    news,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildManualControlExample() {
    return Column(
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: AnimatedCycler<String>(
            key: _manualControlKey,
            items: _rankingData,
            autoPlay: false, // Manual control only
            size: 60,
            itemBuilder: (context, item, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _manualControlKey.currentState?.previousItem(),
              child: const Icon(Icons.arrow_back),
            ),
            ElevatedButton(
              onPressed: () =>
                  _manualControlKey.currentState?.togglePlayPause(),
              child: Icon(
                _manualControlKey.currentState?.isPlaying == true
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
            ElevatedButton(
              onPressed: () => _manualControlKey.currentState?.nextItem(),
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Current: ${_manualControlKey.currentState?.currentIndex ?? 0} / '
          '${_rankingData.length - 1}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildNotificationExample() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.notifications, color: Colors.amber),
          ),
          Expanded(
            child: AnimatedCycler<String>.vertical(
              items: _notificationData,
              height: 30,
              displayDuration: const Duration(seconds: 4),
              itemBuilder: (context, notification, index) => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  notification,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationExamples() {
    return Column(
      children: [
        // Fast animation example (크기 문제 해결)
        _buildCustomExample(
          'Fast Animation',
          _newsData.take(3).toList(),
          const Duration(seconds: 1),
          const Duration(milliseconds: 300),
          Curves.bounceOut,
          Colors.purple,
        ),
        const SizedBox(height: 16),
        // Slow animation example (크기 문제 해결)
        _buildCustomExample(
          'Slow & Smooth',
          _newsData.take(3).toList(),
          const Duration(seconds: 5),
          const Duration(milliseconds: 1200),
          Curves.easeInOutCubic,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildCustomExample(
    String title,
    List<String> items,
    Duration displayDuration,
    Duration animationDuration,
    Curve curve,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: AnimatedCycler<String>.vertical(
            items: items,
            height: 40, // ✅ 크기 문제 해결: 50-10(padding) = 40
            displayDuration: displayDuration,
            animationDuration: animationDuration,
            animationCurve: curve,
            itemBuilder: (context, item, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: color.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Sample data model for products
class ProductModel {
  const ProductModel(this.name, this.price, this.color, this.icon);

  final String name;
  final String price;
  final Color color;
  final IconData icon;
}
