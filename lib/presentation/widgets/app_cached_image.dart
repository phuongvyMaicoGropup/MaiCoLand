import 'package:cached_network_image/cached_network_image.dart';
import 'package:maico_land/presentation/screens/auth_screen/widgets/lib_import.dart';

class AppCachedImage extends StatelessWidget {
  const AppCachedImage(this.url, {Key? key}) : super(key: key);
  final String url;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      // loadingBuilder:
      //   (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
      // return  const Center(child: Icon(Icons.image, color: Colors.black38));
      // }
    );
  }
}
