import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/Books/books.dart';
import 'package:law_diary/Diary/daily_diary.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/drawer.dart';
import 'package:law_diary/localization/locales.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
        //   ),
        // ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 10000),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      backdropColor: darkmain,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const DrawerPage(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: subcolor,
          elevation: 0,
          leading: IconButton(
            color: darkmain,
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        backgroundColor: subcolor,
        body: Stack(
          children: [
            _buildBackgroundDecoration(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  Divider(color: seccolor, thickness: 1),
                  SizedBox(height: screenHeight * 0.01),
                  _buildHorizontalScrollMenu(context, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildSectionTitle(
                    LocaleData.features.getString(context),
                    screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildFeatureCard(
                          context: context,
                          screenWidth: screenWidth,
                          image: Image.asset(
                            'assets/icons/law.png',
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                          ),
                          title: LocaleData.title.getString(context),
                          subtitle: LocaleData.des1.getString(context),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DailyDiaryPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        _buildFeatureCard(
                          context: context,
                          screenWidth: screenWidth,
                          image: Image.asset(
                            'assets/icons/law-book.png',
                            width: screenWidth * 0.12,
                            height: screenWidth * 0.12,
                          ),
                          title: LocaleData.books.getString(context),
                          subtitle: LocaleData.des2.getString(context),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BooksScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 222, 197, 174),
            border: Border(
              top: BorderSide(color: seccolor, width: 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Powered by Law Diary",
                style: GoogleFonts.poppins(
                  color: seccolor,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleData.title.getString(context),
          style: GoogleFonts.poppins(
            color: darkmain,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Text(
          LocaleData.secTitle.getString(context),
          style: GoogleFonts.poppins(
            color: darkmain,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required double screenWidth,
    required Image image,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          children: [
            image,
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                      color: darkmain,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey, size: screenWidth * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: darkmain,
        fontSize: screenWidth * 0.05,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBackgroundDecoration() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [subcolor, const Color.fromARGB(255, 222, 197, 174)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildHorizontalScrollMenu(BuildContext context, double screenWidth) {
    return SizedBox(
      height: screenWidth * 0.25,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildQuickAccessTile(
              icon: Icons.event_note,
              label: "Diary",
              screenWidth: screenWidth,
            ),
            _buildQuickAccessTile(
              icon: Icons.book,
              label: "Books",
              screenWidth: screenWidth,
            ),
            _buildQuickAccessTile(
              icon: Icons.language,
              label: "Language",
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessTile({
    required IconData icon,
    required String label,
    required double screenWidth,
  }) {
    return GestureDetector(
      child: Container(
        width: screenWidth * 0.2,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: screenWidth * 0.08, color: darkmain),
            SizedBox(height: screenWidth * 0.02),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
                color: darkmain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
