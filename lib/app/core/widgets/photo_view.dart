import '../utils/imports.dart';

class PhotoView extends StatelessWidget {
  final String image;
  const PhotoView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        title: const Text('Photo View'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.network(
            image,
          ),
        ),
      ),
    );
  }
}
