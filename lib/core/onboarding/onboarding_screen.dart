import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/config/size/size.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/screen/login_screen.dart';
import 'package:shareticket/core/onboarding/component/build_content.dart';
import 'package:shareticket/core/onboarding/model/onboarding_model.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/widget/button/rounded_button.dart';

class OnboardingArgument {
  final String title;

  OnboardingArgument(this.title);
}

class OnboardingScreen extends StatefulWidget {
  final OnboardingArgument? argument;

  const OnboardingScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/onboarding';
  static const String title = 'Onboarding';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? title;
  int currentPage = 0;

  PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final List<OnboardingData> boarding = [
    OnboardingData(
        title: 'Lorem Ipsum',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec bibendum aliquam lectus vel lobortis.',
        images: 'onboarding/onboarding_1.svg'),
    OnboardingData(
        title: 'Lorem Ipsum',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec bibendum aliquam lectus vel lobortis.',
        images: 'onboarding/onboarding_2.svg'),
    OnboardingData(
        title: 'Lorem Ipsum',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec bibendum aliquam lectus vel lobortis.',
        images: 'onboarding/onboarding_3.svg'),
  ];

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = OnboardingScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    bool isLast = boarding.length - 1 == currentPage;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                controller: controller,
                itemCount: boarding.length,
                itemBuilder: (context, index) => OnBoardingContent(
                  title: boarding[index].title,
                  description: boarding[index].description,
                  imageFileName: boarding[index].images,
                ),
              ),
            ),
            divide24,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                boarding.length,
                (index) => buildDot(index),
              ),
            ),
            divide32,
            isLast == false
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size32, vertical: Dimens.size8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedButton(
                            text: 'Skip',
                            textColor: Pallete.primary,
                            color: Colors.transparent,
                            press: () {
                              _goHomeAndReplaceRoute();
                            }),
                        divide24,
                        RoundedButton(
                            width: 100,
                            text: 'Next',
                            press: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                            })
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.size32, vertical: Dimens.size8),
                    child: RoundedButton(
                        width: 150,
                        text: 'Lets Go',
                        press: () {
                          _goHomeAndReplaceRoute();
                        }),
                  ),
            divide32
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Pallete.primary : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  void _goHomeAndReplaceRoute() {
    LocalStorageService.setIsOnBoarding(false).then((value) => print(value));
    Navigator.pushReplacementNamed(context, LoginScreen.path);
  }
}
