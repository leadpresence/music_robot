import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../utils/robot_colors.dart';
import 'package:flutter/services.dart';
import '../models/radio.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Music> mySongs;
  Music _selectedMusic;
  bool _isPlaying = false;
  Color _selectedColor;

  //initialize audioPlayer
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    fetchMusic();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == AudioPlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
    });
  }
//playmusic

  _playMusic(String musicUrl) {
    _audioPlayer.play(musicUrl);
    _selectedMusic = mySongs.firstWhere((element) => element.url == musicUrl);
    print(_selectedMusic);
    setState(() {});
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Drawer(),
        body: Stack(
          children: [
            VxAnimatedBox()
                .size(context.screenWidth, context.screenHeight)
                .withGradient(LinearGradient(colors: [
                  RobotColors.primaryColor3,
                  RobotColors.primaryColor4
                ], end: Alignment.bottomRight, begin: Alignment.topLeft))
                .make(),
            AppBar(
              title: "Musicbot".text.xl2.bold.white.make().shimmer(
                  primaryColor: RobotColors.primaryColor2,
                  secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ).h(100).p16(),
            mySongs == null ||
                    mySongs.isEmpty ||
                    mySongs.length == null ||
                    mySongs.length < 0
                ? Center(
                    child: Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  )
                : VxSwiper.builder(
                    enlargeCenterPage: true,
                    itemCount: mySongs.length,
                    aspectRatio: 1.0,
                    itemBuilder: (context, index) {
                      final mxc = mySongs[index];

                      return VxBox(
                              child: ZStack([
                        //content of each song containder
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          child: VxBox(
                            child: mxc.category.text.semiBold.white.xl.make(),
                          ).black.px16.make(),
                        ),

                        Align(
                          alignment: Alignment.topCenter,
                          child: VStack(
                            [
                              mxc.name.text.xl2.white.bold.make(),
                              5.heightBox,
                              mxc.tagline.text.xl.white.semiBold.make()
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
                      ]))
                          .clip(Clip.antiAlias)
                          .bgImage(DecorationImage(
                              image: NetworkImage(mxc.image),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken)))
                          .withRounded(value: 14)
                          .make()
                          .centered()
                          .onInkDoubleTap(() {
                        _playMusic(mxc.url);
                      }).p16();
                    }).centered(),
            Align(
              alignment: Alignment.bottomCenter,
              child: [
                Icon(
                  _isPlaying ? CupertinoIcons.stop_circle : CupertinoIcons.play,
                  size: 50.0,
                  color: Colors.white,
                ).onInkTap(() {
                  if (_isPlaying = true) {
                    _audioPlayer.stop();
                  } else {
                    _audioPlayer.play(_selectedMusic.url);

                  }
                })
              ].vStack(),
            ).pOnly(bottom: context.percentHeight * 12)
          ],
          fit: StackFit.expand,
          clipBehavior: Clip.antiAlias,
        ));
  }
}
