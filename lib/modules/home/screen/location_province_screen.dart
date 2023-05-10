import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/model/province_result/province_result.dart';
import 'package:shareticket/modules/home/screen/location_city_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class LocationProvinceArgument {
  final String title;

  LocationProvinceArgument(this.title);
}

class LocationProvinceScreen extends StatefulWidget {
  final LocationProvinceArgument? argument;

  const LocationProvinceScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/LocationProvince';
  static const String title = 'Pilih Provinsi';

  @override
  _LocationProvinceScreenState createState() => _LocationProvinceScreenState();
}

class _LocationProvinceScreenState extends State<LocationProvinceScreen> {
  String? title;
  HomeBloc? homeBloc;
  final Map<String, dynamic> _params = Map();
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = LocationProvinceScreen.title;
    }

    homeBloc = HomeBloc();
    homeBloc!.add(GetProvinceEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(
          context: context,
          backButton: true,
          title: LocationProvinceScreen.title,
        ),
        body: BlocProvider(
          create: (context) => homeBloc!,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetProvinceLoadingState) {
                // return loading();
                return loading();
              } else if (state is GetProvinceLoadedState) {
                return _buildView(state.data);
              } else if (state is GetProvinceErrorState) {
                return IllustrationWidget(
                  type: IllustrationWidgetType.error,
                  onButtonTap: () {
                    homeBloc!.add(GetProvinceEvent(_params));
                  },
                );
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ));
  }

  Widget _buildView(ProvinceResult data) {
    return RefreshIndicator(
      onRefresh: () async {
        homeBloc!.add(GetProvinceEvent(_params));
      },
      child: ListView.separated(
        itemCount: data.provinces!.length,
        itemBuilder: (BuildContext context, int index) {
          var province = data.provinces![index];

          return ListTile(
            onTap: () {
              Navigator.pop(context, province);
            },
            title: TextWidget(
              '${province.name}'.toTitleCase(),
              textColor: Pallete.textPrimary,
            ),
            trailing: const SvgUI('ic_account_right_arrow.svg'),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return divideThick();
        },
      ),
    );
  }
}
