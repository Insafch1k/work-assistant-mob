import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:work_assistent_mob/presentation/pages/favorite_page.dart';
import 'package:work_assistent_mob/presentation/pages/profile_page.dart';
import 'package:work_assistent_mob/presentation/pages/view_history_page.dart';
import 'package:work_assistent_mob/presentation/pages/work_page.dart';
import 'package:work_assistent_mob/presentation/widgets/bottom_buttons.dart';
import 'package:work_assistent_mob/presentation/widgets/mine_message.dart';
import 'package:work_assistent_mob/presentation/widgets/stranger_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191A1F),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/dot.svg',
                  width: 11,
                  height: 11,
                  color: const Color(0xFF78DF68),
                ),
                const SizedBox(width: 9),
                const Text(
                  'Динар',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
            const Text(
              'В сети',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF78DF68),
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            width: 20,
            height: 20,
            color: const Color(0xFFFFFFFF),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Переход на профиль работодателя
            },
            icon: Image.asset(
              'assets/images/ronaldo.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
        backgroundColor: const Color(0xFF434B5D),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
                top: 5,
                bottom: 10,
              ),
              child: Column(
                children: [
                  // Сообщения от собеседника
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          'assets/images/ronaldo.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const StrangerMessage(),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Ваши сообщения
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Container()),
                      const MineMessage(),
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.only(left: 8),
                        child: Image.asset(
                          'assets/images/ronaldo.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // Поле ввода сообщения
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            decoration: const BoxDecoration(color: Color(0xFF434B5D)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {}, 
                  icon: SvgPicture.asset(
                    'assets/icons/clip.svg',
                    width: 28,
                    height: 28,
                    color: const Color(0xFFFFFFFF),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const SizedBox(width: 3),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF35383F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        color: Color(0xFFFFFFFF),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Сообщение',
                        hintStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0,
                          color: Color(0xFF71747B),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        isDense: true,
                      ),
                      maxLines: 6, 
                      minLines: 1, 
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6849FF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/arrow_up.svg',
                      width: 20,
                      height: 20,
                      color: const Color(0xFFFFFFFF),
                    ),
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: BottomButtons(
          currentIndex: 0,
          onTabSelected: (index) {
            if (index == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WorkPage()),
              );
            }
            if (index == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FavoritePage()),
              );
            }
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewHistoryPage(),
                ),
              );
            }
            if (index == 3) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            }
          },
        ),
      ),
    );
  }
}
