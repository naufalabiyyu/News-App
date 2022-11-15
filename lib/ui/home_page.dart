import 'dart:io';
import 'package:dicoding_news_app/ui/article_list_page.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/platform_widget.dart';
import 'bookmarks_page.dart';
import 'detail_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Headline';

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: _headlineText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS
          ? CupertinoIcons.bookmark
          : Icons.collections_bookmark),
      label: BookmarksPage.bookmarksTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  final List<Widget> _listWidget = [
    const ArticleListPage(),
    const BookmarksPage(),
    const SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(ArticleDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: _bottomNavBarItems,
      ),
      tabBuilder: (BuildContext context, int index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  // Widget _buildList(BuildContext context) {
  //   return FutureBuilder<String>(
  //     future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
  //     builder: (context, snapshot) {
  //       final List<Article> articles = parseArticles(snapshot.data);
  //       return ListView.builder(
  //         itemCount: articles.length,
  //         itemBuilder: (context, index) {
  //           return _buildArticleItem(context, articles[index]);
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget _buildArticleItem(BuildContext context, Article article) {
  //   return Material(
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.symmetric(
  //         horizontal: 16.0,
  //         vertical: 8.0,
  //       ),
  //       leading: Hero(
  //         tag: article.urlToImage,
  //         child: Image.network(
  //           article.urlToImage,
  //           width: 100,
  //         ),
  //       ),
  //       title: Text(article.title),
  //       subtitle: Text(article.author),
  //       onTap: () {
  //         Navigator.pushNamed(context, ArticleDetailPage.routeName,
  //             arguments: article);
  //       },
  //     ),
  //   );
  // }
}
