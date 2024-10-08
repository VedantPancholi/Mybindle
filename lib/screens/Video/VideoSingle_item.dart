import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mybindel_test/Dummy_Data/Dummy_feed.dart';
import 'package:mybindel_test/models/Comment.dart';
import 'package:mybindel_test/widgets/CommnetChild_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../palette/palette.dart';
import '../../providers/selectCommentType.dart';
import '../../providers/selectTheme.dart';
import 'package:sizer/sizer.dart';

// enum SampleItem { itemOne, itemTwo, itemThree }

class VideoSingle_item extends StatefulWidget {
  int postIndex;

  VideoSingle_item(this.postIndex);
  @override
  State<VideoSingle_item> createState() => _VideoSingle_itemState();
}

class _VideoSingle_itemState extends State<VideoSingle_item> {
  // SampleItem? selectedMenu;

  final formKey = GlobalKey<FormState>();
  late final TextEditingController commentController;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  FocusNode inputNode = FocusNode();
  // print(dateStr);
  bool liked = false;
  bool share_clicked = false;
  bool isFollow = false;
  late final object;
  late double asp;

  @override
  void initState() {
    object = getpostobj();
    commentController = TextEditingController();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);

    super.initState();
  }

  @override
  void dispose() {
    print("_______________________________________________________called");
    commentController.dispose();
    _controller.dispose();
    // object = null;
    super.dispose();
  }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  double getheight(aspect_ratio){
    switch(aspect_ratio){
      case >=1:
    return (33).h;

    case <1 && >0.47:
    return (76).w / aspect_ratio;

    case <=0.47:
    return (70).h;

    default: return (33).h;
  }
  }

  @override
  Widget build(BuildContext context) {
    List feeds = object.getfeeds;
    final provider = Provider.of<Themeprovider>(context);
    print("build again ");

    return Container(
      margin: EdgeInsets.all((1.00).w),
      // color: Colors.green,
      color: provider.currentTheme ? light_Scaffold_color : dark_Scaffold_color,
      // height: (49.00).h,
      width: (98.00).w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: ().w*0.90,
            height: (8.00).h,
            // color: Colors.green,
            color: provider.currentTheme
                ? light_Scaffold_color
                : dark_Scaffold_color,
            margin: EdgeInsets.only(left: (3.00).w, right: (1.00).w),
            child: Row(children: [
              Stack(children: [
                Container(
                  width: (14.00).w,
                  height: (6.00).h,
                  padding: EdgeInsets.symmetric(
                      vertical: (0.8).h, horizontal: (1.500).w),
                  // color: Colors.black,
                  decoration: provider.currentTheme
                      ? square_neu_Morphism
                      : square_dark_neu_Morphism,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      feeds[widget.postIndex].picture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      color: Colors.red,
                      width: (2.500).w,
                      height: (1.200).h,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                width: (2.00).w,
              ),
              Stack(
                children: [
                  Container(
                    width: (77.00).w,
                    height: (7.00).h,
                    // color: Colors.amber,
                    color: provider.currentTheme
                        ? light_Scaffold_color
                        : dark_Scaffold_color,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: (7.00).h,
                            width: (35.00).w,
                            child: Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: (2.00).w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: feeds[widget.postIndex].name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: provider.currentTheme
                                                  ? dim_black
                                                  : dim_white),
                                        ),
                                        WidgetSpan(
                                          alignment: PlaceholderAlignment.top,
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                            color: orange_color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AutoSizeText(
                                    feeds[widget.postIndex]
                                        .occupation
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 15, color: orange_color),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            height: (7.00).h,
                            width: (40.00).w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: (10.00).w,
                                    height: (1.900).h,
                                    // decoration: provider.currentTheme ? square_neu_Morphism : square_dark_neu_Morphism,
                                    // ignore: prefer_const_constructors
                                    child: popupbutton(provider)
                                ),
                                // IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz_outlined)),
                                Container(
                                  width: (19.00).w,
                                  height: (3.00).h,
                                  decoration: provider.currentTheme
                                      ? square_neu_Morphism
                                      : square_dark_neu_Morphism,
                                  // ignore: prefer_const_constructors
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isFollow = !isFollow;
                                      });
                                    },
                                    child: Center(
                                      child: AutoSizeText(
                                          isFollow == true
                                              ? "Following"
                                              : "Follow",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: isFollow == true
                                                  ? Colors.deepOrange.shade600
                                                  : provider.currentTheme
                                                  ? dim_black
                                                  : dim_white,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              )
            ]),
          ),
          Container(
            margin:
            EdgeInsets.symmetric(horizontal: (3.500).w, vertical: (0.5).h),
            child: AutoSizeText(feeds[widget.postIndex].caption),
          ),
          // share
          Container(
            // height: 45.h,
            height: getheight(_controller.value.aspectRatio),
            //color: Colors.red,
            margin: EdgeInsets.all((2.00).w),
            decoration: provider.currentTheme
                ? square_neu_Morphism
                : square_dark_neu_Morphism,
            child: Row(
              children: [
                share_clicked == false
                    ? Container(
                  height: getheight(_controller.value.aspectRatio),
                  width: (76.00).w,
                  color: Colors.transparent.withOpacity(0.9),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return SizedBox(
                                width: _controller.value.size.width,
                                height: _controller.value.size.height,
                                child: VideoPlayer(_controller),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: orange_color),
                              );
                            }
                          }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 0.5.w,
                                  ),
                                  padding: EdgeInsets.only(top: 0.5.h),
                                  child: IconButton(
                                    onPressed: () {
                                      print("play or pause clicked");
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    },
                                    icon: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: (1.2).w,
                              ),
                              Flexible(
                                  flex: 5,
                                  child: VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true)),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 2.w, right: 0.5.w),
                                    padding: EdgeInsets.only(top: 0.5.h),
                                    child: AutoSizeText(
                                      _videoDuration(
                                          _controller.value.duration),
                                      softWrap: true,
                                      wrapWords: true,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )

                // Container(
                // height: (33.00).h,
                // width: (76.00).w,
                // // color: Colors.amber,
                // margin: EdgeInsets.symmetric(horizontal: (1.00).w),
                // color: provider.currentTheme
                //     ? light_Scaffold_color
                //     : dark_Scaffold_color,
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: Image.asset(
                //     feeds[widget.postIndex].image,
                //     fit: BoxFit.cover,
                //   ),
                // ))
                    : Container(
                  // height: (33.00).h,
                  height: _controller.value.size.height / 2 < (33.0).h
                      ? (33.0).h
                      : _controller.value.size.height - 50,
                  width: (76.00).w,
                  margin: EdgeInsets.symmetric(horizontal: (1.00).w),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //       image: AssetImage(
                  //         "asset/images/user_post.png",
                  //       ),
                  //       fit: BoxFit.cover),
                  // ),
                  child: Stack(
                    children: [
                      BlurHash(hash: "LXE]Hd|I\$f]C=dxISkr;67KRNsAV"),
                      Container(
                        height: (30.00).h,
                        width: (70.00).w,
                        margin:
                        EdgeInsets.symmetric(horizontal: (1.00).w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all((1.50).h),
                                  child: AutoSizeText(
                                    "Share",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            // 1st Row
                            SizedBox(
                              height: (0.50).h,
                            ),

                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: (3).w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'asset/share_icons/Everyone.svg',
                                            width: (6.40).w,
                                            height: (3.30).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Everyone",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'asset/share_icons/only_with.svg',
                                            width: (6.40).w,
                                            height: (3.40).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Only With",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "asset/share_icons/hide.svg",
                                            width: (6.40).w,
                                            height: (3.30).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Hide From",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: (1.00).h,
                            ),
                            // 2nd Row
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: (3).w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "asset/share_icons/private.svg",
                                            width: (6.40).w,
                                            height: (3.30).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Private",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "asset/share_icons/Inbox.svg",
                                            width: (6.40).w,
                                            height: (3.30).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Inbox",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "asset/share_icons/copy_link.svg",
                                            width: (6.40).w,
                                            height: (3.30).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Copy With",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: (1.00).h,
                            ),
                            // 3rd Row
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: (3).w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: (14.00).w,
                                        height: (6.60).h,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.2),
                                            borderRadius:
                                            BorderRadius.circular(6)),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "asset/share_icons/outside.svg",
                                            width: (6.40).w,
                                            height: (3.0).h,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: (0.25).h,
                                      ),
                                      const AutoSizeText(
                                        "Outside",
                                        softWrap: true,
                                        wrapWords: true,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: (1.00).w,
                ),
                Container(
                  height: _controller.value.size.height < (33.0).h
                      ? (33.0).h
                      : _controller.value.size.height - 50,
                  width: (13.00).w,
                  // color: Colors.amber,
                  padding: EdgeInsets.only(top: (1.500).h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // like
                      Container(
                        width: (8.00).w,
                        height: (8.00).h,
                        // color: Colors.deepOrange,
                        child: GestureDetector(
                          onTap: () {
                            liked = !liked;
                            setState(() {});
                            print("Star clicked");
                          },
                          child: Column(children: [
                            Image.asset(
                              liked
                                  ? "asset/images/highlighted_star_in_post.png"
                                  : "asset/images/un_highlighted_star_in_post.png",
                              width: (6.00).w,
                            ),
                            AutoSizeText(feeds[widget.postIndex].likesCount),
                          ]),
                        ),
                      ),

                      //comment
                      Container(
                        width: (8.00).w,
                        height: (8.00).h,
                        // color: Colors.deepPurple,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                backgroundColor: provider.currentTheme
                                    ? light_Scaffold_color
                                    : dark_Scaffold_color,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30.0),
                                    )),
                                elevation: 15,
                                constraints: BoxConstraints.loose(
                                    Size((100).w, (75.00).h)),
                                isScrollControlled: true,
                                context: context,
                                // backgroundColor: Colors.transparent,
                                builder: (BuildContext context) {
                                  return ChangeNotifierProvider(
                                    create: (context) => Commenttypeprovider(),
                                    builder: (context, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          height: (70.00).h,
                                          child: Consumer(
                                            builder: (context,
                                                Commenttypeprovider
                                                commenttypeprovider,
                                                child) {
                                              return CommentBox(
                                                focusNode: inputNode,
                                                userImage: CommentBox
                                                    .commentImageParser(
                                                    imageURLorPath:
                                                    "asset/images/user_logo.png"),
                                                labelText: 'Write a comment...',
                                                errorText:
                                                'Comment cannot be blank',
                                                withBorder: false,
                                                sendButtonMethod: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    print(
                                                        commentController.text);
                                                    setState(() {
                                                      var value = Singelcomment(
                                                          picture:
                                                          'asset/images/user_logo.png',
                                                          name: 'Vedant',
                                                          text:
                                                          commentController
                                                              .text,
                                                          datetime:
                                                          DateTime.now()
                                                              .toString(),
                                                          reaction:
                                                          Reaction.none,
                                                          replies: []);

                                                      if (commenttypeprovider
                                                          .isreply) {
                                                        String name = "@" + feeds[widget.postIndex].comments[commenttypeprovider.pushIndex].name;
                                                        value.text = "" + name + " ${value.text}";
                                                        feeds[widget.postIndex].comments[commenttypeprovider.getPushIndex].replies.add(value);
                                                        print(feeds[widget.postIndex].comments[commenttypeprovider.getPushIndex].replies[0]);
                                                        commenttypeprovider
                                                            .changecommentType =
                                                        false;
                                                      } else {
                                                        feeds[widget.postIndex]
                                                            .comments
                                                            .add(value);
                                                      }
                                                    });

                                                    commentController.clear();
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  } else {
                                                    print("Not validated");
                                                  }
                                                },
                                                formKey: formKey,
                                                commentController:
                                                commentController,
                                                backgroundColor:
                                                provider.currentTheme
                                                    ? light_Scaffold_color
                                                    : dark_Scaffold_color,
                                                textColor: provider.currentTheme
                                                    ? dim_black
                                                    : dim_white,
                                                sendWidget: Icon(
                                                    Icons.send_sharp,
                                                    size: 30,
                                                    color: orange_color),
                                                child: Container(
                                                  height: (100.00).h,
                                                  width: (100).w,
                                                  //color: Colors.red,
                                                  child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                      child: commentChild(feeds[widget.postIndex].comments, context, inputNode, widget.postIndex)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          },
                          child: Column(children: [
                            Image.asset(
                              "asset/images/comment_in_post.png",
                              width: (6.00).w,
                            ),
                            AutoSizeText(feeds[widget.postIndex]
                                .comments
                                .length
                                .toString()),
                          ]),
                        ),
                      ),

                      // share
                      Container(
                        width: (8.00).w,
                        height: (8.00).h,
                        // color: Colors.deepOrange,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              share_clicked = !share_clicked;
                            });

                            print("Share clicked");
                          },
                          child: Column(children: [
                            Image.asset(
                              share_clicked
                                  ? "asset/images/highlighted_share_in_post.png"
                                  : "asset/images/share_in_post.png",
                              width: (6.00).w,
                            ),
                            AutoSizeText(
                                feeds[widget.postIndex].sharesCount.toString()),
                          ]),
                        ),
                      ),

                      // download

                      Container(
                        width: (6.00).w,
                        height: (4.00).h,
                        // color: Colors.deepPurple,
                        child: GestureDetector(
                          onTap: () {
                            print("Download cliked");
                          },
                          child: Image.asset(
                            "asset/images/download_in_post.png",
                            width: (6.00).w,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: (93.5).w,
            height: (2.500).h,
            // color: Colors.red,
            color: provider.currentTheme
                ? light_Scaffold_color
                : dark_Scaffold_color,
            child: RichText(
              textAlign: TextAlign.end,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: feeds[widget.postIndex].views,
                    style: TextStyle(
                      fontSize: 10,
                      color: provider.currentTheme
                          ? dark_Scaffold_color
                          : light_Scaffold_color,
                    ),
                  ),
                  TextSpan(
                    text: "views",
                    style: TextStyle(
                      fontSize: 10,
                      color: provider.currentTheme
                          ? dark_Scaffold_color
                          : light_Scaffold_color,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


Widget popupbutton(provider) {
  return PopupMenuButton(
    onOpened: () {},
    onCanceled: () {},
    color: provider.currentTheme
        ? light_Scaffold_color
        : dark_Scaffold_color, //Color.fromRGBO(204, 204, 204, 0.4),
    padding: const EdgeInsets.all(0),
    constraints: BoxConstraints.expand(width: (44.1).w, height: (29.01).h),
    position: PopupMenuPosition.over,
    offset: const Offset(-50, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    elevation: 3,
    icon: Icon(
      Icons.more_horiz_rounded,
      color: Colors.transparent.withOpacity(0.8),
      size: 25,
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                  height: (3).h,
                  width: (7.0).w,
                  padding: EdgeInsets.all((0.8).w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.5)),
                      color: provider.currentTheme
                          ? light_Scaffold_color
                          : dark_Scaffold_color,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset("asset/homescreen_icons/hideIcon.svg")
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: (2.2).w),
                  alignment: Alignment.centerLeft,
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Hide',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                  height: (3).h,
                  width: (7.0).w,
                  padding: EdgeInsets.all((0.8).w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.5)),
                      color: provider.currentTheme
                          ? light_Scaffold_color
                          : dark_Scaffold_color,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset("asset/homescreen_icons/personIcon.svg")
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: (2.2).w),
                  alignment: Alignment.centerLeft,
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'View Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                  height: (3).h,
                  width: (7.0).w,
                  padding: EdgeInsets.all((0.8).w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.5)),
                      color: provider.currentTheme
                          ? light_Scaffold_color
                          : dark_Scaffold_color,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset("asset/homescreen_icons/muteIcon.svg")
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: (2.2).w),
                  alignment: Alignment.centerLeft,
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Mute',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                  height: (3).h,
                  width: (7.0).w,
                  padding: EdgeInsets.all((0.8).w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.5)),
                      color: provider.currentTheme
                          ? light_Scaffold_color
                          : dark_Scaffold_color,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset("asset/homescreen_icons/messageIcon.svg")
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: (2.2).w),
                  alignment: Alignment.centerLeft,
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Messages',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                  height: (3).h,
                  width: (7.0).w,
                  padding: EdgeInsets.all((0.8).w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600.withOpacity(0.5)),
                      color: provider.currentTheme
                          ? light_Scaffold_color
                          : dark_Scaffold_color,
                      borderRadius: BorderRadius.circular(5)),
                  child: SvgPicture.asset("asset/homescreen_icons/reportIcon.svg")
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: (2.2).w),
                  alignment: Alignment.centerLeft,
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Report',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),


      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                height: (4.55).h,
                width: (9.0).w,
                decoration: BoxDecoration(
                    color: provider.currentTheme
                        ? light_Scaffold_color
                        : dark_Scaffold_color,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.disabled_visible_outlined,
                  color: Color.fromRGBO(93, 93, 93, 1),
                  size: 24,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Hide',
                      style: TextStyle(
                          color: Color.fromRGBO(93, 93, 93, 1),
                          fontSize: 13,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                height: (4.55).h,
                width: (9.0).w,
                decoration: BoxDecoration(
                    color: provider.currentTheme
                        ? light_Scaffold_color
                        : dark_Scaffold_color,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.person,
                  color: Color.fromRGBO(93, 93, 93, 1),
                  size: 26,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'View Profile',
                      style: TextStyle(
                          color: Color.fromRGBO(93, 93, 93, 1),
                          fontSize: 13,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                height: (4.55).h,
                width: (9.0).w,
                decoration: BoxDecoration(
                    color: provider.currentTheme
                        ? light_Scaffold_color
                        : dark_Scaffold_color,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.mobile_off_rounded,
                  color: Color.fromRGBO(93, 93, 93, 1),
                  size: 26,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Mute',
                      style: TextStyle(
                          color: Color.fromRGBO(93, 93, 93, 1),
                          fontSize: 13,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                height: (4.55).h,
                width: (9.0).w,
                decoration: BoxDecoration(
                    color: provider.currentTheme
                        ? light_Scaffold_color
                        : dark_Scaffold_color,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.message,
                  color: Color.fromRGBO(93, 93, 93, 1),
                  size: 26,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Message',
                      style: TextStyle(
                          color: Color.fromRGBO(93, 93, 93, 1),
                          fontSize: 13,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      PopupMenuItem(
        child: Container(
          height: (4.55).h,
          // color: Colors.red,
          child: Row(
            children: [
              Container(
                height: (4.55).h,
                width: (9.0).w,
                decoration: BoxDecoration(
                    color: provider.currentTheme
                        ? light_Scaffold_color
                        : dark_Scaffold_color,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.report,
                  color: Color.fromRGBO(93, 93, 93, 1),
                  size: 26,
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.yellow,
                  child: const Center(
                    child: Text(
                      'Report',
                      style: TextStyle(
                          color: Color.fromRGBO(93, 93, 93, 1),
                          fontSize: 13,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
