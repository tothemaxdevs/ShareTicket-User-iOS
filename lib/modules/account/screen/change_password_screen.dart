import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/core/splash/splash_screen.dart';
import 'package:shareticket/modules/account/bloc/account/account_bloc.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class ChanePasswordArgument {
  final String? title;
  final String? userId;

  ChanePasswordArgument({this.title, this.userId});
}

class ChanePasswordScreen extends StatefulWidget {
  final ChanePasswordArgument? argument;

  const ChanePasswordScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/account/password';
  static const String title = 'Change Language';

  @override
  _ChanePasswordScreenState createState() => _ChanePasswordScreenState();
}

class _ChanePasswordScreenState extends State<ChanePasswordScreen> {
  String? title;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool enableButton = false;
  bool isLoadingButton = false;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypeNewPasswordConttroller = TextEditingController();
  AccountBloc? _accountBloc;

  @override
  void initState() {
    if (widget.argument!.title != null) {
      title = widget.argument?.title;
    } else {
      title = ChanePasswordScreen.title;
    }
    _accountBloc = AccountBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: appBar(context: context, title: title, backButton: true),
        body: BlocProvider(
          create: (context) => _accountBloc!,
          child: BlocConsumer<AccountBloc, AccountState>(
            builder: (context, state) {
              return _buildView();
            },
            listener: (context, state) => {
              if (state is PostChangePasswordLoadingState)
                {isLoadingButton = true}
              else if (state is PostChangePasswordLoadedState)
                {
                  isLoadingButton = false,
                  showToast('Password berhasil diganti.'),
                  Navigator.pop(context)
                }
              else if (state is PostChangePasswordErrorState)
                {
                  isLoadingButton = false,
                  showToastError('Gagal mengganti password.')
                }
              else if (state is PostChangePasswordFailedState)
                {
                  isLoadingButton = false,
                  showToastError('Password lama tidak sesuai.')
                }
            },
          ),
        ));
  }

  Form _buildView() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      onChanged: () =>
          setState(() => enableButton = _formKey.currentState!.validate()),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(Dimens.size16),
              children: [
                EditTextField(
                  controller: oldPasswordController,
                  label: LocaleKeys.auth_old_password,
                  hint: LocaleKeys.auth_old_password,
                  validator: requiredPassword,
                  isPasswordMode: true,
                  isMarginBottom: true,
                ),
                divide16,
                EditTextField(
                  controller: newPasswordController,
                  label: LocaleKeys.auth_new_password,
                  hint: LocaleKeys.auth_new_password,
                  validator: requiredPassword,
                  isPasswordMode: true,
                  isMarginBottom: true,
                ),
                EditTextField(
                  controller: retypeNewPasswordConttroller,
                  label: LocaleKeys.auth_confirm_new_password,
                  hint: LocaleKeys.auth_confirm_new_password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tidak boleh kosong';
                    } else if (value.length < 8) {
                      return 'Minimal 8 karakter';
                    } else if (value.length > 7 &&
                        value != newPasswordController.text) {
                      return 'Password baru tidak sama';
                    }
                    return null;
                  },
                  isPasswordMode: true,
                  isMarginBottom: true,
                ),
              ],
            ),
          ),
          divideThick(),
          Container(
            padding: const EdgeInsets.all(Dimens.size16),
            width: double.infinity,
            child: RoundedButton(
                isLoading: isLoadingButton,
                text: 'Ganti password',
                press: enableButton
                    ? () {
                        _postChangePassword();
                      }
                    : null),
          )
        ],
      ),
    );
  }

  void _postChangePassword() {
    Map<String, dynamic> body = {};
    body['current_password'] = oldPasswordController.text;
    body['password'] = newPasswordController.text;
    body['password_confirmation'] = retypeNewPasswordConttroller.text;

    _accountBloc!.add(ChangePasswordEvent(params: body));
  }
}

class LanguangeCard extends StatelessWidget {
  final String title, icon;
  final Function() onTap;
  const LanguangeCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimens.size16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.size16)),
            color: Colors.white),
        child: Row(
          children: [
            SvgUI(
              icon,
              height: 34,
              width: 34,
            ),
            divideW16,
            TextWidget(
              title,
              textColor: Pallete.primary,
              weight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
