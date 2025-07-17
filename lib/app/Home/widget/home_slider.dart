import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart' as csoption;
import 'package:carousel_slider/carousel_slider.dart' as csslider;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common_widgets/app_colors.dart';
import '../../../common_widgets/urls.dart';

class HomeSlider extends StatefulWidget {
  final List<String> banner;
  final double? height;

  const HomeSlider({Key? key, required this.banner, this.height})
      : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int position = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        csslider.CarouselSlider(
          items: widget.banner.map(
                (e) {

              return CachedNetworkImage(
                imageUrl: "$sliderURL$e",
                imageBuilder: (context, imageProvider) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    //  color: Colors.grey.shade100,
                   //   border: Border.all(),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                        // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                      ),
                      borderRadius: BorderRadius.circular(20)),
                ),
                placeholder: (context, url) =>
                const Center(child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.image, size: 50)),
              );
            },
          ).toList(),
          options:csoption.CarouselOptions(
              aspectRatio: 1,
              height: widget.height ?? 190,
              viewportFraction: 1,
              autoPlay:widget.banner.length==1 ?false: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayInterval:  const Duration(seconds: 5),
              onPageChanged: (index, carouselPageChangedReason) {
                setState(() {
                  position = index % 5;

                });
              }),
        ),
        const SizedBox(height: 5),

        Align(
          alignment: Alignment.center,
          child: Container(
            height: 15,
            // width: 65,
            child: Center(
              child: ListView.builder(
                itemCount: widget.banner.length < 5
                    ? widget.banner.length
                    : 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: index == position
                          ? const Icon(
                        Icons.circle,
                        size: 13,
                        color: AppColors.primaryBlack,
                      )
                          : const Icon(
                        Icons.circle_outlined,
                        size: 10,
                        color: Colors.grey,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}