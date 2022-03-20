import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_list_app/feature/domain/entities/photo_entity.dart';

abstract class PhotoListState extends Equatable {
  const PhotoListState();

  @override
  List<Object> get props => [];
}

class PhotoListEmpty extends PhotoListState {
  @override
  List<Object> get props => [];
}

class PhotoListLoading extends PhotoListState {
  final List<PhotoEntity> oldPhotoList;
  final bool isFirstFetch;

  const PhotoListLoading(this.oldPhotoList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldPhotoList];
}

class PhotoListLoaded extends PhotoListState {
  final List<PhotoEntity> photosList;

  const PhotoListLoaded(this.photosList);

  @override
  List<Object> get props => [photosList];
}

class PhotoListError extends PhotoListState {
  final String message;

  const PhotoListError({required this.message});

  @override
  List<Object> get props => [message];
}

class PhotoListNoInternetConnection extends PhotoListState {
  final String message;

  const PhotoListNoInternetConnection({required this.message});

  @override
  List<Object> get props => [message];
}

class PhotoListInternetConnectionIsAvailable extends PhotoListState {
  const PhotoListInternetConnectionIsAvailable();

  @override
  List<Object> get props => [];
}
