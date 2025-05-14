import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/data/api/photo_api_service.dart';
import 'package:test_app/feature/presentation/photos/bloc/photo_event.dart';
import 'package:test_app/feature/presentation/photos/bloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoApiService _photoApiService = PhotoApiService();
  
  PhotoBloc() : super(PhotoInitial()) {
    on<LoadPhotos>(_onLoadPhotos);
    on<LoadPhoto>(_onLoadPhoto);
  }
  
  void _onLoadPhotos(LoadPhotos event, Emitter<PhotoState> emit) async {
    try {
      emit(PhotoLoading());
      final photos = await _photoApiService.getPhotos(limit: event.limit);
      log('Loaded ${photos.length} photos');
      emit(PhotoLoaded(photos));
    } catch (e) {
      log('Error loading photos: $e');
      emit(PhotoError(e.toString()));
    }
  }
  
  void _onLoadPhoto(LoadPhoto event, Emitter<PhotoState> emit) async {
    try {
      emit(PhotoLoading());
      final photo = await _photoApiService.getPhoto(event.id);
      emit(PhotoLoaded([photo]));
    } catch (e) {
      log('Error loading photo: $e');
      emit(PhotoError(e.toString()));
    }
  }
}