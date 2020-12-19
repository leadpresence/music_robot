import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/robot_colors.dart';
import 'package:flutter/services.dart';
import '../models/radio.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Music> mySongs;

  @override
  void initState() {
    fetchMusic();
    super.initState();
  }

//get the songs from music fake api
  fetchMusic() async {
    final songsJson = await rootBundle.loadString('assets/music.json');
    mySongs = MusicList.fromJson(songsJson).radios;
    print(mySongs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(children: [
        VxAnimatedBox()
            .size(context.screenWidth, context.screenHeight)
            .withGradient(LinearGradient(
                colors: [RobotColors.primaryColor3, RobotColors.primaryColor4],
                end: Alignment.bottomRight,
                begin: Alignment.topLeft))
            .make(),
        AppBar(
          title: "Musicbot".text.xl3.bold.white.make().shimmer(
              primaryColor: RobotColors.primaryColor2,
              secondaryColor: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
        ).h(100).p16(),
        VxSwiper.builder(
            enlargeCenterPage: true,
            itemCount: mySongs.length,
            aspectRatio: 1.0,
            itemBuilder: (context, index) {
              final mxc = mySongs[index];

              return VxBox(
                      child: ZStack(
                [
                  //content of each song containder

                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: VxBox(
                      child: mxc.category.text.semiBold.white.xl.make(),
                    ).px16.make(),
                  ),

                  Align(
                    alignment: Alignment.topCenter,
                    child: VStack(
                      [
                        mxc.name.text.xl3.white.bold.make(),
                        5.heightBox,
                        mxc.tagline.text.xl4.white.semiBold.make()
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),

                  Align(
                      alignment: Alignment.bottomCenter,
                      child: [
                        Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        5.heightBox,
                        "Double tap to play".text.semiBold.xl.white.make()
                      ].vStack())
                ],
              )
                      // .clip(Clip.antiAlias)
                      )
                  // .clip(Clip.antiAlias)
                  .bgImage(DecorationImage(
                      image: NetworkImage(mxc.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.2), BlendMode.darken)))
                  .withRounded(value: 14)
                  .make()
                  .centered()
                  .onInkDoubleTap(() {})
                  .p16();
            }),
      ], fit: StackFit.expand),
    );
  }
}
