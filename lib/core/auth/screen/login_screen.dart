import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/bloc/auth/auth_bloc.dart';
import 'package:shareticket/core/auth/component/or.dart';
import 'package:shareticket/core/auth/component/social_button.dart';
import 'package:shareticket/core/auth/model/user_data_model/user_data.dart';
import 'package:shareticket/core/auth/model/user_model/user_model.dart';
import 'package:shareticket/core/auth/screen/login_mobile_screen.dart';
import 'package:shareticket/core/auth/screen/otp_forgot_password_screen.dart';
import 'package:shareticket/core/locale/locale_keys.g.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginArgument {
  final String title;

  LoginArgument(this.title);
}

class LoginScreen extends StatefulWidget {
  final LoginArgument? argument;

  const LoginScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  static const String path = '/login';
  static const String title = 'Login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? title;
  String? validator = '';
  UserData userData = UserData();
  //  GoogleSignInAccount _userObj;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: , serverClientId: );

  // 000708.8bdbbf2065054fb18a2753a658954ab3.0443

  final databaseReference = FirebaseDatabase.instance.reference();

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool loginWithOTP = false;
  bool enableLoginButton = false;
  bool isEmail = false;
  bool isLoading = false;
  bool loadingGoogle = false;
  bool loadingIos = false;
  AuthBloc? _authBloc;

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = LoginScreen.title;
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
      backgroundColor: Pallete.screenBackground,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Pallete.backgroundColor),
        ),
        child: BlocProvider(
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
                      showToastError(
                          state.response.data['messages'].toString()),
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
                      showToastError(
                          state.response.data['messages'].toString()),
                    },
                  // showToastError(state.response.data['messages'].toString())
                }
            },
          ),
        ),
      ),
    ));
  }

  void _disableLoading() {
    return setState(() {
      isLoading = false;
      loadingGoogle = false;
      loadingIos = false;
    });
  }

  Widget _buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgUI(
            'ic_login_sticket.svg',
            width: MediaQuery.of(context).size.width * 0.75,
          ),
          divide40,
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
          SocialButton(
            isLoading: loadingGoogle,
            isDisable: false,
            onTap: loadingGoogle
                ? null
                : () {
                    signInWithGoogle();
                    // signOut();
                  },
            isGoogle: true,
            // onTap: null,
          ),
          divide20,
          SocialButton(
            isLoading: loadingIos,
            isDisable: false,
            onTap: loadingIos
                ? null
                : () {
                    signInWithApple();
                  },
            isGoogle: false,
            // onTap: null,
          ),
          divide20,
          const Or(),
          divide20,
          RoundedButton(
              text: 'Masuk dengan nomor handphone',
              // text: 'Request OTP',
              width: double.infinity,
              isLoading: isLoading,
              press: () {
                Navigator.pushNamed(context, LoginMobileScreen.path);
                // createUser();

                // readUser('123456');
              }),
        ],
      ),
    );
  }

  void createUser() {
    UserIos user = UserIos(
      name: "John Doe",
      email: "johndoe@example.com",
      iosId: "123456",
    );
    firestore.collection("iosUser").doc(user.iosId).set(user.toJson());
  }

  void createUserCheckp(UserIos user) {
    DocumentReference docRef = firestore.collection("iosUser").doc(user.iosId);
    docRef.set(user.toJson(), SetOptions(merge: true)).then((value) {
      print('User created successfully');
    }).catchError((error) {
      print('Failed to create user: $error');
    });
  }

  void readUser(String iosId) {
    firestore
        .collection("iosUser")
        .doc(iosId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      UserIos user =
          UserIos.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      log('Name: ${user.name}');
      log('Email: ${user.email}');
      loginSocial(email: user.email!, name: user.name!, provider: 'ios');
    });
  }

  void updateUser(String iosId) {
    firestore.collection("iosUser").doc(iosId).update({
      "name": "Jane Doe",
      "email": "janedoe@example.com",
    });
  }

  void deleteUser(String iosId) {
    firestore.collection("iosUser").doc(iosId).delete();
  }

  // Future<void> googleSignIn() async {
  //   _googleSignIn.signOut().then((value) {}).catchError((e) {});
  //   _googleSignIn.signIn().then((userData) {
  //     setState(() {
  //       if (userData!.id.isNotEmpty) {
  //         setState(() {
  //           loadingGoogle = true;
  //         });
  //         log('hey im here');
  //         // login(email: userData.email, password: userData.id);

  //         loginSocial(
  //             email: userData.email,
  //             name: userData.displayName!,
  //             provider: 'google');
  //         log(userData.displayName.toString());
  //         // showToast('hello ${userData.displayName}');
  //       }
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  signInWithGoogle() async {
    // // Trigger the authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn(
    //         scopes: <String>["email"], clientId: '109109715771946427863')
    //     .signIn();

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

  signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential);

    // log('-------------');
    // log(credential.toString());
    // log('ID 1 ${credential.authorizationCode}');
    // log('ID 2 ${credential.email}');
    // log('ID 3 ${credential.givenName}');
    // log('ID 4 ${credential.familyName}');
    // log('ID 5 ${credential.identityToken}');
    // log('ID 6 ${credential.state}');
    // log('ID 7 ${credential.userIdentifier}');

    // log('-------------');

    if (credential.email != null) {
      loginSocial(
          email: credential.email!,
          name: credential.userIdentifier!,
          provider: 'ios');

      createUserCheckp(UserIos(
          email: credential.email,
          iosId: credential.userIdentifier,
          name: '${credential.givenName} ${credential.familyName}'));
    } else {
      readUser(credential.userIdentifier!);
    }
  }

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
        loadingIos = true;
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

class UserIos {
  String? id;
  String? name;
  String? email;
  String? iosId;

  UserIos({this.id, this.name, this.email, this.iosId});

  factory UserIos.fromJson(Map<String, dynamic> json) {
    return UserIos(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      iosId: json['iosId'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'iosId': iosId,
      };
}
