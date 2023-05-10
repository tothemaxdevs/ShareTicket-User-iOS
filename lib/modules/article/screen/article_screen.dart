import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/article_list.dart';
import 'package:shareticket/modules/home/model/content_result/content_result.dart';
import 'package:shareticket/modules/home/screen/article_by_id_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ArticleArgument {
  final String title;

  ArticleArgument(this.title);
}

class ArticleScreen extends StatefulWidget {
  final ArticleArgument? argument;

  const ArticleScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/Article';
  static const String title = 'Artikel';

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String? title;
  final Map<String, dynamic> _params = Map();
  HomeBloc? homeBloc;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = ArticleScreen.title;
    }
    _params['type'] = 'article';
    homeBloc = HomeBloc();

    homeBloc!.add(GetContentEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: appBar(
          context: context, backButton: true, title: ArticleScreen.title),
      body: BlocProvider(
        create: (context) => homeBloc!,
        child: BlocConsumer<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is GetContentLoadingState) {
              return buildLoading();
            } else if (state is GetContentLoadedState) {
              return _buildView(state.data);
            } else if (state is GetContentErrorState) {
              return TextWidget(state.message);
            } else if (state is GetContentEmtptyState) {
              return TextWidget('Empty');
            }
            return Container();
          },
          listener: (context, state) => {},
        ),
      ),
    );
  }

  Widget _buildView(ContentResult data) {
    return RefreshIndicator(
      onRefresh: () async {
        homeBloc!.add(GetContentEvent(_params));
      },
      child: ListView.builder(
        itemCount: data.contents!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var contents = data.contents![index];
          final List wordTotal = contents.descriptionText!.split(' ');
          int readingTime = (wordTotal.length / 223).ceil();
          return ArticleList(
              onTap: () {
                Navigator.pushNamed(context, ArticleByIdScreen.path,
                    arguments: ArticleByIdArgument(content: contents));
              },
              descriptions: contents.descriptionText,
              title: contents.title,
              date: contents.createdAt,
              readingTime: '$readingTime min read',
              image: contents.thumbnail);
        },
      ),
    );
  }

  Widget buildLoading() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimens.size16, vertical: Dimens.size2),
          padding: const EdgeInsets.all(Dimens.size8),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: [
              const Blink(width: 64, height: 64, borderRadius: 8),
              divideW10,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Blink(
                      width: 200,
                      height: 14,
                    ),
                    divide2,
                    const Blink(
                      width: 270,
                      height: 12,
                    ),
                    divide6,
                    const Blink(
                      width: 180,
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
