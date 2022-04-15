import 'package:cached_network_image/cached_network_image.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage(this.url, {Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: url,
      fadeInDuration: const Duration(microseconds: 0),
      fadeOutDuration: const Duration(microseconds: 0),
      placeholder: (_, __) =>
          const Center(child: Icon(Icons.image, color: Colors.black38)),
    );
  }
}
