
import 'package:fluttervideo/VideoData.dart';

class VideoListAndPos {
 final List<VideoData> list;
  final int position;

 VideoListAndPos(this.list, this.position);
  VideoData getNowVideo(){
    return list[position];
  }
}
