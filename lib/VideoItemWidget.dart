import 'package:flutter/material.dart';
import 'package:fluttervideo/VideoData.dart';

class VideoItemWidget extends StatefulWidget {
  const VideoItemWidget({Key? key, required this.video}) : super(key: key);
  final String video;

  @override
  State<VideoItemWidget> createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget>
    with SingleTickerProviderStateMixin {
  late String videoData;

  @override
  void initState() {
    super.initState();
    videoData = widget.video;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(videoData.toString()),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            // Navigator.of(context).pushNamed("pic", arguments: videoData);
          },
        ),
      ),
    );
  }
}
