import 'package:flutter/material.dart';
import 'package:fluttervideo/PicListAndPos.dart';
import 'package:fluttervideo/VideoData.dart';

class VideoItemWidget extends StatefulWidget {
  const VideoItemWidget({
    Key? key,
    required this.video,
  }) : super(key: key);
  final VideoListAndPos video;

  @override
  State<VideoItemWidget> createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget>
    with SingleTickerProviderStateMixin {
  late VideoListAndPos videoData;

  @override
  void initState() {
    super.initState();
    videoData = widget.video;
  }

  @override
  Widget build(BuildContext context) {
    VideoData video = videoData.getNowVideo();
    return Material(
      color: const Color(0xfff1f1f1),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage(videoData.getNowVideo().cover.toString()),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        video.title.toString(),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "简述：${video.descs}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "导演：${video.director}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "演员：${video.actor}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "地区：${video.region}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "发布时间：${video.releaseTime}",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("videoData.getNowVideo().cover.toString()"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () {
          // Navigator.of(context).pushNamed("pic", arguments: videoData);
        },
      ),
    );
  }
}
