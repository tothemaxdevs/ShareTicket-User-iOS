import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/utils/view/view_utils.dart';
import 'package:shareticket/widget/button/rounded_button.dart';
import 'package:shareticket/widget/screen/custom_scaffold.dart';
import 'package:shareticket/widget/text/text_widget.dart';
import 'package:shareticket/widget/text_field/edit_text_field.dart';

class DeleteConfirmationArgument {
  final String title;

  DeleteConfirmationArgument(this.title);
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

  @override
  void initState() {
    if (widget.argument != null) {
      title = widget.argument?.title;
    } else {
      title = DeleteConfirmationScreen.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: appBar(
        context: context,
        backButton: true,
        title: DeleteConfirmationScreen.title,
      ),
      body: Column(
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
                    'Jika Anda memilih untuk menghapus akun Anda dari aplikasi seluler, tolong diperhatikan bahwa tindakan ini bersifat permanen dan tidak dapat dibatalkan. Menghapus akun Anda akan mengakibatkan hilangnya semua data yang terkait dengan akun Anda, termasuk transaksi atau pembelian yang dilakukan melalui aplikasi.\n\nSebelum melanjutkan dengan penghapusan akun Anda, disarankan untuk membuat cadangan dari semua data atau informasi penting yang ingin Anda simpan. Ini mungkin termasuk riwayat transaksi, tanda terima pembelian, atau data lain yang telah Anda simpan dalam aplikasi.\n\nSetelah Anda mengkonfirmasi penghapusan akun Anda, semua informasi dan data Anda akan dihapus secara permanen dari server aplikasi dan tidak akan dapat dipulihkan. Mohon pertimbangkan dengan seksama sebelum melanjutkan dengan penghapusan akun Anda.'),
                divide16,
                EditTextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == 'HAPUS PERMANEN') {
                          enableDeleteButton = true;
                        } else {
                          enableDeleteButton = false;
                        }
                      });
                    },
                    controller: validationController,
                    hint: 'HAPUS PERMANEN',
                    label: 'Masukan HAPUS PERMANEN')
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Dimens.size16),
            child: RoundedButton(
                color: Colors.red[700],
                width: double.infinity,
                text: 'Hapus Akun',
                press: enableDeleteButton! ? () {} : null),
          )
        ],
      ),
    );
  }
}
