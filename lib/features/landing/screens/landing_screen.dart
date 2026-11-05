import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/about_section.dart';
import '../widgets/astrologer_section.dart';
import '../widgets/early_access_section.dart';
import '../widgets/features_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/mobile_navigation.dart';
import '../widgets/navigation_bar.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _approachKey = GlobalKey();
  final GlobalKey _astrologerKey = GlobalKey();
  final GlobalKey _earlyAccessKey = GlobalKey();

  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 600 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset <= 600 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.midnightNavy,
      endDrawer: AstromettMobileDrawer(
        onHomeTap: () => _scrollToKey(_heroKey),
        onAboutTap: () => _scrollToKey(_aboutKey),
        onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
        onApproachTap: () => _scrollToKey(_approachKey),
        onJoinTap: () => _scrollToKey(_earlyAccessKey),
      ),
      body: Stack(
        children: [
          // Scrollable Landing Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // 1. Hero
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onJoinEarlyAccess: () => _scrollToKey(_earlyAccessKey),
                    onDiscoverHowItWorks: () => _scrollToKey(_howItWorksKey),
                  ),
                ),

                // 2. About
                Container(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),

                // 3. How It Works
                Container(
                  key: _howItWorksKey,
                  child: const HowItWorksSection(),
                ),

                // 4. Core Features / Our Approach
                Container(
                  key: _approachKey,
                  child: const FeaturesSection(),
                ),

                // 5. Astrologer Guidance
                Container(
                  key: _astrologerKey,
                  child: const AstrologerSection(),
                ),

                // 6. Early Access Registration
                Container(
                  key: _earlyAccessKey,
                  child: const EarlyAccessSection(),
                ),

                // 7. Footer
                FooterSection(
                  onHomeTap: () => _scrollToKey(_heroKey),
                  onAboutTap: () => _scrollToKey(_aboutKey),
                  onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
                  onApproachTap: () => _scrollToKey(_approachKey),
                  onJoinTap: () => _scrollToKey(_earlyAccessKey),
                ),
              ],
            ),
          ),

          // Sticky Top Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AstromettNavigationBar(
              onHomeTap: () => _scrollToKey(_heroKey),
              onAboutTap: () => _scrollToKey(_aboutKey),
              onHowItWorksTap: () => _scrollToKey(_howItWorksKey),
              onApproachTap: () => _scrollToKey(_approachKey),
              onJoinTap: () => _scrollToKey(_earlyAccessKey),
              onMenuOpen: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              backgroundColor: AppColors.champagneGold,
              foregroundColor: AppColors.midnightNavy,
              tooltip: 'Back to Top',
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                );
              },
              child: const Icon(Icons.arrow_upward, size: 18),
            )
          : null,
    );
  }
}

