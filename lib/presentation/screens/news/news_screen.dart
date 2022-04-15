import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maico_land/bloc/news_bloc/news_bloc.dart';
import 'package:maico_land/bloc/news_bloc/news_state.dart';
import 'package:maico_land/model/entities/news.dart';
import 'package:maico_land/model/repositories/news_repository.dart';
import 'package:maico_land/presentation/widgets/widgets.dart';

import 'widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsRepository _newsRepo = NewsRepository();
  final searchController = TextEditingController();
  List<String> listSearch = [];
  static const _pageSize = 10;

  void _updateSearchTerm(String searchTerm) {
    _pagingController.refresh();
  }

  final PagingController<int, String> _pagingController =
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
                    _updateSearchTerm(searchController.text);
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
      child: PagedListView<int, String>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<String>(
          firstPageProgressIndicatorBuilder: (_) => WidgetSkeleton(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3),
          // newPageProgressIndicatorBuilder: (_) => NewPageProgressIndicator(),
          noItemsFoundIndicatorBuilder: (_) => Center(child: Text("Đã hết")),
          // noMoreItemsIndicatorBuilder: (_) => NoMoreItemsIndicator(),
          itemBuilder: (context, item, index) => FutureBuilder(
            future: _newsRepo.getNewsById(item),
            // initialData: Wi,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return NewsCard(key: UniqueKey(), news: snapshot.data);
              }
              return Container();
              // return WidgetSkeleton(
              //     width: MediaQuery.of(context).size.width,
              //     height: MediaQuery.of(context).size.height * 0.3);
            },
          ),
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
