import 'package:flutter/material.dart';
import 'package:minichat/pages/contents/chats_page.dart';
import 'package:minichat/pages/contents/contacts_page.dart';
import 'package:minichat/pages/auth/login_page.dart';
import 'package:minichat/pages/contents/tools_page.dart';
import 'package:minichat/widgets/app_title.dart';
import 'package:minichat/widgets/bottom_tab_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.initialTabIndex = 0});

  final int initialTabIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialTabIndex);
    _tabController.addListener(() {
      setState(() {}); // Update the state when the tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    // list of pages
    final List<Widget> pages = [
      ChatsPage(),
      ContactsPage(),
      ToolsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppTitle(scale: 1.2),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case "logout":
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                  break;
                default:
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
              PopupMenuItem(
                value: 'about',
                child: Text('About'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
            offset: Offset(0, 40),
            color: theme.surfaceContainerLowest,
          ),
        ],
      ),

      // bottom tab bar
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: BottomTabBar(
        theme: theme,
        tabs: [
          Tab(
            text: "Chats",
            icon: Icon(Icons.chat_outlined),
          ),
          Tab(
            text: "Contacts",
            icon: Icon(Icons.people_outlined),
          ),
          Tab(
            text: "Tools",
            icon: Icon(Icons.apps_outlined),
          ),
        ],
        controller: _tabController,
      ),

      // fragmen page
      body: TabBarView(
        controller: _tabController,
        children: pages,
      ),
    );
  }
}
