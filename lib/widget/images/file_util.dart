import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/api/auth.api.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/home/component/menu_icon.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/images/target_file.dart';

editPhoto(BuildContext context,
    {bool fixedCropRatio = true,
    bool cropImage = true,
    Function(String?)? onUploaded}) async {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: modalShape(),
      builder: (BuildContext context) {
        return Container(
            height: 200,
            padding: const EdgeInsets.all(Dimens.size16),
            child: Column(
              children: [
                // TextWidget(
                //   'Unggah Gambar',
                //   fontSize: Dimens.size24,
                //   weight: FontWeight.bold,
                // ),
                // divide16,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MenuIcon(
                        title: LocaleKeys.core_camera,
                        isSvg: true,
                        svgIcon: 'ic_image_camera.svg',
                        onTap: () async {
                          Navigator.pop(context);
                          uploadImage(context, ImageSource.camera,
                              onUploaded: onUploaded, cropImage: cropImage);
                        },
                      ),
                      divideW56,
                      MenuIcon(
                        title: LocaleKeys.core_galery,
                        isSvg: true,
                        svgIcon: 'ic_image_galery.svg',
                        onTap: () async {
                          Navigator.pop(context);
                          uploadImage(context, ImageSource.gallery,
                              onUploaded: onUploaded, cropImage: cropImage);
                        },
                      ),
                    ],
                  ),
                ),
                divide10,

                divideThick(),
                divide10,
                RoundedButton(
                  text: LocaleKeys.core_cancel,
                  press: () {
                    Navigator.pop(context);
                  },
                  width: double.infinity,
                  color: Colors.white,
                  textColor: Colors.grey,
                  borderColor: Colors.transparent,
                )
              ],
            ));
      });
}

uploadImage(BuildContext context, ImageSource source,
    {TargetFile? targetFile,
    bool fixedCropRatio = true,
    bool cropImage = true,
    Function(String?)? onUploaded}) async {
  // var idResto = await SharedPreferencesHelper.getrestoId();
  ImagePicker? picker = ImagePicker();
  final PickedFile? pickedFile = await picker.getImage(source: source);
  var filePath;
  if (cropImage) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        compressQuality: 50,
        aspectRatioPresets: fixedCropRatio
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Sesuaikan Foto',
              toolbarColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]);

    filePath = File(croppedFile!.path);
  } else {
    filePath = File(pickedFile!.path);
  }

  return uploadToServer(filePath, onUploaded: onUploaded);
}

uploadToServer(File? file, {Function(String?)? onUploaded}) async {
  AuthApi api = AuthApi();
  Map<String, dynamic> body = Map();

  body['file'] = await MultipartFile.fromFile(file!.path);

  log(body.toString());
  try {
    Response response = await api.saveFile(body: body);
    if (response.statusCode == 200) {
      // log(response.data['data']['file'].toString());
      log(response.data);
      onUploaded!('DONE');
    }
  } on DioError catch (error) {
    if (error.response!.statusCode == 422) {
      // showToast(error.response!.data['messages'].toString());
      log(error.message.toString());
      return false;
    } else {
      log(error.message.toString());
      return false;
    }
  }
}
