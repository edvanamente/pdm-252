// ARQUIVO: lib/services/post_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  // URL base do JSONPlaceholder
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // 1. GET: Listar todos os posts
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      // Converte a lista de JSONs em lista de Posts
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar posts');
    }
  }

  // 2. GET: Detalhes de um post (opcional para lista simples, mas útil)
  Future<Post> getPost(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar post');
    }
  }

  // 3. POST: Criar um novo post
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao criar post');
    }
  }

  // 4. PUT: Atualizar um post existente
  Future<Post> updatePost(int id, Post post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar post');
    }
  }

  // 5. DELETE: Remover um post
  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar post');
    }
  }
}