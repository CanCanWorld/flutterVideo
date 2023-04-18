import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    );
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(),
                        hintText: '请输入关键字',
                        labelText: '看会片儿',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: MaterialButton(
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: onRefresh,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: .6,
                    ),
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    children: itemViews,
                  )),
            )
          ],
        ));
  }

  void getVideo() async {
    String url = "https://api.pingcc.cn/video/search/title/火影/1/30";
    Dio dio = Dio();
    var map = <String, dynamic>{};
    var response = await dio.get(url, queryParameters: map);
    Map<String, dynamic> json = response.data;
    SearchVideo video = SearchVideo.fromJson(json);
    if (video.videoData != null) {
      setState(() {
        videos.clear();
        videos.addAll(video.videoData!);
      });
      buildItemWidget();
    }
  }

  void buildItemWidget() {
    List<Widget> w = [];
    w.clear();
    // for (int i = 0; i < videos.length; i++) {
    //   VideoData videoData = videos[i];
    //   w.add(VideoItemWidget(video: videoData));
    //   print("111"+videoData.cover.toString());
    //   // w.add(Text(videos[i].title.toString()));
    // }
    videos.forEach((element) {
      w.add(VideoItemWidget(video: element.cover.toString()));
    });
    setState(() {
      itemViews = w;
    });
  }

  Future onRefresh() async {
    // await Future.delayed(const Duration(seconds: 1), () {
    //   setState(() {
    //     page = 1;
    //   });
    //   getRequest();
    // });
  }

  Future getMore() async {
    // if (!isLoading) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   await Future.delayed(const Duration(seconds: 1), () {
    //     print('more');
    //     setState(() {
    //       page++;
    //       isLoading = false;
    //     });
    //     getRequest();
    //   });
    // }
  }
}