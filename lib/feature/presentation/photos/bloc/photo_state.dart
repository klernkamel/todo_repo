import 'package:equatable/equatable.dart';
import 'package:test_app/feature/data/dto/photos/photo_item.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
  
  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<PhotoItem> photos;
  
  const PhotoLoaded(this.photos);
  
  @override
  List<Object?> get props => [photos];
}

class PhotoError extends PhotoState {
  final String message;
  
  const PhotoError(this.message);
  
  @override
  List<Object?> get props => [message];
}