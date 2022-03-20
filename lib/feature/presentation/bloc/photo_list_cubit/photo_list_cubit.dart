import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_list_app/common/constants.dart';
import 'package:infinite_scroll_list_app/core/error/failure.dart';
import 'package:infinite_scroll_list_app/core/platform/network_info.dart';
import 'package:infinite_scroll_list_app/feature/domain/entities/photo_entity.dart';
import 'package:infinite_scroll_list_app/feature/domain/usecases/get_all_photos.dart';
import 'package:infinite_scroll_list_app/feature/domain/usecases/update_photo.dart';
import 'package:infinite_scroll_list_app/feature/presentation/bloc/photo_list_cubit/photo_list_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoListCubit extends Cubit<PhotoListState> {
  final GetAllPhotos getAllPhotos;
  final UpdatePhoto updatePhoto;
  final SharedPreferences sharedPreferences;
  final NetworkInfo networkInfo;

  PhotoListCubit({
    required this.getAllPhotos,
    required this.sharedPreferences,
    required this.updatePhoto,
    required this.networkInfo,
  }) : super(PhotoListEmpty());

  void loadPhoto() async {
    if (state is PhotoListLoading) return;
    final currentState = state;
    int page = sharedPreferences.getInt(Constants.pageNumber) ?? 1;
    bool _isConnected = await networkInfo.isConnected;
    var oldPerson = <PhotoEntity>[];
    if (currentState is PhotoListLoaded) {
      oldPerson = currentState.photosList;
    }
    if (!_isConnected) {
      emit(PhotoListNoInternetConnection(
          message: Constants.NO_INTERNET_CONNECTION_MESSAGE));
    } else {
      emit(PhotoListInternetConnectionIsAvailable());
    }
    emit(PhotoListLoading(oldPerson, isFirstFetch: page == 1));
    final failureOrPhoto = await getAllPhotos(PagePhotoParams(page: page));
    failureOrPhoto.fold(
        (error) => emit(PhotoListError(message: _mapFailureToMessage(error))),
        (result) async {
      final photos = (state as PhotoListLoading).oldPhotoList;
      photos.addAll(result);
      emit(PhotoListLoaded(photos));
    });
  }

  void updatePhotoInDatabase(PhotoEntity photo) {
    updatePhoto.call(UpdatePhotoParams(photo: photo));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Constants.SERVER_FAILURE_MESSAGE;
      case LocalDatabaseFailure:
        return Constants.LOCAL_DATABASE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

  Future<bool> isConnected() async {
    return await networkInfo.isConnected;
  }

  void startApp() {
    sharedPreferences.setBool(Constants.isNeedToCheckCache, true);
  }
}
