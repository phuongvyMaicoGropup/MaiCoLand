import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final bannerList = [
  "assets/images/image1.jpg",
  "assets/images/image2.jpg",
  "assets/images/image3.jpg",
];

class WidgetHomeBanner extends StatefulWidget {
  const WidgetHomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetHomeBanner> createState() => _WidgetHomeBannerState();
}

class _WidgetHomeBannerState extends State<WidgetHomeBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: const EdgeInsets.symmetric(vertical: 20),
        child: CarouselSlider.builder(
      itemCount: bannerList.length,
      itemBuilder: (context, index, realIndex) {
        final url = bannerList[index];
        return Container(
          width: 400,
          // color: Colors.black,
          margin: const EdgeInsets.only(
            right: 20.0,
            left: 20.0,
            bottom: 10,
          ),
          // child: Image.asset(item),
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 2),
                blurRadius: 2,
              ),
            ],
            borderRadius: BorderRadius.circular(7),
            image: DecorationImage(
              image: AssetImage(url),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        viewportFraction: 1,
        enableInfiniteScroll: false,

        // autoPlayInterval: const Duration(seconds: 4),
        // onPageChanged: (index, reason) {},
      ),
    ));
  }
}
