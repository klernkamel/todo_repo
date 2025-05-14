import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadPhotos extends PhotoEvent {
  final int limit;

  const LoadPhotos({this.limit = 20});
  @override
  // TODO: implement props
  List<Object?> get props => [limit];
}

class LoadPhoto extends PhotoEvent {
  final int id;

  const LoadPhoto(this.id);

  @override
  List<Object?> get props => [id];
}
