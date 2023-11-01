import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:unidy_mobile/widgets/progress_bar/dot_progress_bar.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({super.key, required this.imageUrls});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;

  void _onScroll(int index, _) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget _buildImage(String imgUrl) {
    return Image.network(
        imgUrl,
        width: double.infinity,
        height: 300,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator()
            ),
          );
        },
        errorBuilder: (BuildContext context, Object child, StackTrace? error) => const Icon(Icons.error),
        fit: BoxFit.contain
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imageUrls.map((imgUrl) => _buildImage(imgUrl)).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
            disableCenter: true,
            onPageChanged: _onScroll
          )
        ),
        const SizedBox(height: 8),
        Visibility(
          visible: widget.imageUrls.length > 1,
          child: Skeleton.ignore(
            child: DotProgressBar(max: widget.imageUrls.length, current: currentIndex, dotSize: 7)
          )
        )
      ]
    );
  }
}
