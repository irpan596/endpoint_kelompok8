import 'dart:convert';
import 'dart:io';
import 'package:endpoint_kel8/models/photos.dart';
import 'package:endpoint_kel8/models/comment.dart';
import 'package:endpoint_kel8/models/post.dart';
import 'package:endpoint_kel8/services/post_services.dart';

class PostController {
  Future<List<Post>> fetchAll() async {
    return await PostService().fetch().then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(res.body);
        return List.generate(
            jsonData.length,
            (index) => Post.fromMap(
                  jsonData[index],
                ));
      } else {
        throw Exception();
      }
    });
  }

  Future<List<Comment>> fetchComment(int id) async {
    return await PostService().fetchComments(id).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(res.body);
        return List.generate(
            jsonData.length, (index) => Comment.fromMap(jsonData[index]));
      } else {
        throw Exception();
      }
    });
  }

  Future<List<Photos>> fetchPhotos(int id) async {
    return await PostService().fetchPhotos(id).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(res.body);
        return List.generate(
          jsonData.length,
          (index) => Photos.fromMap(jsonData[index]),
        );
      } else {
        throw Exception();
      }
    });
  }

  Future<bool> delete(int id) async {
    return await PostService().delete(id).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> create(Post post) async {
    return await PostService().create(post).then((res) {
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> patch(Post post) async {
    return await PostService()
        .patch(id: post.id, title: post.title, body: post.body)
        .then((res) {
      if (res.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    });
  }
}
