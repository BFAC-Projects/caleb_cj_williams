import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAnimatedSection(
                            delay: 200,
                            child: _buildSectionTitle(
                              'About Caleb "CJ" Williams',
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildAnimatedSection(
                            delay: 400,
                            child: const Text(
                              'Caleb "CJ" Williams is a rising talent in the entertainment industry, known for his dynamic performances and natural charisma. Born with a passion for storytelling and performance, CJ has been making waves in television, film, and voice acting.\n\nWith a foundation built on dedication and talent, CJ brings authenticity and energy to every role. His journey in entertainment began at a young age, and he has continued to grow and evolve as a performer, taking on challenging roles that showcase his versatility.\n\nBeyond acting, CJ is passionate about sports, music, and technology. He enjoys staying active, exploring new creative outlets, and connecting with fans who share his interests. His commitment to his craft and his genuine personality make him a standout talent to watch.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildAnimatedSection(
                            delay: 600,
                            child: _buildSectionTitle('Career Highlights'),
                          ),
                          const SizedBox(height: 12),
                          _buildAnimatedSection(
                            delay: 800,
                            child: Column(
                              children: [
                                _buildFeatureItem(
                                  Icons.tv,
                                  'Television Appearances',
                                  'Featured roles in various television productions',
                                ),
                                _buildFeatureItem(
                                  Icons.movie,
                                  'Film Projects',
                                  'Compelling performances in independent and studio films',
                                ),
                                _buildFeatureItem(
                                  Icons.mic,
                                  'Voice Acting',
                                  'Bringing characters to life through voice work',
                                ),
                                _buildFeatureItem(
                                  Icons.theater_comedy,
                                  'Live Performance',
                                  'Stage work and live entertainment experiences',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildAnimatedSection(
                            delay: 1000,
                            child: _buildSectionTitle('Interests & Passions'),
                          ),
                          const SizedBox(height: 12),
                          _buildAnimatedSection(
                            delay: 1200,
                            child: Column(
                              children: [
                                _buildFeatureItem(
                                  Icons.sports,
                                  'Athletics',
                                  'Active in various sports and fitness activities',
                                ),
                                _buildFeatureItem(
                                  Icons.music_note,
                                  'Music',
                                  'Passionate about music and musical performance',
                                ),
                                _buildFeatureItem(
                                  Icons.camera_alt,
                                  'Content Creation',
                                  'Exploring digital media and content development',
                                ),
                                _buildFeatureItem(
                                  Icons.people,
                                  'Community Engagement',
                                  'Connecting with fans and supporting causes',
                                ),
                                _buildFeatureItem(
                                  Icons.school,
                                  'Continuous Learning',
                                  'Committed to growing as an artist and individual',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
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

  Widget _buildAnimatedSection({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, opacity, _) {
        return TweenAnimationBuilder<Offset>(
          duration: Duration(milliseconds: 800 + delay),
          tween: Tween(begin: const Offset(0, 30), end: Offset.zero),
          curve: Curves.easeOutBack,
          builder: (context, offset, _) {
            return Transform.translate(
              offset: offset,
              child: Opacity(opacity: opacity, child: child),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF618DAC),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF618DAC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF618DAC), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
