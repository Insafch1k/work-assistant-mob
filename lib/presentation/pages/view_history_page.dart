import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_assistent_mob/presentation/pages/favorite_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/providers/advertisement_provider.dart';
import 'package:work_assistent_mob/presentation/widgets/advertisement.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';

class ViewHistoryPage extends StatefulWidget {
  const ViewHistoryPage({super.key});

  @override
  State<ViewHistoryPage> createState() => _ViewHistoryPageState();
}

class _ViewHistoryPageState extends State<ViewHistoryPage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdvertisementProvider>().fetchAdvertisementsFromHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdvertisementProvider>();
    return Scaffold(
      backgroundColor: Color(0xFF191A1F),
      appBar: AppBar(
        title: const Text(
          "История просмотра",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: const Color(0xFF191A1F),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: const Color(0xFF191A1F)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              SizedBox(height: 20),
              ...provider.historyAdv
                  .map(
                    (ad) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Advertisement(ad: ad),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottomButtons(
          currentIndex: 2,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WorkPage()),
              );
            }
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FavoritePage()),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
