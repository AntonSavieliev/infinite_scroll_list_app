import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_list_app/core/error/failure.dart';
import 'package:infinite_scroll_list_app/core/usecases/usecase.dart';
import 'package:infinite_scroll_list_app/feature/domain/entities/photo_entity.dart';
import 'package:infinite_scroll_list_app/feature/domain/repositories/photo_repository.dart';

class GetAllPhotos extends UseCase<List<PhotoEntity>, PagePhotoParams> {
  final PhotoRepository photoRepository;

  GetAllPhotos(this.photoRepository);

  @override
  Future<Either<Failure, List<PhotoEntity>>> call(
      PagePhotoParams params) async {
    return await photoRepository.getAllPhoto(params.page);
  }
}

class PagePhotoParams extends Equatable {
  final int page;

  const PagePhotoParams({required this.page});

  @override
  List<Object> get props => [page];
}