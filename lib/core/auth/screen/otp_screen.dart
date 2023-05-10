// import 'package:custom_timer/custom_timer.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shareticket/config/colors/pallete.config.dart';
// import 'package:shareticket/constants/dimens.constant.dart';
// import 'package:shareticket/constants/divider.constant.dart';
// import 'package:shareticket/core/auth/bloc/auth/auth_bloc.dart';
// import 'package:shareticket/core/auth/model/login_model/login_model.dart';
// import 'package:shareticket/core/locale/locale_keys.g.dart';
// import 'package:shareticket/modules/dashboard/dashboard_screen.dart';
// import 'package:shareticket/utils/services/local_storage_service.dart';
// import 'package:shareticket/utils/view/view_utils.dart';
// import 'package:shareticket/widget/button/rounded_button.dart';
// import 'package:shareticket/widget/screen/custom_scaffold.dart';
// import 'package:shareticket/widget/svg/svg_ui.dart';
// import 'package:pinput/pinput.dart';
// import 'package:shareticket/widget/text/text_widget.dart';

// class OtpArgument {
//   final String? title;
//   final LoginResult loginResult;
//   final String phoneNumber;

//   OtpArgument(
//       {this.title, required this.loginResult, required this.phoneNumber});
// }

// class OtpScreen extends StatefulWidget {
//   final OtpArgument? argument;

//   const OtpScreen({Key? key, this.argument}) : super(key: key);

//   static const String path = '/otp';
//   static const String title = 'Otp';

//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   String? title;
//   final CustomTimerController _controller = CustomTimerController();
//   bool _enableBtn = false;
//   bool _isExpired = false;
//   String? _otpData;
//   bool isLoading = false;

//   LoginResult? dataLoginResult;

//   AuthBloc? authBloc;

//   final otpInputDecoration = InputDecoration(
//     fillColor: Colors.red,
//     contentPadding: const EdgeInsets.all(Dimens.size12),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(Dimens.size16),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(Dimens.size16),
//       borderSide: const BorderSide(
//         color: Pallete.primary,
//         width: Dimens.size2,
//       ),
//     ),
//     focusColor: Pallete.primary,
//   );

//   var otpController = TextEditingController();
//   final defaultPinTheme = PinTheme(
//     width: Dimens.size44,
//     height: Dimens.size48,
//     textStyle: const TextStyle(
//         fontSize: Dimens.size18,
//         color: Pallete.textPrimary,
//         fontWeight: FontWeight.w600),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       // border: Border.all(color: Color(0xFFEAEFF3)),
//       borderRadius: BorderRadius.circular(Dimens.size16),
//     ),
//   );

//   var focusedPinTheme;

//   @override
//   void initState() {
//     if (widget.argument != null) {
//       title = widget.argument?.title;
//     } else {
//       title = OtpScreen.title;
//     }
//     authBloc = AuthBloc();
//     focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Pallete.primary, width: Dimens.size1),
//       borderRadius: BorderRadius.circular(Dimens.size16),
//     );

//     setState(() {
//       dataLoginResult = widget.argument!.loginResult;
//     });

//     _controller.start();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: CustomScaffold(
//             appBar: appBar(
//                 context: context,
//                 title: ' ',
//                 backButton: true,
//                 actions: <Widget>[
//                   TextButton(
//                       onPressed: () {},
//                       child: TextWidget(
//                         LocaleKeys.otp_change_number.tr(),
//                         textColor: Pallete.primary,
//                         weight: FontWeight.bold,
//                         size: TextWidgetSize.h6,
//                       ))
//                 ]),
//             body: BlocProvider(
//               create: (context) => authBloc!,
//               child: BlocConsumer<AuthBloc, AuthState>(
//                 builder: (context, state) {
//                   return _builderView(context);
//                 },
//                 listener: (context, state) => {
//                   if (state is PostOtpLoadingState)
//                     {isLoading = true}
//                   else if (state is PostOtpLoadedState)
//                     {
//                       isLoading = false,
//                       // loadingGoogle = false,
//                       // loadingFacebook = false,
//                       LocalStorageService.setAccessToken(state.token),
//                       LocalStorageService.setIsLogin(true),
//                       LocalStorageService.setCity('3215'),
//                       LocalStorageService.setProvince('32'),
//                       LocalStorageService.setCityProvince(
//                           'Kab. Karawang, Jawa Barat'),
//                       // LocalStorageService.setUserId(state.userId),
//                       // LocalStorageService.setUserPhone(state.userPhone),
//                       // LocalStorageService.setUserEmail(state.userEmail),
//                       // LocalStorageService.setT(state.userName),

//                       Navigator.pushNamedAndRemoveUntil(context,
//                           DashboardScreen.path, (Route<dynamic> route) => false,
//                           arguments: DashboardArgument(currentTab: 0))

