import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/bloc/auth/auth_bloc.dart';
import 'package:shareticket/core/auth/screen/forgot_password_email_send_screen.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class ForgotPasswordArgument {
  final String title;

  ForgotPasswordArgument(this.title);
}

class ForgotPasswordScreen extends StatefulWidget {
  final ForgotPasswordArgument? argument;

  const ForgotPasswordScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/forgotpassword';
  static const String title = 'Forgot Password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? title;
  AuthBloc? _authBloc;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool enableButton = false;
  bool isLoadingButton = false;
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = ForgotPasswordScreen.title;
    }
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Pallete.screenBackground,
            appBar: appBar(context: context, backButton: true, title: ''),
            body: BlocProvider(
              create: (context) => _authBloc!,
              child: BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  return _buildView(context);
                },
                listener: (context, state) => {
                  if (state is PostResetPasswordLoadingState)
                    {
                      isLoadingButton = true,
                    }
                  else if (state is PostResetPasswordLoadedState)
                    {
                      isLoadingButton = false,
                      Navigator.pushReplacementNamed(
                          context, ForgotPasswordSentScreen.path,
                          arguments:
                              ForgotPasswordSentArgument(emailController.text)),
                    }
                  else if (state is PostResetPasswordErrorState)
                    {
                      isLoadingButton = false,
                      showToastError('Gagal mengirim permintaan.')
                    }
                  else if (state is PostResetPasswordFailedState)
                    {
                      isLoadingButton = false,
                      showToastError('Error mengirim permintaan.')
                    }
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
                      'ic_forgot_password.svg',
                      width: 200,
                    ),
                    divide16,
                    TextWidget(
                      'Lupa password?',
                      size: TextWidgetSize.h3,
                      textColor: Pallete.primary,
                      weight: FontWeight.bold,
                    ),
                    divide8,
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextWidget(
                        'Masukan alamat email yang terhubung ke akun kamu',
                        size: TextWidgetSize.h6,
                        textAlign: TextAlign.center,
                        textColor: Pallete.greyDark,
                      ),
                    ),
                    EditTextField(
                      controller: emailController,
                      label: 'Email',
                      hint: 'Masukan Email',
                      isMarginTop: true,
                      isMarginBottom: true,
                      validator: requiredEmail,
                    ),
                    RoundedButton(
                        text: 'Reset Password',
                        width: double.infinity,
                        isLoading: isLoadingButton,
                        press: enableButton
                            ? () {
                                _postForgotPassword();
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

  void _postForgotPassword() {
    Map<String, dynamic> body = {};
    body['email'] = emailController.text;
    _authBloc!.add(ResetPasswordEvent(params: body));
  }
}
