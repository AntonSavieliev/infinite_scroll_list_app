import 'package:flutter/material.dart';
import 'package:infinite_scroll_list_app/common/app_colors.dart';
import 'package:infinite_scroll_list_app/feature/domain/entities/photo_entity.dart';
import 'package:infinite_scroll_list_app/feature/presentation/widgets/cache_image_widget.dart';
import 'package:infinite_scroll_list_app/feature/presentation/widgets/image_dialog.dart';
import 'package:like_button/like_button.dart';

class PhotoCard extends StatelessWidget {
  final PhotoEntity photo;
  final Future<bool?> Function(bool)? onTap;

  const PhotoCard({
    Key? key,
    required this.photo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) => ImageDialog(
                        imageUrl: photo.url,
                      ));
            },
            child: CacheImage(
              width: 150,
              height: 150,
              imageUrl: photo.thumbnailUrl,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${photo.title}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 32,
                        child: LikeButton(
                          size: 24,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          animationDuration: const Duration(microseconds: 0),
                          isLiked: photo.isLike,
                          onTap: onTap,
                          // onTap:,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
