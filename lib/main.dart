import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttervideo/PicListAndPos.dart';
import 'package:fluttervideo/SearchVideo.dart';
import 'package:fluttervideo/VideoData.dart';
import 'package:fluttervideo/VideoItemWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '看会片儿',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  List<VideoData> videos = [];
  List<Widget> itemViews = [];
  String keyword = "";
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('bottom');
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          color: const Color(0xfff1f1f1),
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (str) {
                        setState(() {
                          keyword = str;
                        });
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(),
                        hintText: '请输入关键字',
                        labelText: '看会片儿',
                        prefixIcon: Icon(Icons.person),
                      ),
                      autofocus: true,
                    ),
                  ),
                  MaterialButton(
                    height: 55,
                    onPressed: () {
                      getVideo();
                    },
                    color: Colors.green,
                    child: const Text(
                      "搜索",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                    onRefresh: onRefresh,
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.6,
                      ),
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      children: itemViews,
                    )),
              )
            ],
          ),
        ));
  }

  void getVideo() async {
    print(keyword);
    String url = "https://api.pingcc.cn/video/search/title/$keyword/$page/30";
    Dio dio = Dio();
    var map = <String, dynamic>{};
    var response = await dio.get(url, queryParameters: map);
    Map<String, dynamic> json = response.data;
    SearchVideo video = SearchVideo.fromJson(json);
    if (video.videoData != null) {
      setState(() {
        if (page == 1) {
          videos.clear();
        }
        videos.addAll(video.videoData!);
        print(video.videoData);
      });
      buildItemWidget();
    }
  }

  Future onRefresh() async {
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        page = 1;
      });
      getVideo();
    });
  }

  void buildItemWidget() {
    List<Widget> w = [];
    w.clear();
    for (int i = 0; i < videos.length; i++) {
      VideoListAndPos videoListAndPos = VideoListAndPos(videos, i);

      w.add(VideoItemWidget(video: videoListAndPos));
    }
    setState(() {
      itemViews = w;
    });
  }

  Future getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        print('more');
        setState(() {
          page++;
          isLoading = false;
        });
        getVideo();
      });
    }
  }
}
