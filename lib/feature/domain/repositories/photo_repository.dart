import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_list_app/core/error/failure.dart';
import 'package:infinite_scroll_list_app/feature/domain/entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<Either<Failure, List<PhotoEntity>>> getAllPhoto(int page);

  Future<Either<Failure, int>> updatePhoto(PhotoEntity photoEntity);
}
