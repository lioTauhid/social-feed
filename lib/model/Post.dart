class Post {
  int? userId;
  String? userNmae;
  dynamic? id;
  String? title;
  String? body;
  String? photo;
  String? date;
  List<Comments>? comments;
  List<Liked>? liked;

  Post(
      {this.userId,
      this.userNmae,
      this.id,
      this.title,
      this.body,
      this.photo,
      this.date,
      this.comments,
      this.liked});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userNmae = json['userNmae'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    photo = json['photo'];
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
    data['userNmae'] = this.userNmae;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photo'] = this.photo;
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
  int? userId;
  String? userNmae;
  String? comment;

  Comments({this.userId, this.userNmae, this.comment});

  Comments.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userNmae = json['userNmae'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userNmae'] = this.userNmae;
    data['comment'] = this.comment;
    return data;
  }
}

class Liked {
  int? userId;
  String? userNmae;

  Liked({this.userId, this.userNmae});

  Liked.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userNmae = json['userNmae'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userNmae'] = this.userNmae;
    return data;
  }
}
