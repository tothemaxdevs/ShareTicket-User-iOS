import 'package:flutter/material.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/svg/svg_ui.dart';

class SocialButton extends StatelessWidget {
  bool isGoogle;
  Function()? onTap;
  bool isLoading;
  bool isDisable;
  SocialButton(
      {Key? key,
      this.isGoogle = false,
      this.onTap,
      this.isLoading = false,
      this.isDisable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDisable ? Colors.grey.shade300 : Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.size128)),
        // border: Border.all(
        //     color: isGoogle == true ? Pallete.border : Color(0xFF0078FF)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.size128)),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            height: Dimens.size48,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.size10,
            ),
            child: isLoading
                ? Center(
                    child: loading(
                        color: isDisable ? Pallete.greyDark : Pallete.primary),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: SvgUI(
                              isGoogle == true
                                  ? 'ic_brand_google.svg'
                                  : 'ic_brand_apple.svg',
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isGoogle == true
                                  ? 'Masuk dengan Google'
                                  : 'Masuk dengan Apple',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimens.size14,
                                  color:
                                      isDisable ? Colors.grey : Colors.black),
                            ),
                          ],
                        ),
                      ),
                      divideW10,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
