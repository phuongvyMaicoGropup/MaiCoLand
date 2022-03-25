import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maico_land/bloc/news_bloc/news_bloc.dart';
import 'package:maico_land/bloc/news_bloc/news_state.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';

import 'widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsRepository _newsRepo = NewsRepository();
  final searchController = TextEditingController();
  List<News> listSearch = [];
  static const _pageSize = 10;

  void _updateSearchTerm(String searchTerm) {
    _pagingController.refresh();
  }

  final PagingController<int, News> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _newsRepo.getNewsPagination(
          pageKey, _pageSize, searchController.text);
      if (mounted) {
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = "Đã có lỗi xảy ra. Vui lòng thử lại ";
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: TextField(
              onChanged: _updateSearchTerm,
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Nhập tiêu đề bài viết..',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed("/news/search");
                    // showSearch(context: context, delegate: NewsSearch(items), );
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
            return _buildListNews();
          })),
    ));
  }

  Widget _buildListNews() {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => _pagingController.refresh()),
      child: PagedListView<int, News>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<News>(
          itemBuilder: (context, item, index) => NewsCard(news: item),
          //         firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
          //   error: _pagingController.error,
          //   onTryAgain: () => _pagingController.refresh(),
          // ),
          // noItemsFoundIndicatorBuilder: (context) => EmptyListIndicator(),
        ),
      ),
    );
  }
}
