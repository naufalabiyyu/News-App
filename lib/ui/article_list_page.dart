import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/article.dart';
import '../utils/result_state.dart';
import '../widgets/card_article.dart';
import '../widgets/platform_widget.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  //* Menggunakan Data dari SM Provider
  Widget _buildList() {
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(article: article);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  //* Menggunakan Data dari ApiService
  // Widget _buildList(BuildContext context) {
  //   return FutureBuilder(
  //     future: _article,
  //     builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
  //       var state = snapshot.connectionState;
  //       if (state != ConnectionState.done) {
  //         return const Center(child: CircularProgressIndicator());
  //       } else {
  //         if (snapshot.hasData) {
  //           return ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: snapshot.data?.articles.length,
  //             itemBuilder: (context, index) {
  //               var article = snapshot.data?.articles[index];
  //               return CardArticle(article: article!);
  //             },
  //           );
  //         } else if (snapshot.hasError) {
  //           return Center(
  //             child: Material(
  //               child: Text(snapshot.error.toString()),
  //             ),
  //           );
  //         } else {
  //           return const Material(child: Text(''));
  //         }
  //       }
  //       ;
  //     },
  //   );
  // }

  //* Menggunakan Data dari Asset
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

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
