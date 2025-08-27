import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'meet_greet_detail_page.dart';

class MeetGreetPage extends StatefulWidget {
  const MeetGreetPage({super.key});

  @override
  State<MeetGreetPage> createState() => _MeetGreetPageState();
}

class _MeetGreetPageState extends State<MeetGreetPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize slide animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Create fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Create slide animation
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
        );

    // Start animations with a slight delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> events = const [
    {
      'title': 'Fan Meet & Greet - New York',
      'date': 'September 15, 2025',
      'location': 'Madison Square Garden',
      'description': 'Exclusive autograph session and photo opportunities with fans.',
    },
    {
      'title': 'Meet & Greet - Los Angeles',
      'date': 'October 22, 2025',
      'location': 'Staples Center',
      'description': 'Exclusive meet and greet with special guests and giveaways!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meet & Greet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF618DAC),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([_fadeAnimation, _slideAnimation]),
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1200),
                    tween: Tween(begin: 0.8, end: 1.0),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Image.asset(
                          'assets/header_feature.jpg',
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background_feature.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: events.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_busy,
                                    size: 64,
                                    color: const Color(0xFF618DAC).withOpacity(0.6),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No events available at the moment.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF618DAC),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                return _buildAnimatedSection(
                                  delay: 100 + (index * 100),
                                  child: GestureDetector(
                                    onTap: () {
                                      HapticFeedback.mediumImpact();
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => MeetGreetDetailPage(event: event),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF618DAC).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: const Color(0xFF618DAC).withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              event['title']!,
                                              style: const TextStyle(
                                                color: Color(0xFF618DAC),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: const Color(0xFF618DAC).withOpacity(0.7),
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  event['date']!,
                                                  style: TextStyle(
                                                    color: const Color(0xFF618DAC).withOpacity(0.7),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: const Color(0xFF618DAC).withOpacity(0.7),
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  event['location']!,
                                                  style: TextStyle(
                                                    color: const Color(0xFF618DAC).withOpacity(0.7),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              event['description']!,
                                              style: TextStyle(
                                                color: const Color(0xFF618DAC).withOpacity(0.7),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedSection({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
