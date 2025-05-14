import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/feature/presentation/photos/bloc/photo.bloc.dart';
import 'package:test_app/feature/presentation/photos/bloc/photo_event.dart';
import 'package:test_app/feature/presentation/photos/bloc/photo_state.dart';
import 'package:test_app/feature/presentation/photos/widgets/photo_card.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc()..add(const LoadPhotos()),
      child: _PhotosPageContent(),
    );
  }
}

class _PhotosPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaseholder Photos'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PhotoLoaded) {
            final photos = state.photos;
            if (photos.isEmpty) {
              return const Center(
                child: Text('Нет фотографий для отображения'),
              );
            }

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return PhotoCard(photo: photo);
                });
          } else if (state is PhotoError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Ошибка: ${state.message}'),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<PhotoBloc>().add(const LoadPhotos());
                      },
                      child: const Text('Повторить'))
                ],
              ),
            );
          }

          return Center(
            child: ElevatedButton(
                onPressed: () {
                  context.read<PhotoBloc>().add(const LoadPhotos());
                },
                child: Text('Загрузить фотографии')),
          );
        },
      ),
    ));
  }
}
