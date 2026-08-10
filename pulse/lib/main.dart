import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PulseApp());
}

// ============================================================
// APP
// ============================================================

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08090D),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5CFF),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const PulseHome(),
    );
  }
}

// ============================================================
// COLORS
// ============================================================

const background = Color(0xFF08090D);
const surface = Color(0xFF11131A);
const surfaceLight = Color(0xFF171A23);
const purple = Color(0xFF7C5CFF);
const blue = Color(0xFF00D4FF);
const pink = Color(0xFFFF5C8A);
const green = Color(0xFF42E8A5);
const yellow = Color(0xFFFFC857);
const textPrimary = Color(0xFFF5F7FA);
const textSecondary = Color(0xFF9297A5);

// ============================================================
// HOME
// ============================================================

class PulseHome extends StatefulWidget {
  const PulseHome({super.key});

  @override
  State<PulseHome> createState() => _PulseHomeState();
}

class _PulseHomeState extends State<PulseHome> {
  int selectedIndex = 0;

  final List<String> navigation = [
    'Home',
    'Focus',
    'Journal',
    'Insights',
  ];

  final List<IconData> navigationIcons = [
    Icons.grid_view_rounded,
    Icons.track_changes_rounded,
    Icons.edit_note_rounded,
    Icons.auto_graph_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          if (width < 600) {
            return _buildMobile();
          }

          if (width < 1100) {
            return _buildTablet();
          }

          return _buildDesktop();
        },
      ),
    );
  }

  // ==========================================================
  // MOBILE
  // ==========================================================

  Widget _buildMobile() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: _buildContent(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              isMobile: true,
              isTablet: false,
            ),
          ),
          _buildMobileNavigation(),
        ],
      ),
    );
  }

  Widget _buildMobileNavigation() {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(.07),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          navigation.length,
          (index) {
            final active = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? purple.withOpacity(.16)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  navigationIcons[index],
                  size: 23,
                  color: active ? purple : textSecondary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // TABLET
  // ==========================================================

  Widget _buildTablet() {
    return SafeArea(
      child: Row(
        children: [
          _buildNavigationRail(),
          Expanded(
            child: _buildContent(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
              isMobile: false,
              isTablet: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    return Container(
      width: 82,
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 25),
          _buildLogo(),
          const SizedBox(height: 45),
          ...List.generate(
            navigation.length,
            (index) => _navigationButton(
              index,
              compact: true,
            ),
          ),
          const Spacer(),
          _buildProfileAvatar(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==========================================================
  // DESKTOP
  // ==========================================================

  Widget _buildDesktop() {
    return SafeArea(
      child: Row(
        children: [
          Container(
            width: 250,
            margin: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(.06),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      _buildLogo(),
                      const SizedBox(width: 12),
                      Text(
                        'PULSE',
                        style: GoogleFonts.inter(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 55),
                ...List.generate(
                  navigation.length,
                  (index) => _navigationButton(index),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(18),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: purple.withOpacity(.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: purple.withOpacity(.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: purple,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Daily tip',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Small progress compounds into remarkable results.',
                        style: GoogleFonts.inter(
                          color: textSecondary,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildContent(
              padding: const EdgeInsets.fromLTRB(20, 26, 34, 30),
              isMobile: false,
              isTablet: false,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MAIN CONTENT
  // ==========================================================

  Widget _buildContent({
    required EdgeInsets padding,
    required bool isMobile,
    required bool isTablet,
  }) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(isMobile),
          const SizedBox(height: 26),

          if (selectedIndex == 0)
            _buildDashboard(
              isMobile: isMobile,
              isTablet: isTablet,
            )
          else
            _buildPlaceholderPage(
              navigation[selectedIndex],
              navigationIcons[selectedIndex],
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader(bool isMobile) {
    return Row(
      children: [
        if (isMobile) ...[
          _buildLogo(),
          const SizedBox(width: 12),
          Text(
            'PULSE',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
          const Spacer(),
        ] else
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting(),
                  style: GoogleFonts.inter(
                    color: textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your day is looking good.',
                  style: GoogleFonts.inter(
                    color: textPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        if (isMobile) const Spacer(),
        _buildHeaderAction(Icons.notifications_none_rounded),
        const SizedBox(width: 10),
        _buildProfileAvatar(),
      ],
    );
  }

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return 'Good morning, Alex';
    if (hour < 18) return 'Good afternoon, Alex';
    return 'Good evening, Alex';
  }

  Widget _buildHeaderAction(IconData icon) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Icon(
        icon,
        color: textSecondary,
        size: 21,
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [purple, pink],
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(.25),
            blurRadius: 15,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'A',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // DASHBOARD
  // ==========================================================

  Widget _buildDashboard({
    required bool isMobile,
    required bool isTablet,
  }) {
    if (isMobile) {
      return Column(
        children: [
          _buildHeroPulse(),
          const SizedBox(height: 16),
          _buildFocusCard(),
          const SizedBox(height: 16),
          _buildEnergyCard(),
          const SizedBox(height: 16),
          _buildTimelineCard(),
          const SizedBox(height: 16),
          _buildMomentumCard(),
          const SizedBox(height: 20),
        ],
      );
    }

    if (isTablet) {
      return Column(
        children: [
          _buildHeroPulse(),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildFocusCard()),
              const SizedBox(width: 18),
              Expanded(child: _buildEnergyCard()),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildTimelineCard()),
              const SizedBox(width: 18),
              Expanded(child: _buildMomentumCard()),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        _buildHeroPulse(),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _buildFocusCard(),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: _buildEnergyCard(),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: _buildTimelineCard(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildMomentumCard(),
      ],
    );
  }

  // ==========================================================
  // HERO PULSE
  // ==========================================================

  Widget _buildHeroPulse() {
    return Container(
      width: double.infinity,
      height: 285,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF17122D),
            Color(0xFF10121B),
            Color(0xFF0B1B24),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(.07),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -70,
            top: -90,
            child: _glowCircle(
              240,
              purple.withOpacity(.12),
            ),
          ),
          Positioned(
            left: -80,
            bottom: -100,
            child: _glowCircle(
              230,
              blue.withOpacity(.08),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: green.withOpacity(.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              'IN THE ZONE',
                              style: TextStyle(
                                color: green,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        'Your Pulse',
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A snapshot of your energy,\nfocus and momentum today.',
                        style: GoogleFonts.inter(
                          color: textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildPulseOrb(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulseOrb() {
    return SizedBox(
      width: 210,
      height: 210,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 195,
            height: 195,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: purple.withOpacity(.08),
                width: 1,
              ),
            ),
          ),
          Container(
            width: 165,
            height: 165,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: blue.withOpacity(.13),
                width: 1,
              ),
            ),
          ),
          Container(
            width: 135,
            height: 135,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  purple.withOpacity(.65),
                  purple.withOpacity(.18),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: purple.withOpacity(.35),
                  blurRadius: 45,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          Container(
            width: 92,
            height: 92,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF9D85FF),
                  Color(0xFF6342E8),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '78',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'PULSE',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 100,
            spreadRadius: 30,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FOCUS
  // ==========================================================

  Widget _buildFocusCard() {
    final tasks = [
      ['Finish product proposal', true],
      ['30 minute workout', false],
      ['Read 20 pages', false],
      ['Plan tomorrow', false],
    ];

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            'Today\'s Focus',
            '3 of 4 complete',
            Icons.track_changes_rounded,
          ),
          const SizedBox(height: 20),
          ...tasks.map(
            (task) => _buildTask(
              task[0] as String,
              task[1] as bool,
            ),
          ),
          const SizedBox(height: 6),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add_rounded,
              size: 18,
            ),
            label: const Text('Add focus'),
            style: TextButton.styleFrom(
              foregroundColor: purple,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTask(String title, bool completed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: completed
                  ? green.withOpacity(.15)
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: completed ? green : textSecondary,
              ),
            ),
            child: completed
                ? const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: green,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: completed
                    ? textSecondary
                    : textPrimary,
                fontSize: 13,
                decoration: completed
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
          ),
          if (!completed)
            const Icon(
              Icons.more_horiz_rounded,
              size: 18,
              color: textSecondary,
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // ENERGY
  // ==========================================================

  Widget _buildEnergyCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            'Energy',
            'Today',
            Icons.bolt_rounded,
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '78',
                style: GoogleFonts.inter(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 9, left: 4),
                child: Text(
                  '%',
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'Feeling focused',
            style: TextStyle(
              color: green,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: .78,
              minHeight: 9,
              backgroundColor: Colors.white.withOpacity(.06),
              valueColor: const AlwaysStoppedAnimation(
                green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _energyPoint('Low', '0'),
              _energyPoint('Balanced', '50'),
              _energyPoint('Peak', '100'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _energyPoint(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: textSecondary,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: const TextStyle(
            color: textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // TIMELINE
  // ==========================================================

  Widget _buildTimelineCard() {
    final items = [
      ['09:00', 'Deep Work', purple],
      ['12:30', 'Lunch', green],
      ['15:00', 'Team Sync', blue],
      ['18:00', 'Workout', pink],
    ];

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader(
            'Your Day',
            '4 events',
            Icons.schedule_rounded,
          ),
          const SizedBox(height: 18),
          ...items.map(
            (item) => _timelineItem(
              item[0] as String,
              item[1] as String,
              item[2] as Color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineItem(
    String time,
    String title,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(
              time,
              style: const TextStyle(
                color: textSecondary,
                fontSize: 10,
              ),
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(.5),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MOMENTUM
  // ==========================================================

  Widget _buildMomentumCard() {
    final values = [
      .45,
      .62,
      .50,
      .78,
      .68,
      .85,
      .78,
    ];

    final days = [
      'M',
      'T',
      'W',
      'T',
      'F',
      'S',
      'S',
    ];

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _cardHeader(
                  'Weekly Momentum',
                  'Last 7 days',
                  Icons.auto_graph_rounded,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: purple.withOpacity(.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: purple,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '+18%',
                      style: TextStyle(
                        color: purple,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                values.length,
                (index) {
                  final value = values[index];

                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedContainer(
                              duration: Duration(
                                milliseconds:
                                    300 + index * 80,
                              ),
                              width: 18,
                              height: 90 * value,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: index == 6
                                      ? [
                                          purple,
                                          blue,
                                        ]
                                      : [
                                          purple.withOpacity(.35),
                                          purple.withOpacity(.12),
                                        ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          days[index],
                          style: const TextStyle(
                            color: textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // GENERIC CARD
  // ==========================================================

  Widget _card({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.white.withOpacity(.055),
        ),
      ),
      child: child,
    );
  }

  Widget _cardHeader(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: purple.withOpacity(.1),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: purple,
            size: 18,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.more_horiz_rounded,
          color: textSecondary,
          size: 19,
        ),
      ],
    );
  }

  // ==========================================================
  // NAVIGATION
  // ==========================================================

  Widget _navigationButton(
    int index, {
    bool compact = false,
  }) {
    final active = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 14,
          vertical: 4,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 14,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: active
              ? purple.withOpacity(.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: compact
            ? Icon(
                navigationIcons[index],
                color: active ? purple : textSecondary,
                size: 22,
              )
            : Row(
                children: [
                  Icon(
                    navigationIcons[index],
                    color: active ? purple : textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 13),
                  Text(
                    navigation[index],
                    style: TextStyle(
                      color: active
                          ? textPrimary
                          : textSecondary,
                      fontSize: 13,
                      fontWeight:
                          active ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            purple,
            blue,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(.25),
            blurRadius: 18,
          ),
        ],
      ),
      child: const Icon(
        Icons.bolt_rounded,
        color: Colors.white,
        size: 21,
      ),
    );
  }

  // ==========================================================
  // PLACEHOLDER PAGES
  // ==========================================================

  Widget _buildPlaceholderPage(
    String title,
    IconData icon,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: purple.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: purple,
                size: 40,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'This space is ready for the next experience.',
              style: TextStyle(
                color: textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}