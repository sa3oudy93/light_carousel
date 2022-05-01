import 'package:flutter/material.dart';
import 'package:light_carousel/light_carousel.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Light Carousel',
      home: CarouselPage(),
    ),
  );
}

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key}) : super(key: key);

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final PageController pageController = PageController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150.0,
              width: 300.0,
              child: LightCarousel(
                controller: pageController,
                boxFit: BoxFit.cover,
                autoPlay: false,
                onImageChange: (_, index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                dotSize: 6.0,
                dotIncreasedColor: const Color(0xFFFF335C),
                dotBgColor: Colors.transparent,
                dotPosition: DotPosition.bottomCenter,
                dotVerticalPadding: 10.0,
                showIndicator: true,
                indicatorBgPadding: 7.0,
                images: const [
                  AssetImage('assets/flutter.jpg'),
                  NetworkImage(
                      'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                  NetworkImage(
                      'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                  ExactAssetImage("assets/flutter.jpg"),
                ],
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {
                  pageController.animateToPage(
                    selectedIndex - 1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  );
                },
                child: const Text('Previous image'),
                color: Colors.blue,
              ),
              MaterialButton(
                onPressed: () {
                  pageController.animateToPage(
                    selectedIndex + 1,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease,
                  );
                },
                child: const Text('Next image'),
                color: Colors.blue,
              ),
            ],
          ),
          SizedBox(
            height: 450.0,
            width: 350.0,
            child: LightWidget(
              animationDuration: const Duration(milliseconds: 1000),
              autoPlay: true,
              animationCurve: Curves.easeInOut,
              boxFit: BoxFit.cover,
              pages: const [
                _Pages(
                    title: 'first page',
                    networkImage:
                        'https://avatars.githubusercontent.com/u/1609975?s=280&v=4'),
                _Pages(title: 'second page', assetsImage: 'assets/flutter.jpg'),
                _Pages(
                    title: 'third page',
                    networkImage:
                        'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
    required this.title,
    this.assetsImage,
    this.networkImage,
  })  : assert(assetsImage != null || networkImage != null),
        super(key: key);
  final String title;
  final String? assetsImage, networkImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 30),
          height: 50,
          width: 70,
          child: Text(title),
        ),
        Center(
          child: Column(
            children: [
              assetsImage != null
                  ? Image(image: AssetImage(assetsImage!))
                  : const SizedBox(),
              networkImage != null
                  ? Image(image: NetworkImage(networkImage!))
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
