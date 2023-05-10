import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/modules/home/model/city_result/city.dart';
import 'package:shareticket/modules/home/model/province_result/province.dart';
import 'package:shareticket/modules/home/screen/location_city_screen.dart';
import 'package:shareticket/modules/home/screen/location_province_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class LocationPickerArgument {
  final String title;

  LocationPickerArgument(this.title);
}

class LocationPickerScreen extends StatefulWidget {
  final LocationPickerArgument? argument;

  const LocationPickerScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/LocationPicker';
  static const String title = 'Ganti lokasi';

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  String? title;

  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  Province? provinceData;
  City? cityData;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = LocationPickerScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(
          context: context,
          backButton: true,
          title: LocationPickerScreen.title,
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
                child: Column(
                  children: [
                    EditTextField(
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(14),
                        child: SvgUI(
                          'ic_account_right_arrow.svg',
                          width: 10,
                          height: 10,
                        ),
                      ),
                      controller: provinceController,
                      label: 'Pilih provinsi',
                      hint: 'Provinsi',
                      validator: requiredValidator,
                      isMarginBottom: true,
                      readOnly: true,
                      onTap: () async {
                        var isUpdated = await Navigator.pushNamed(
                            context, LocationProvinceScreen.path);

                        if (isUpdated != null) {
                          setState(() {
                            cityController.clear();
                            cityData = null;

                            Province province = isUpdated as Province;
                            provinceData = Province(
                                id: province.id,
                                name: '${province.name}'.toTitleCase());
                            provinceController.text =
                                '${province.name}'.toTitleCase();
                          });
                        }
                      },
                    ),
                    EditTextField(
                      suffixIcon: const Padding(
                        padding: EdgeInsets.all(14),
                        child: SvgUI(
                          'ic_account_right_arrow.svg',
                          width: 10,
                          height: 10,
                        ),
                      ),
                      controller: cityController,
                      label: 'Pilih Kota / Kabupaten',
                      hint: 'Kota / Kabupaten',
                      validator: requiredValidator,
                      isMarginBottom: true,
                      readOnly: true,
                      onTap: provinceData != null
                          ? () async {
                              var isUpdated = await Navigator.pushNamed(
                                  context, LocationCityScreen.path,
                                  arguments: LocationCityArgument(
                                      provinceId: provinceData!.id));

                              if (isUpdated != null) {
                                setState(() {
                                  cityData = isUpdated as City;
                                  cityController.text = isUpdated.name!;
                                });
                              }
                            }
                          : () {
                              showToastError('Pilih provinsi lebih dulu!');
                            },
                    ),
                  ],
                ),
              ),
            )),
            Container(
              padding: const EdgeInsets.all(Dimens.size16),
              child: RoundedButton(
                  width: double.infinity,
                  text: 'Simpan',
                  press: provinceData != null && cityData != null
                      ? () {
                          LocalStorageService.setCity(cityData!.id.toString());
                          LocalStorageService.setProvince(
                              provinceData!.id.toString());
                          LocalStorageService.setCityProvince(
                              '${cityData!.name}, ${provinceData!.name}');

                          Navigator.pop(context, true);
                        }
                      : null),
            )
          ],
        ));
  }
}
