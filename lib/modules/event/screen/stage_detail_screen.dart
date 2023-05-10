import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shareticket/widget/images/network_image_placeholder.dart';
import 'package:shareticket/widget/text/text_widget.dart';

class StageDetailArgument {
  final String? title;
  int initialIndex;
  List<String> stageList = [];
  StageDetailArgument(
      {this.title, required this.stageList, required this.initialIndex});
}

class StageDetailScreen extends StatefulWidget {
  final StageDetailArgument? argument;

  const StageDetailScreen({Key? key, this.argument}) : super(key: key);

  static const String path = '/StageDetail';
  static const String title = 'StageDetail';

  @override
  _StageDetailScreenState createState() => _StageDetailScreenState();
}

class _StageDetailScreenState extends State<StageDetailScreen>
    with SingleTickerProviderStateMixin {
  String? title;

  int currentIndex = 0;

  // PageController controller = PageController(
  //   initialPage: 0,
  //   keepPage: true,
  // );

  late TabController controller;

  @override
  void initState() {
    currentIndex = widget.argument!.initialIndex;
    controller = TabController(
        length: widget.argument!.stageList.length,
        vsync: this,
        initialIndex: widget.argument!.initialIndex);
    controller.addListener(() {
      if (controller.indexIsChanging) {
        setState(() {
          currentIndex = controller.index;
        });
      } else if (controller.index != controller.previousIndex) {
        setState(() {
          currentIndex = controller.index;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            TabBarView(
              controller: controller,
              children: List.generate(
                widget.argument!.stageList.length,
                (index) {
                  var image = widget.argument!.stageList[index];
                  return InteractiveViewer(
                    // panEnabled: false, // Set it to false
                    // boundaryMargin: EdgeInsets.all(100),
                    // minScale: 0.5,
                    // maxScale: 2,
                    child: Center(
                      child: NetworkImagePlaceHolder(
                        imageUrl: image,
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TextWidget(
                        "${currentIndex + 1}/${widget.argument!.stageList.length}",
                        textColor: Colors.white,
                        weight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
