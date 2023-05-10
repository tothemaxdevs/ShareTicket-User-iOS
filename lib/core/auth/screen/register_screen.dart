import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/bloc/auth/auth_bloc.dart';
import 'package:shareticket/core/auth/component/double_text_button.dart';
import 'package:shareticket/core/auth/model/user_data_model/user_data.dart';
import 'package:shareticket/core/auth/model/user_model/user_model.dart';
import 'package:shareticket/core/auth/screen/otp_forgot_password_screen.dart';
import 'package:shareticket/core/auth/screen/otp_screen.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class RegisterArgument {
  final String title;

  RegisterArgument(this.title);
}

class RegisterScreen extends StatefulWidget {
  final RegisterArgument? argument;

  const RegisterScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/register';
  static const String title = 'Register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? title;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool enableRegisterButton = false;
  bool isLoading = false;
  bool isWithEmail = false;

  AuthBloc? _authBloc;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserData userData = UserData();
  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = RegisterScreen.title;
    }
    _authBloc = AuthBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return SafeArea(
        child: CustomScaffold(
      appBar: appBar(context: context, title: ' ', backButton: true),
      body: BlocProvider(
        create: (context) => _authBloc!,
        child: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            return _buildView(context);
          },
          listener: (context, state) => {
            if (state is PostRegisterLoadingState)
              {isLoading = true}
            else if (state is PostRegisterLoadedState)
              {
                isLoading = false,
                // loadingGoogle = false,
                // loadingFacebook = false,
                // LocalStorageService.setAccessToken(),
                // LocalStorageService.setUserId(state.userId),
                // LocalStorageService.setUserPhone(state.userPhone),
                // LocalStorageService.setUserEmail(state.userEmail),
                // LocalStorageService.setUserName(state.userName),

                // Navigator.pushNamedAndRemoveUntil(context, DashboardScreen.path,
                //     (Route<dynamic> route) => false)

                Navigator.pushNamed(context, OtpScreen.path,
                    arguments: OtpArgument(
                        loginResult: state.loginResult,
                        phoneNumber: '+62${phoneController.text}'))
              }
            else if (state is PostRegisterErrorState)
              {
                showToast(state.message),
              }
            else if (state is PostRegisterFailedState)
              {
                // showToast(state.response.statusCode.toString()),
                showToastError(
                    'Register failed : ${state.response.statusMessage}'),
                isLoading = false
              }
            else if (state is PostRegisterBasicLoadingState)
              {isLoading = true}
            else if (state is PostRegisterBasicLoadedState)
              {
                isLoading = false,
                Navigator.pushNamedAndRemoveUntil(
                    context, DashboardScreen.path, (route) => false,
                    arguments: DashboardArgument(currentTab: 0)),
                LocalStorageService.setAccessToken(
                    state.data.data!.token!.accessToken),
                LocalStorageService.setIsLogin(true),
                LocalStorageService.setCity('3215'),
                LocalStorageService.setProvince('32'),
                LocalStorageService.setCityProvince(
                    'Kab. Karawang, Jawa Barat'),
              }
            else if (state is PostRegisterBasicErrorState)
              {
                showToast(state.message),
              }
            else if (state is PostRegisterBasicFailedState)
              {
                showToastError(
                    'Register failed : ${state.response.data['messages']}'),
                isLoading = false
              }
          },
        ),
      ),
    ));
  }

  Form _buildView(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      onChanged: () => setState(
          () => enableRegisterButton = _formKey.currentState!.validate()),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.size16, horizontal: Dimens.size24),
        child: Column(
          children: [
            const SvgUI(
              'ic_logo_2.svg',
              height: Dimens.size24,
            ),
            divide28,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      LocaleKeys.register_hello.tr(), // Translate
                      size: TextWidgetSize.h4,
                      textColor: Pallete.primary,
                      weight: FontWeight.w800,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextWidget(
                        LocaleKeys.register_hello_desc.tr(), // Translate
                        size: TextWidgetSize.h7,
                        textColor: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    divide40,
                    EditTextField(
                        controller: nameController,
                        label: LocaleKeys.core_name,
                        hint: LocaleKeys.auth_enter_name,
                        isMarginBottom: true,
                        validator: validateLetterOnly),
                    EditTextField(
                      prefixIcon: InkWell(
                        onTap: () {
                          // countryPicker(context: context);
                        },
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
                      isNumber: true,
                      limit: 12,
                      validator: validateMobile,
                      onChanged: (value) =>
                          mobileZeroRemover(value, phoneController),
                    ),
                    EditTextField(
                      controller: emailController,
                      label: LocaleKeys.core_email,
                      hint: LocaleKeys.auth_enter_email,
                      validator: requiredEmail,
                      isMarginBottom: true,
                    ),
                    EditTextField(
                      controller: passwordController,
                      label: LocaleKeys.core_password,
                      hint: LocaleKeys.auth_enter_password,
                      validator: requiredPassword,
                      isPasswordMode: true,
                      isMarginBottom: true,
                    ),

                    RoundedButton(
                      isLoading: isLoading,
                      text: LocaleKeys.auth_register,
                      width: double.infinity,
                      press: enableRegisterButton
                          ? () {
                              registrationBasic(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          : null,
                    ),
                    // press: enableRegisterButton
                    //     ? () {
                    //         registration(
                    //           name: nameController.text,
                    //           email: emailController.text,
                    //           phone: phoneController.text,
                    //           password: passwordController.text,
                    //           provider: 'email',
                    //           isEmail: true,
                    //         );
                    //         isLoading = true;
                    //       }
                    //     : null),
                    // divide10,
                    // const Or(),
                    // divide20,
                    // Row(
                    //   children: [
                    //     Flexible(
                    //         child: SocialButton(
                    //       isGoogle: false,
                    //       onTap: facebookSignIn,
                    //     )),
                    //     divideW16,
                    //     Flexible(
                    //         child: SocialButton(
                    //       isGoogle: true,
                    //       onTap: googleSignIn,
                    //     )),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
            // const Spacer(),
            DoubleTextButton(
              normalText: LocaleKeys.auth_have_account,
              boldText: LocaleKeys.auth_login,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> googleSignIn() async {
    _googleSignIn.signOut().then((value) {}).catchError((e) {});
    _googleSignIn.signIn().then((userData) {
      setState(() {
        if (userData!.id.isNotEmpty) {
          // login(email: userData.email, password: userData.id)
          registration(
            name: userData.displayName!,
            email: userData.email,
            // password: userData.id,
            // provider: 'google',
            // isEmail: false,
          );
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  void registration({
    required String name,
    required String email,
    String? phone,
  }) {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    setState(() {});
    log('Oke running');
    Map<String, dynamic> body = <String, dynamic>{};
    body['provider'] = 'EMAIL';
    body['fullname'] = name;
    body['email'] = email;
    body['phone'] = '62$phone';
    body['send_otp'] = '0';
    _authBloc!.add(RegisterEvent(body));
    // }
  }

  void registrationBasic({
    required String name,
    required String email,
    String? phone,
  }) {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    setState(() {});
    log('Oke running');
    Map<String, dynamic> body = <String, dynamic>{};
    body['provider'] = 'EMAIL';
    body['fullname'] = name;
    body['email'] = email;
    body['phone'] = '62$phone';
    body['status'] = 'ACTIVE';
    body['password'] = passwordController.text;
    _authBloc!.add(RegisterBasicEvent(body));
    // }
  }
}
