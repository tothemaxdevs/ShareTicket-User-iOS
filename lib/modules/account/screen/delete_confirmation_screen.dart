import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/core/auth/screen/login_screen.dart';
import 'package:shareticket/modules/account/bloc/account/account_bloc.dart';
import 'package:shareticket/modules/account/component/custom_dialog_box.dart';
import 'package:shareticket/utils/services/local_storage_service.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class DeleteConfirmationArgument {
  final String id;
  DeleteConfirmationArgument({required this.id});
}

class DeleteConfirmationScreen extends StatefulWidget {
  final DeleteConfirmationArgument? argument;

  const DeleteConfirmationScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/DeleteConfirmation';
  static const String title = 'Hapus Akun';

  @override
  _DeleteConfirmationScreenState createState() =>
      _DeleteConfirmationScreenState();
}

class _DeleteConfirmationScreenState extends State<DeleteConfirmationScreen> {
  String? title;
  var validationController = TextEditingController();
  bool? enableDeleteButton = false;
  bool? isLoadingButton = false;

  AccountBloc? _accountBloc;

  @override
  void initState() {
    _accountBloc = AccountBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBar(
          context: context,
          backButton: true,
          title: DeleteConfirmationScreen.title,
        ),
        body: BlocProvider(
          create: (context) => _accountBloc!,
          child: BlocConsumer<AccountBloc, AccountState>(
              builder: (context, state) {
                return _buildView(context);
              },
              listener: (context, state) => {
                    if (state is PostDeleteUserLoadingState)
                      {
                        isLoadingButton = true,
                      }
                    else if (state is PostDeleteUserLoadedState)
                      {
                        isLoadingButton = false,
                        showToast('Akun berhasil terhapus'),
                        FirebaseAuth.instance.signOut(),
                        LocalStorageService.removeValues(),
                        // _googleSignIn.disconnect();
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.path, (route) => false),
                      }
                    else if (state is PostDeleteUserFailedState)
                      {
                        isLoadingButton = false,
                        showToastError('Gagal menghapus akun.'),
                      }
                    else if (state is PostDeleteUserErrorState)
                      {
                        isLoadingButton = false,
                        showToastError('Error menghapus akun.'),
                      }
                  }),
        ));
  }

  Column _buildView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              divide10,
              TextWidget(
                'Perhatian',
                size: TextWidgetSize.h2,
                weight: FontWeight.bold,
              ),
              divide10,
              TextWidget(
                  'Jika Anda memilih untuk menghapus akun Anda dari aplikasi Share Ticket, tolong diperhatikan bahwa tindakan ini bersifat permanen dan tidak dapat dibatalkan. Menghapus akun Anda akan mengakibatkan hilangnya semua data yang terkait dengan akun Anda, termasuk transaksi atau pembelian yang dilakukan melalui aplikasi.\n\nSebelum melanjutkan dengan penghapusan akun Anda, disarankan untuk membuat cadangan dari semua data atau informasi penting yang ingin Anda simpan. Ini mungkin termasuk riwayat transaksi, tanda terima pembelian, atau data lain yang telah Anda simpan dalam aplikasi.\n\nSetelah Anda mengkonfirmasi penghapusan akun Anda, semua informasi dan data Anda akan dihapus secara permanen dari server aplikasi dan tidak akan dapat dipulihkan. Mohon pertimbangkan dengan seksama sebelum melanjutkan dengan penghapusan akun Anda.'),
              divide16,
              EditTextField(
                  onChanged: (value) {
                    setState(() {
                      if (value == 'HAPUS AKUN') {
                        enableDeleteButton = true;
                      } else {
                        enableDeleteButton = false;
                      }
                    });
                  },
                  controller: validationController,
                  hint: 'HAPUS AKUN',
                  label: 'Masukan HAPUS AKUN')
            ],
          ),
        ),
        divideThick(),
        Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + Dimens.size16,
              top: Dimens.size16,
              left: Dimens.size16,
              right: Dimens.size16),
          child: RoundedButton(
              color: Colors.red[700],
              width: double.infinity,
              text: 'Hapus Akun',
              isLoading: isLoadingButton!,
              press: enableDeleteButton!
                  ? () {
                      confirmationDialog();
                    }
                  : null),
        )
      ],
    );
  }

  void confirmationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(
            title: 'Hapus Akun',
            descriptions:
                'Tindakan yang anda lakukan tidak bisa kembalikan, tetap lanjutkan hapus akun?',
            onOkTap: () {
              Navigator.pop(context);
              postToServer();
            },
            enableCancel: true,
            okBakcgroundColor: Colors.red[700],
          );
        });
  }

  postToServer() {
    Map<String, dynamic> body = {};
    body['id'] = widget.argument!.id;

    _accountBloc!.add(PostDeleteUserEvent(body: body));
  }
}
