import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'pradhan_mantri_jeevan_form.dart';

class PersonalSchemesScreen extends StatelessWidget {
  const PersonalSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8FAE0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Top Bar with Logo and Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/seva_setu_logo.png',
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(height: 40, width: 40);
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'SEVA SETU',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B4B3C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF1B4B3C),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),
              
              // Personal Page Title
              const Text(
                'PERSONAL SCHEMES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // Grid of Scheme Cards
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  children: [
                    _buildSchemeCard(
                      imagePath: 'assets/images/atal_pension.png',
                      title: 'Atal Pension\nYojana',
                      onTap: () => _launchSchemeUrl('atal_pension_url'),
                      onApply: () {}, // Empty callback for now
                    ),
                    _buildSchemeCard(
                      imagePath: 'assets/images/sukanya_samriddhi.png',
                      title: 'Sukanya Samriddhi\nYojana',
                      onTap: () => _launchSchemeUrl('sukanya_samriddhi_url'),
                      onApply: () {}, // Empty callback for now
                    ),
                    _buildSchemeCard(
                      imagePath: 'assets/images/pradhan_mantri_jeevan.png',
                      title: 'Pradhan Mantri Jeevan\nJyoti Bima Yojana',
                      onTap: () => _launchSchemeUrl('pradhan_mantri_jeevan_url'),
                      onApply: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PradhanMantriJeevanForm(),
                          ),
                        );
                      },
                    ),
                    _buildSchemeCard(
                      imagePath: 'assets/images/kisan_credit.png',
                      title: 'Kisan Credit Card',
                      onTap: () => _launchSchemeUrl('kisan_credit_url'),
                      onApply: () {},
                    ),
                  ],
                ),
              ),

              // More Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('More'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF1B4B3C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              },
            ),
            const Icon(
              Icons.mic,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchemeCard({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
    required VoidCallback onApply,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // White Box for Image
        Container(
          height: 110,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading image: $imagePath');
              return const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 40,
                ),
              );
            },
          ),
        ),
        
        // Scheme Name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: InkWell(
            onTap: onTap,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
        
        // Apply Button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
            onPressed: onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              minimumSize: const Size(double.infinity, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text(
              'APPLY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _launchSchemeUrl(String schemeUrl) async {
    final Map<String, String> schemeUrls = {
      'atal_pension_url': 'https://www.npscra.nsdl.co.in/scheme-details.php',
      'sukanya_samriddhi_url': 'https://www.indiapost.gov.in/Financial/Pages/Content/Sukanya-Samriddhi-Account.aspx',
      'pradhan_mantri_jeevan_url': 'https://financialservices.gov.in/insurance-divisions/Government-Sponsored-Socially-Oriented-Insurance-Schemes/Pradhan-Mantri-Jeevan-Jyoti-Bima-Yojana(PMJJBY)',
      'kisan_credit_url': 'https://pmkisan.gov.in/',
    };

    final String url = schemeUrls[schemeUrl] ?? schemeUrl;
    final Uri uri = Uri.parse(url);
    
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}