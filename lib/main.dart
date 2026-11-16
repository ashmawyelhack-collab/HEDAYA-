here
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HedayaApp());
}

class HedayaApp extends StatelessWidget {
  const HedayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HEDAYA',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF075C43),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F5),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> sections = const [
    {'name': 'القرآن الكريم', 'icon': Icons.menu_book},
    {'name': 'الأحاديث النبوية', 'icon': Icons.auto_stories},
    {'name': 'قصص الأنبياء', 'icon': Icons.history_edu},
    {'name': 'السيرة النبوية', 'icon': Icons.mosque},
    {'name': 'أذكار الصباح', 'icon': Icons.wb_sunny},
    {'name': 'أذكار المساء', 'icon': Icons.nights_stay},
    {'name': 'المسبحة الإلكترونية', 'icon': Icons.touch_app},
    {'name': 'مواقيت الصلاة والأذان', 'icon': Icons.access_time},
    {'name': 'اتجاه القبلة', 'icon': Icons.explore},
  ];

  Future<void> contactDeveloper(BuildContext context) async {
    final uri = Uri.parse('https://wa.me/201131123662');
    try {
      if (!await launchUrl(uri,
          mode: LaunchMode.externalApplication)) {
        throw Exception('Could not open WhatsApp');
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تعذر فتح واتساب')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'HEDAYA | هداية',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF075C43),
          foregroundColor: Colors.white,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF075C43),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mosque,
                        color: Colors.white, size: 48),
                    SizedBox(height: 10),
                    Text(
                      'HEDAYA - هداية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'رفيقك الإسلامي اليومي',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              ...sections.map((item) => ListTile(
                    leading: Icon(item['icon']),
                    title: Text(item['name']),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SectionPage(
                            title: item['name'],
                            icon: item['icon'],
                          ),
                        ),
                      );
                    },
                  )),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color(0xFF075C43),
                ),
                title: const Text(
                  'Contact Developer – Salah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => contactDeveloper(context),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF075C43),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.mosque,
                        color: Color(0xFFFFD777), size: 55),
                    SizedBox(height: 12),
                    Text(
                      'أهلاً بك في هداية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'اجعل يومك عامراً بذكر الله',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'أقسام التطبيق',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sections.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.15,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = sections[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SectionPage(
                            title: item['name'],
                            icon: item['icon'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 1,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item['icon'],
                            size: 38,
                            color: const Color(0xFF075C43),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionPage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: const Color(0xFF075C43),
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 75, color: const Color(0xFF075C43)),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text('سيتم تجهيز محتوى هذا القسم'),
            ],
          ),
        ),
      ),
    );
  }
}
