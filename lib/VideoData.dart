class VideoData {
    String? actor;
    String? cover;
    String? descs;
    String? director;
    String? region;
    String? releaseTime;
    String? title;
    String? updateTime;
    String? videoId;
    String? videoType;

    VideoData({this.actor, this.cover, this.descs, this.director, this.region, this.releaseTime, this.title, this.updateTime, this.videoId, this.videoType});

    factory VideoData.fromJson(Map<String, dynamic> json) {
        return VideoData(
            actor: json['actor'], 
            cover: json['cover'], 
            descs: json['descs'], 
            director: json['director'], 
            region: json['region'], 
            releaseTime: json['releaseTime'], 
            title: json['title'], 
            updateTime: json['updateTime'], 
            videoId: json['videoId'], 
            videoType: json['videoType'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['actor'] = this.actor;
        data['cover'] = this.cover;
        data['descs'] = this.descs;
        data['director'] = this.director;
        data['region'] = this.region;
        data['releaseTime'] = this.releaseTime;
        data['title'] = this.title;
        data['updateTime'] = this.updateTime;
        data['videoId'] = this.videoId;
        data['videoType'] = this.videoType;
        return data;
    }
}