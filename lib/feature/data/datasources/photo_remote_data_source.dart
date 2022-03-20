import 'package:infinite_scroll_list_app/feature/data/models/photo_model.dart';

abstract class PhotoRemoteDataSource {
  Future<List<PhotoModel>> getAllPhotos(int page);
}