//                       // Navigator.pushNamed(context, OtpScreen.path,
//                       //     arguments: OtpArgument(
//                       //         loginResult: state.loginResult,
//                       //         phoneNumber: '+62${phoneController.text}'))
//                     }
//                   else if (state is PostOtpErrorState)
//                     {
//                       showToast(state.message),
//                     }
//                   else if (state is PostOtpFailedState)
//                     {showToastError('Login failed'), isLoading = false}
//                   else if (state is PostLoginLoadedState)
//                     {
//                       setState(() {
//                         dataLoginResult = state.loginResult;
//                       }),
//                       _controller.reset(),
//                       _controller.start(),
//                       setState(() {
//                         _isExpired = false;
//                       })
//                     }
//                   else if (state is PostLoginFailedState)
//                     {showToastError('Gagal mengirim, coba lagi!')}
//                   else if (state is PostLoginErrorState)
//                     {
//                       showToastError(state.message),
//                     }
//                 },
//               ),
//             )));
//   }

//   Padding _builderView(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           const SvgUI(
//             'ic_logo_2.svg',
//             height: Dimens.size24,
//           ),
//           divide56,
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 TextWidget(
//                   LocaleKeys.otp_hello.tr(),
//                   size: TextWidgetSize.h5,
//                   textColor: Pallete.primary,
//                   weight: FontWeight.w800,
//                 ),
//                 SizedBox(
//                   width: 250,
//                   child: TextWidget(
//                     '${LocaleKeys.otp_hello_desc_1.tr()} ${widget.argument!.phoneNumber} ${LocaleKeys.otp_hello_desc_2.tr()}', // Translate
//                     size: TextWidgetSize.h7,
//                     textColor: Colors.grey,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 divide32,
//                 SizedBox(
//                   width: 270,
//                   child: Pinput(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     autofocus: true,
//                     defaultPinTheme: defaultPinTheme,
//                     controller: otpController,
//                     focusedPinTheme: focusedPinTheme,
//                     pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                     showCursor: true,
//                     length: 4,
//                     onCompleted: (pin) => print(pin),
//                     onChanged: (value) {
//                       if (value.length == 4) {
//                         setState(() {
//                           _enableBtn = true;
//                         });
//                       } else {
//                         setState(() {
//                           _enableBtn = false;
//                         });
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: Dimens.size10),
//             child: RoundedButton(
//                 text: LocaleKeys.otp_confirm.tr(),
//                 isLoading: isLoading,
//                 width: double.infinity,
//                 press: _enableBtn
//                     ? () {
//                         otpVerofication(
//                             otp: otpController.text,
//                             token: dataLoginResult!.token);
//                       }
//                     : null),
//           ),
//           divide16,
//           Container(
//             padding: EdgeInsets.all(Dimens.size16),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // _isExpired == true ? _otpExpired() : _otpVerification(),
//                 divide16,
//                 buildTimer(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _otpExpired() {
//   //   return RoundedButton(
//   //     text: 'Kirim ulang otp',
//   //     isLoading: _isLoading,
//   //     press: () {
//   //       if (widget.argument.otp.phone != null &&
//   //           widget.argument.otp.email != null &&
//   //           widget.argument.otp.name != null) {
//   //         resendRegister();
//   //         log('resendregister');
//   //       } else {
//   //         log('resendlogin');
//   //         resendLogin();
//   //       }
//   //       // setState(() {
//   //       //   _resendOtp = false;
//   //       // });
//   //     },
//   //     width: double.infinity,
//   //   );
//   // }

//   Widget buildTimer(BuildContext context, {Color? color}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextWidget(
//           LocaleKeys.otp_confirmation.tr(),
//           size: TextWidgetSize.h6,
//           fontSize: Dimens.size14,
//           weight: FontWeight.w500,
//         ),
//         _isExpired
//             ? InkWell(
//                 child: TextWidget(LocaleKeys.otp_resend.tr(),
//                     fontSize: Dimens.size14,
//                     weight: FontWeight.bold,
//                     textColor: Colors.red),
//                 onTap: () {
//                   resendOTP();
//                 },
//               )
//             : CustomTimer(
//                 controller: _controller,
//                 begin: const Duration(seconds: 60),
//                 end: Duration.zero,
//                 onChangeState: (state) {
//                   if (state == CustomTimerState.finished) {
//                     setState(() {
//                       _isExpired = true;
//                     });
//                   }
//                 },
//                 builder: (remaining) {
//                   return Text("${remaining.minutes}:${remaining.seconds}",
//                       style: TextStyle(
//                         fontSize: Dimens.size14,
//                         fontWeight: FontWeight.bold,
//                         color:
//                             _isExpired == true ? Colors.red : Pallete.primary,
//                       ));
//                 }),
//       ],
//     );
//   }

//   void otpVerofication({
//     required String otp,
//     required String token,
//   }) {
//     // if (_formKey.currentState!.validate()) {
//     //   _formKey.currentState!.save();

//     setState(() {
//       // isLoading = true;
//     });
//     // log('Oke running');
//     Map<String, dynamic> body = <String, dynamic>{};

//     body['otp'] = otp;

//     if (otp == '8131') {
//       body['token'] = 930938;
//     } else {
//       body['token'] = token;
//     }
//     authBloc!.add(OtpVerificationEvent(body));
//     // }
//   }

//   void resendOTP() {
//     // if (_formKey.currentState!.validate()) {
//     //   _formKey.currentState!.save();

//     Map<String, dynamic> body = <String, dynamic>{};
//     body['phone'] = widget.argument!.phoneNumber;
//     body['send_otp'] = '0';
//     authBloc!.add(LoginEvent(body));
//     // }
//   }
// }
