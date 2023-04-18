import 'package:fluttervideo/VideoData.dart';

class SearchVideo {
    List<VideoData>? videoData;
    int? code;
    int? count;
    String? msg;

    SearchVideo({this.videoData, this.code, this.count, this.msg});

    factory SearchVideo.fromJson(Map<String, dynamic> json) {
        return SearchVideo(
            videoData: json['data'] != null ? (json['data'] as List).map((i) => VideoData.fromJson(i)).toList() : null,
            code: json['code'], 
            count: json['count'], 
            msg: json['msg'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['code'] = code;
        data['count'] = count;
        data['msg'] = msg;
          data['data'] = videoData?.map((v) => v.toJson()).toList();
        return data;
    }
}