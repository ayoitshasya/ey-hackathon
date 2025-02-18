import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'pradhan_mantri_awas_form.dart';

class FamilySchemesScreen extends StatelessWidget {
  const FamilySchemesScreen({super.key});

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
              
              // Family Page Title
              const Text(
                'FAMILY SCHEMES',
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
                      context: context,
                      imagePath: 'assets/images/pradhan_mantri_awas.png',
                      title: 'Pradhan Mantri\nAwas Yojana',
                      onTap: () => _launchSchemeUrl('pradhan_mantri_awas_url'),
                      onApply: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PradhanMantriAwasForm(),
                          ),
                        );
                      },
                    ),
                    _buildSchemeCard(
                      context: context,
                      imagePath: 'assets/images/national_family.png',
                      title: 'National Family\nBenefit Scheme',
                      onTap: () => _launchSchemeUrl('national_family_url'),
                      onApply: () {},
                    ),
                    _buildSchemeCard(
                      context: context,
                      imagePath: 'assets/images/rashtriya_parivarik.png',
                      title: 'Rashtriya Parivarik\nLabh Yojana',
                      onTap: () => _launchSchemeUrl('rashtriya_parivarik_url'),
                      onApply: () {},
                    ),
                    _buildSchemeCard(
                      context: context,
                      imagePath: 'assets/images/pradhan_mantri_jan.png',
                      title: 'Pradhan Mantri Jan\nArogya Yojana',
                      onTap: () => _launchSchemeUrl('pradhan_mantri_jan_url'),
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
    required BuildContext context,
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
      'pradhan_mantri_awas_url': 'https://pmaymis.gov.in/',
      'national_family_url': 'https://nsap.nic.in/nationalfamilybenefitscheme.html',
      'rashtriya_parivarik_url': 'https://nsap.nic.in/nationalsocialassistanceprogramme.html',
      'pradhan_mantri_jan_url': 'https://pmjay.gov.in/',
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