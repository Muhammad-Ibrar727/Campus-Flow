// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// class DeveloperProfile extends StatelessWidget {
//   const DeveloperProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text('Developer Profile'),
//         backgroundColor: Color.fromARGB(255, 38, 89, 152),
//         foregroundColor: Colors.white,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(Icons.arrow_back_ios_new),
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             // 🔹 Header Section
//             _buildHeaderSection(),

//             const SizedBox(height: 24),

//             // 🔹 About Section
//             _buildAboutSection(),

//             const SizedBox(height: 24),

//             // 🔹 Contact Section
//             _buildContactSection(),

//             const SizedBox(height: 24),

//             // 🔹 Social Links
//             _buildSocialSection(),

//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderSection() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(32),
//       decoration: BoxDecoration(
//         // gradient: LinearGradient(
//         //   begin: Alignment.topLeft,
//         //   end: Alignment.bottomRight,
//         //   colors: [
//         //     Color.fromARGB(255, 38, 89, 152),
//         //     Color.fromARGB(255, 58, 109, 172),
//         //     Color.fromARGB(255, 78, 129, 192),
//         //   ],
//         // ),
//         color: Color.fromARGB(255, 38, 89, 152),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Profile Image
//           Container(
//             width: 150,
//             height: 150,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.white, width: 4),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.2),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: ClipOval(
//               child: Image.asset(
//                 'assets/images/Developer.jpeg',
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [Colors.blue[400]!, Colors.purple[400]!],
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.code_rounded,
//                       color: Colors.white,
//                       size: 50,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Name and Title
//           const Text(
//             'Muhammad Ibrar',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 8),

//           const Text(
//             'Flutter App Developer',
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),

//           const SizedBox(height: 16),

//           // Experience Badge
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.white.withOpacity(0.3)),
//             ),
//             child: const Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.work_outline, color: Colors.white, size: 16),
//                 SizedBox(width: 6),
//                 Text(
//                   '2+ Years Experience',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAboutSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.blue.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.person_outline, color: Colors.blue),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'About Me',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               Text(
//                 'Passionate Flutter developer with expertise in creating beautiful, responsive, and high-performance mobile applications. Specialized in state management, custom animations, and clean architecture.',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[700],
//                   height: 1.5,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Quick Stats
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildStatItem('15+', 'Projects'),
//                   _buildStatItem('8K+', 'Lines of Code'),
//                   _buildStatItem('90%', 'Satisfaction'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatItem(String value, String label) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSkillItem(String name, double level) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//               Text(
//                 '${(level * 100).toInt()}%',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),

//           Container(
//             height: 8,
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: FractionallySizedBox(
//               alignment: Alignment.centerLeft,
//               widthFactor: level,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.blue[400]!, Colors.purple[400]!],
//                   ),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactSection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.orange.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.contact_mail, color: Colors.orange),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Get In Touch',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               _buildContactItem(
//                 Icons.email_outlined,
//                 'Email',
//                 'mohummadibrar727@gmail.com',
//                 () => _launchUrl('mailto:mohummadibrar727@gmail.com'),
//               ),

//               const SizedBox(height: 12),

//               _buildContactItem(
//                 Icons.phone_outlined,
//                 'Phone',
//                 '+92 343 0914553',
//                 () => _launchUrl('tel:+15551234567'),
//               ),

//               const SizedBox(height: 12),

//               _buildContactItem(
//                 Icons.location_on_outlined,
//                 'Location',
//                 'Mansehra, Pakistan',
//                 () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactItem(
//     IconData icon,
//     String title,
//     String value,
//     VoidCallback onTap,
//   ) {
//     return ListTile(
//       leading: Container(
//         width: 44,
//         height: 44,
//         decoration: BoxDecoration(
//           color: Colors.grey[100],
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, color: Colors.blue[700]),
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           color: Colors.grey,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       subtitle: Text(
//         value,
//         style: const TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       onTap: onTap,
//       contentPadding: EdgeInsets.zero,
//     );
//   }

//   Widget _buildSocialSection() {
//     final socials = [
//       {'icon': Icons.link, 'name': 'Portfolio', 'url': 'https://johndoe.dev'},
//       {
//         'icon': Icons.code,
//         'name': 'GitHub',
//         'url': 'https:github.com/Muhammad-Ibrar727',
//       },
//       {'icon': Icons.work, 'name': 'LinkedIn', 'url': 'https://linkedin.com/'},
//       {'icon': Icons.article, 'name': 'Blog', 'url': 'https://Muhammadibrar'},
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(left: 8, bottom: 16),
//             child: Text(
//               'Connect With Me',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ),

//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 3,
//             ),
//             itemCount: socials.length,
//             itemBuilder: (context, index) {
//               final social = socials[index];
//               return _buildSocialButton(
//                 social['icon'] as IconData,
//                 social['name'] as String,
//                 () => _launchUrl(social['url'] as String),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSocialButton(IconData icon, String name, VoidCallback onTap) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.blue[700],
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 18),
//           const SizedBox(width: 8),
//           Text(
//             name,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _launchUrl(String url) async {
//     try {
//       if (await canLaunchUrl(Uri.parse(url))) {
//         await launchUrl(Uri.parse(url));
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Could not launch $url',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperProfile extends StatelessWidget {
  const DeveloperProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFD),
      body: Column(
        children: [
          // Header Section with Gradient
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Icon(
                    Icons.code_rounded,
                    size: 80,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Developer',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Meet the Creator',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Profile Card
          Transform.translate(
            offset: Offset(0, -60),
            child: _buildProfileCard(),
          ),

          // Contact Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildContactInfo(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image - Modern Rectangular Design
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.shade50, width: 3),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade50, Colors.blue.shade100],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: Image.asset(
                'assets/images/Developer.jpeg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue.shade400,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24),

          // Name and Role
          Column(
            children: [
              Text(
                'Muhammad Ibrar',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Bio
          Text(
            'Developer of CampusFlow App for GPGC Mansehra',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get In Touch',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Feel free to reach out for collaborations or questions',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        SizedBox(height: 24),

        Expanded(
          child: ListView(
            children: [
              // Email
              _buildModernContactItem(
                icon: Icons.email_rounded,
                title: 'Email',
                subtitle: 'mohummadibrar727@gmail.com',
                onTap: () => _launchEmail('mohummadibrar727@gmail.com'),
                color: Colors.red,
                gradient: LinearGradient(
                  colors: [Colors.red.shade50, Colors.red.shade100],
                ),
              ),
              SizedBox(height: 16),

              // WhatsApp
              _buildModernContactItem(
                icon: Icons.chat_rounded,
                title: 'WhatsApp',
                subtitle: '+92 343 0914553',
                onTap: () => _launchWhatsApp('+923430914553'),
                color: Colors.green,
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.green.shade100],
                ),
              ),
              SizedBox(height: 16),

              // LinkedIn
              _buildModernContactItem(
                icon: Icons.work_rounded,
                title: 'LinkedIn',
                subtitle: 'linkedin.com/in/yourprofile',
                onTap: () =>
                    _launchLinkedIn('https://linkedin.com/in/yourprofile'),
                color: Colors.blue.shade700,
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.blue.shade100],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
    required Gradient gradient,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // URL Launching Functions
  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  void _launchWhatsApp(String phone) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phone');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }

  void _launchLinkedIn(String url) async {
    final Uri linkedInUri = Uri.parse(url);

    if (await canLaunchUrl(linkedInUri)) {
      await launchUrl(linkedInUri);
    }
  }
}
