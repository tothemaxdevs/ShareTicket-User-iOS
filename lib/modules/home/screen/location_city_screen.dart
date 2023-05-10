import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/core/not_found/illustration_widget.dart';
import 'package:shareticket/modules/home/bloc/home/home_bloc.dart';
import 'package:shareticket/modules/home/model/city_result/city_result.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class LocationCityArgument {
  final String? title;
  final int? provinceId;
  final String? provinceName;

  LocationCityArgument({this.title, this.provinceId, this.provinceName});
}

class LocationCityScreen extends StatefulWidget {
  final LocationCityArgument? argument;

  const LocationCityScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/LocationCity';
  static const String title = 'Pilih Kota';

  @override
  _LocationCityScreenState createState() => _LocationCityScreenState();
}

class _LocationCityScreenState extends State<LocationCityScreen> {
  String? title;
  HomeBloc? homeBloc;
  final Map<String, dynamic> _params = Map();
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = LocationCityScreen.title;
    }

    homeBloc = HomeBloc();
    _params['province_id'] = widget.argument!.provinceId;
    homeBloc!.add(GetCityEvent(_params));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(
          context: context,
          backButton: true,
          title: LocationCityScreen.title,
        ),
        body: BlocProvider(
          create: (context) => homeBloc!,
          child: BlocConsumer<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is GetCityLoadingState) {
                // return loading();
                return loading();
              } else if (state is GetCityLoadedState) {
                return _buildView(state.data);
              } else if (state is GetCityErrorState) {
                return IllustrationWidget(
                  type: IllustrationWidgetType.error,
                  onButtonTap: () {
                    homeBloc!.add(GetCityEvent(_params));
                  },
                );
              }
              return Container();
            },
            listener: (context, state) => {},
          ),
        ));
  }

  Widget _buildView(CityResult data) {
    return RefreshIndicator(
      onRefresh: () async {
        homeBloc!.add(GetProvinceEvent(_params));
      },
      child: ListView.separated(
        itemCount: data.cities!.length,
        itemBuilder: (BuildContext context, int index) {
          var city = data.cities![index];

          return ListTile(
            onTap: () {
              Navigator.pop(context, city);
            },
            title: TextWidget(
              '${city.name}'.toTitleCase(),
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
