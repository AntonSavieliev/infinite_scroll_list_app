import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_list_app/core/error/failure.dart';
import 'package:infinite_scroll_list_app/core/usecases/usecase.dart';
import 'package:infinite_scroll_list_app/feature/domain/entities/photo_entity.dart';
import 'package:infinite_scroll_list_app/feature/domain/repositories/photo_repository.dart';

class UpdatePhoto extends UseCase<int, UpdatePhotoParams> {
  final PhotoRepository photoRepository;

  UpdatePhoto(this.photoRepository);

  @override
  Future<Either<Failure, int>> call(UpdatePhotoParams params) async {
    return await photoRepository.updatePhoto(params.photo);
  }
}

class UpdatePhotoParams extends Equatable {
  final PhotoEntity photo;

  const UpdatePhotoParams({required this.photo});

  @override
  List<Object> get props => [photo];
}
