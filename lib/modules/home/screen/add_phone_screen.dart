import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/bloc/auth/auth_bloc.dart';
import 'package:shareticket/core/auth/screen/forgot_password_email_send_screen.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/bloc/account/account_bloc.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class AddPhoneNumberArgument {
  final String title;

  AddPhoneNumberArgument(this.title);
}

class AddPhoneNumberScreen extends StatefulWidget {
  final AddPhoneNumberArgument? argument;

  const AddPhoneNumberScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/AddPhoneNumber';
  static const String title = 'Forgot Password';

  @override
  _AddPhoneNumberScreenState createState() => _AddPhoneNumberScreenState();
}

class _AddPhoneNumberScreenState extends State<AddPhoneNumberScreen> {
  String? title;
  late AccountBloc _accountBloc;
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool enableButton = false;
  bool isLoadingButton = false;
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = AddPhoneNumberScreen.title;
    }
    _accountBloc = AccountBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Pallete.screenBackground,
            appBar: appBar(context: context, backButton: true, title: ''),
            body: BlocProvider(
              create: (context) => _accountBloc,
              child: BlocConsumer<AccountBloc, AccountState>(
                builder: (context, state) {
                  return _buildView(context);
                },
                listener: (context, state) => {
                  if (state is PostUpdatePhoneLoadingState)
                    {
                      isLoadingButton = true,
                    }
                  else if (state is PostUpdatePhoneLoadedState)
                    {isLoadingButton = false, Navigator.pop(context)}
                  else if (state is PostUpdatePhoneErrorState)
                    {
                      isLoadingButton = false,
                      showToastError('Gagal mengirim permintaan.')
                    }
                  else if (state is PostUpdatePhoneFailedState)
                    {isLoadingButton = false, showToastError(state.message)}
                },
              ),
            )));
  }

  Widget _buildView(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      onChanged: () =>
          setState(() => enableButton = _formKey.currentState!.validate()),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Column(
                  children: [
                    const SvgUI(
                      'ic_add_phone_number.svg',
                      width: 200,
                    ),
                    divide16,
                    TextWidget(
                      'Tambahkan nomor',
                      size: TextWidgetSize.h3,
                      textColor: Pallete.primary,
                      weight: FontWeight.bold,
                    ),
                    divide8,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextWidget(
                        'Tamhbahkan nomor handphone untuk melengkapi akunmu.',
                        size: TextWidgetSize.h6,
                        textAlign: TextAlign.center,
                        textColor: Pallete.greyDark,
                      ),
                    ),
                    EditTextField(
                      autofocus: true,
                      isMarginTop: true,
                      isNumber: true,
                      prefixIcon: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(Dimens.size6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SvgUI(
                                'ic_locale_id.svg',
                              ),
                              divideW4,
                              TextWidget(
                                '+62',
                                size: TextWidgetSize.h6,
                              ),
                              divideW4,
                              Container(
                                width: Dimens.size1,
                                height: 20,
                                color: Colors.grey.shade300,
                              )
                            ],
                          ),
                        ),
                      ),
                      controller: phoneController,
                      label: LocaleKeys.core_phone,
                      hint: LocaleKeys.auth_enter_phone,
                      isMarginBottom: true,
                      validator: validateMobile,
                      limit: 12,
                      onChanged: (value) {
                        mobileZeroRemover(value, phoneController);
                      },
                    ),
                    RoundedButton(
                        text: 'Simpan',
                        width: double.infinity,
                        isLoading: isLoadingButton,
                        press: enableButton
                            ? () {
                                _postAddPhoneNumber();
                              }
                            : null),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _postAddPhoneNumber() {
    Map<String, dynamic> body = {};
    body['phone_number'] = '62${phoneController.text}';
    _accountBloc.add(UpdatePhoneEvent(params: body));
  }
}
