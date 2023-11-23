class Post {
  String? id;
  String? userId;
  String? userName;
  String? caption;
  String? videoUrl;
  String? photoUrl;
  String? date;
  List<Comments>? comments;
  List<Liked>? liked;
  var videoPlayer;

  Post(
      {this.userId,
      this.userName,
      this.caption,
      this.videoUrl,
      this.date,
      this.comments,
      this.liked,
      this.photoUrl});

  Post.fromJson(Map<String, dynamic>? json) {
    userId = json!['userId'];
    userName = json['userName'];
    caption = json['caption'];
    videoUrl = json['videoUrl'];
    photoUrl = json['photoUrl'];
    date = json['date'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['liked'] != null) {
      liked = <Liked>[];
      json['liked'].forEach((v) {
        liked!.add(new Liked.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['caption'] = this.caption;
    data['videoUrl'] = this.videoUrl;
    data['photoUrl'] = this.photoUrl;
    data['date'] = this.date;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.liked != null) {
      data['liked'] = this.liked!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  dynamic? userId;
  String? userName;
  String? comment;

  Comments({this.userId, this.userName, this.comment});

  Comments.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['comment'] = this.comment;
    return data;
  }
}

class Liked {
  dynamic? userId;
  String? userName;

  Liked({this.userId, this.userName});

  Liked.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    return data;
  }
}
