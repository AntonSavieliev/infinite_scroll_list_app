import 'package:flutter/material.dart';
import 'package:infinite_scroll_list_app/common/app_colors.dart';
import 'package:infinite_scroll_list_app/feature/presentation/widgets/cache_image_widget.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  const ImageDialog({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Stack(
      children: [
        CacheImage(
          width: 300,
          height: 300,
          imageUrl: imageUrl,
        ),
        Positioned(
          right: 0.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.close, color: AppColors.mainBackground),
              ),
              ),
            ),
          ),
      ],
    ));
  }
}
