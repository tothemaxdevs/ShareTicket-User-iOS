import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/account/model/account_data_result/account_data_result.dart';
import 'package:shareticket/modules/account/screen/delete_confirmation_screen.dart';
import 'package:shareticket/utils/font/iconly_icons.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/images/circle_avatar.dart';
import 'package:shareticket/widget/images/file_util.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class ProfileDetailArgument {
  AccountDataResult data;
  ProfileDetailArgument(this.data);
}

class ProfileDetailScreen extends StatefulWidget {
  final ProfileDetailArgument? argument;

  const ProfileDetailScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/profile/detail';
  static const String title = 'Update profile';

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  String? title;
  String? newName;
  String? newPhone;
  String? newEmail;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(
            context: context,
            backButton: true,
            title: LocaleKeys.account_update),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      divide20,
                      SvgUI(
                        'ic_profile_blank.svg',
                        width: 110,
                        height: 110,
                      ),
                    ],
                  ),
                  divide20,
                  ListTile(
                    title: TextWidget('Nama',
                        size: TextWidgetSize.h7,
                        weight: FontWeight.w600,
                        textColor: Pallete.primary),
                    subtitle: TextWidget(widget.argument!.data.user!.fullname,
                        size: TextWidgetSize.h5, textColor: Pallete.primary),
                  ),
                  divideThick(),
                  ListTile(
                    title: TextWidget('Nomor HP',
                        size: TextWidgetSize.h7,
                        weight: FontWeight.w600,
                        textColor: Pallete.primary),
                    subtitle: TextWidget(
                        widget.argument!.data.user!.phone ?? '-',
                        size: TextWidgetSize.h5,
                        textColor: Pallete.primary),
                  ),
                  divideThick(),
                  ListTile(
                    title: TextWidget('Email',
                        size: TextWidgetSize.h7,
                        weight: FontWeight.w600,
                        textColor: Pallete.primary),
                    subtitle: TextWidget(
                        widget.argument!.data.user!.email ?? '-',
                        size: TextWidgetSize.h5,
                        textColor: Pallete.primary),
                  ),
                  divideThick(height: 10.0),
                  InkWell(
                    onTap: () {
                      confirmationDialog();
                    },
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimens.size16, vertical: Dimens.size20),
                        child: TextWidget(
                          'Hapus Akun',
                          textColor: Colors.red,
                          weight: FontWeight.w600,
                          size: TextWidgetSize.h6,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  void confirmationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(
            title: 'Hapus Akun',
            descriptions: 'Apakah anda yakin ingin menghapus akun?',
            onOkTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, DeleteConfirmationScreen.path);
            },
            enableCancel: true,
            okBakcgroundColor: Colors.red[700],
          );
        });
  }
}
