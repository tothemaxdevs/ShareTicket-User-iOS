import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/bloc/auth/auth_bloc.dart';
import 'package:shareticket/core/auth/component/double_text_button.dart';
import 'package:shareticket/core/auth/component/or.dart';
import 'package:shareticket/core/auth/component/social_button.dart';
import 'package:shareticket/core/auth/model/user_data_model/user_data.dart';
import 'package:shareticket/core/auth/model/user_model/user_model.dart';
import 'package:shareticket/core/auth/screen/forgot_password_screen.dart';
import 'package:shareticket/core/auth/screen/otp_forgot_password_screen.dart';
import 'package:shareticket/core/auth/screen/register_screen.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginMobileArgument {
  final String title;

  LoginMobileArgument(this.title);
}

class LoginMobileScreen extends StatefulWidget {
  final LoginMobileArgument? argument;

  const LoginMobileScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  static const String path = '/loginMobile';
  static const String title = 'LoginMobile';

  @override
  _LoginMobileScreenState createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends State<LoginMobileScreen> {
  String? title;
  String? validator = '';
  UserData userData = UserData();
  //  GoogleSignInAccount _userObj;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: , serverClientId: );

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loginWithOTP = false;
  bool enableLoginButton = false;
  bool isEmail = false;
  bool isLoading = false;
  bool loadingGoogle = false;
  bool loadingFacebook = false;
  AuthBloc? _authBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = LoginMobileScreen.title;
    }

    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return SafeArea(
        child: Scaffold(
      appBar: appBar(context: context, backButton: true, title: ' '),
      backgroundColor: Pallete.screenBackground,
      body: BlocProvider(
        create: (context) => _authBloc!,
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            return _buildView(context);
          },
          listener: (context, state) => {
            if (state is PostLoginLoadingState)
              {isLoading = true}
            else if (state is PostLoginLoadedState)
              {
                isLoading = false,
                Navigator.pushNamed(context, OtpScreen.path,
                    arguments: OtpArgument(
                        loginResult: state.loginResult!,
                        phoneNumber: '62${phoneController.text}'))
              }
            else if (state is PostLoginErrorState)
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogBox(
                        descriptions: state.message,
                        onOkText: LocaleKeys.core_save,
                        title: LocaleKeys.core_ok,
                      );
                    }),
                _disableLoading()
              }
            else if (state is PostLoginFailedState)
              {
                isLoading = false,
                showToastError(state.response.data['messages'].toString())
              }
            else if (state is PostLoginSocialLoadedState)
              {
                LocalStorageService.setAccessToken(state.accessToken),
                LocalStorageService.setIsLogin(true),
                LocalStorageService.setCity('3215'),
                LocalStorageService.setProvince('32'),
                LocalStorageService.setCityProvince(
                    'Kab. Karawang, Jawa Barat'),
                Navigator.pushNamedAndRemoveUntil(
                    context, DashboardScreen.path, (route) => false,
                    arguments: DashboardArgument(currentTab: 0))
              }
            else if (state is PostLoginSocialFailedState)
              {
                if (state.response.statusCode == 500)
                  {showToastError('Login failed, try again!')}
                else
                  {
                    showToastError(state.response.data['messages'].toString()),
                  },
                _disableLoading(),
              }
            else if (state is PostLoginSocialErrorState)
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogBox(
                        descriptions: state.message,
                        onOkText: LocaleKeys.core_save,
                        title: LocaleKeys.core_ok,
                      );
                    }),
                _disableLoading()
              }
            else

            ///
            ///
            if (state is PostLoginBasicLoadingState)
              {isLoading = true}
            else if (state is PostLoginBasicLoadedState)
              {
                isLoading = false,
                Navigator.pushNamedAndRemoveUntil(
                    context, DashboardScreen.path, (route) => false,
                    arguments: DashboardArgument(currentTab: 0)),
                LocalStorageService.setAccessToken(
                    state.data!.data!.token!.accessToken),
                LocalStorageService.setIsLogin(true),
                LocalStorageService.setCity('3215'),
                LocalStorageService.setProvince('32'),
                LocalStorageService.setCityProvince(
                    'Kab. Karawang, Jawa Barat'),
              }
            else if (state is PostLoginBasicErrorState)
              {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogBox(
                        descriptions: state.message,
                        onOkText: LocaleKeys.core_save,
                        title: LocaleKeys.core_ok,
                      );
                    }),
                _disableLoading()
              }
            else if (state is PostLoginBasicFailedState)
              {
                isLoading = false,
                if (state.response.statusCode == 500)
                  {showToastError('Login failed, try again!')}
                else
                  {
                    showToastError(state.response.data['messages'].toString()),
                  },
                // showToastError(state.response.data['messages'].toString())
              }
          },
        ),
      ),
    ));
  }

  void _disableLoading() {
    return setState(() {
      isLoading = false;
      loadingGoogle = false;
      loadingFacebook = false;
    });
  }

  Form _buildView(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () =>
          setState(() => enableLoginButton = _formKey.currentState!.validate()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            // const SvgUI(
            //   'ic_logo_2.svg',
            //   height: Dimens.size24,
            // ),
            // divide56,
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      LocaleKeys.login_hello.tr(), // Translate
                      size: TextWidgetSize.h3,
                      textColor: Pallete.primary,
                      weight: FontWeight.w700,
                    ),
                    divide4,
                    SizedBox(
                      width: 250,
                      child: TextWidget(
                        LocaleKeys.login_hello_desc.tr(),
                        // Translate
                        size: TextWidgetSize.h6,
                        textColor: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    divide40,
                    EditTextField(
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
                    // EditTextField(
                    //   controller: emailController,
                    //   label: LocaleKeys.core_email,
                    //   hint: LocaleKeys.auth_enter_email,
                    //   validator: requiredEmail,
                    //   isMarginBottom: true,
                    // ),
                    EditTextField(
                      controller: passwordController,
                      label: LocaleKeys.core_password,
                      hint: LocaleKeys.auth_enter_password,
                      validator: requiredPassword,
                      isPasswordMode: true,
                      isMarginBottom: false,
                    ),

                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ForgotPasswordScreen.path);
                          },
                          child: TextWidget(
                            'Lupa password?',
                            textColor: Pallete.primary,
                            size: TextWidgetSize.h6,
                            weight: FontWeight.w600,
                          )),
                    ),
                    RoundedButton(
                      text: LocaleKeys.auth_login.tr(),
                      // text: 'Request OTP',
                      width: double.infinity,
                      isLoading: isLoading,
                      press: enableLoginButton
                          ? () {
                              loginBasic(
                                  phone: phoneController.text,
                                  password: passwordController.text);
                              // Navigator.pushNamed(context, OtpScreen.path);
                            }
                          : null,
                    ),
                    // SocialButton(
                    //   isLoading: loadingFacebook,
                    //   isGoogle: false,
                    //   onTap: loadingFacebook
                    //       ? null
                    //       : () {
                    //           facebookSignIn();
                    //           // Navigator.pushNamed(
                    //           //     context, TestFacebookScreen.path);
                    //         },
                    // ),
                    // divide10,
                    // SocialButton(
                    //   isLoading: loadingGoogle,
                    //   isDisable: false,
                    //   onTap: loadingGoogle
                    //       ? null
                    //       : () {
                    //           // googleSignIn();
                    //           // _handleSignOut();

                    //           signInWithGoogle();
                    //           // signOut();
                    //         },
                    //   isGoogle: true,
                    //   // onTap: null,
                    // )
                    // Row(
                    //   children: [
                    //     Flexible(
                    //         child: ),
                    //     divideW16,
                    //     Flexible(
                    //         child: ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            // Spacer(),
            DoubleTextButton(
              normalText: LocaleKeys.auth_didnt_have_account,
              boldText: LocaleKeys.auth_register,
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.path);
              },
            )
          ],
        ),
      ),
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    // return await s
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    return setState(() async {
      await FirebaseAuth.instance.signInWithCredential(credential);

      loginSocial(
          email: FirebaseAuth.instance.currentUser!.email!,
          name: FirebaseAuth.instance.currentUser!.displayName!,
          provider: 'google');
      // log(userData.displayName.toString());
      // showToast('hello ${FirebaseAuth.instance.currentUser!.displayName}');
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void login({required String phone}) {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    Map<String, dynamic> body = <String, dynamic>{};
    body['phone'] = '62$phone';
    body['send_otp'] = '0';
    _authBloc!.add(LoginEvent(body));
    // }
  }

  void loginBasic({required String phone, required String password}) {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    Map<String, dynamic> body = <String, dynamic>{};
    body['phone'] = '62$phone';
    body['password'] = password;
    _authBloc!.add(LoginBasicEvent(body));
    // }
  }

  void loginSocial(
      {required String name, required String email, required String provider}) {
    setState(() {
      if (provider == 'google') {
        loadingGoogle = true;
      } else {
        loadingFacebook = true;
      }
    });
    Map<String, dynamic> body = <String, dynamic>{};
    body['email'] = email;
    body['provider'] = provider;
    body['fullname'] = name;
    _authBloc!.add(LoginSocialEvent(body));
    // }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
