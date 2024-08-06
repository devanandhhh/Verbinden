class EditPostModel {
  String postId;
  String caption;
  EditPostModel({required this.caption, required this.postId});

  factory EditPostModel.fromJson(Map<String, dynamic> json) {
    return EditPostModel(caption: json['caption'], postId: json['postid']);
  }
}
