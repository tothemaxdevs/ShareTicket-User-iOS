import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/article/screen/article_screen.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/article_list.dart';
import 'package:shareticket/modules/home/component/section_tile.dart';
import 'package:shareticket/modules/home/model/content_result/content_result.dart';
import 'package:shareticket/modules/home/screen/article_by_id_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class ArticleListWidget extends StatefulWidget {
  final String title;
  const ArticleListWidget({Key? key, required this.title}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<ArticleListWidget> {
  final Map<String, dynamic> _params = Map();
  HomeBloc? homeBloc;

  int? articleLenght = 0;
  @override
  void initState() {
    _params['type'] = 'article';
    homeBloc = HomeBloc();

    homeBloc!.add(GetContentEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc!,
      child: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetContentLoadingState) {
            return loading();
          } else if (state is GetContentLoadedState) {
            return _buildView(state.data);
          } else if (state is GetContentErrorState) {
            return TextWidget(state.message);
          } else if (state is GetContentEmtptyState) {
            return const SizedBox();
          }
          return Container();
        },
        listener: (context, state) => {
          if (state is GetContentLoadedState)
            {articleLenght = state.data.contents!.length}
        },
      ),
    );
  }

  Widget _buildView(ContentResult data) {
    return Column(
      children: [
        divide6,
        SectionTile(
            title: LocaleKeys.home_article.tr(),
            onSubTap: () {
              Navigator.pushNamed(context, ArticleScreen.path);
            }
            // : null,
            ),
        divide6,
        ListView.builder(
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
      ],
    );
  }
}
