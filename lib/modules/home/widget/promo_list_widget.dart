import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/component/section_tile.dart';
import 'package:shareticket/modules/home/model/content_result/content_result.dart';
import 'package:shareticket/modules/home/screen/promo_detail_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shimmer/shimmer.dart';

class PromoListWidget extends StatefulWidget {
  final String title;

  const PromoListWidget({Key? key, required this.title}) : super(key: key);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<PromoListWidget> {
  final Map<String, dynamic> _params = Map();
  HomeBloc? homeBloc;
  int _currentIndex = 0;

  @override
  void initState() {
    _params['type'] = 'slider';
    homeBloc = HomeBloc();
    homeBloc!.add(GetContentEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        divide6,
        SectionTile(
          title: widget.title,
          // onSubTap: () {},
        ),
        divide6,
        BlocProvider(
          create: (context) => homeBloc!,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetContentLoadingState) {
                return AspectRatio(
                    aspectRatio: 1 / 0.5,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size16),
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimens.size10))),
                            ))));
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
      ],
    );
  }

  Widget _buildView(ContentResult data) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 1,
        aspectRatio: 1 / 0.5,
        initialPage: 0,
      ),
      itemCount: data.contents!.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        if (data.contents!.isNotEmpty) {
          var slider = data.contents![itemIndex];
          return InkWell(
            onTap: () {
              // Navigator.pushNamed(context, PromoDetailScreen.path);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: NetworkImagePlaceHolder(
                isRounded: true,
                borderRadius: BorderRadius.circular(10),
                imageUrl: slider.thumbnail,

                width: double.infinity,
                // height: 171,
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
