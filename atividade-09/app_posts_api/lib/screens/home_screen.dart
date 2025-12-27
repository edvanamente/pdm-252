// ARQUIVO: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService _postService = PostService();
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = _postService.getPosts();
  }

  // Função auxiliar para recarregar a lista (simulação)
  void refreshList() {
    setState(() {
      _futurePosts = _postService.getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {                                      
    return Scaffold(
      appBar: AppBar(
        title: const Text('API REST Flutter do EDVAN'),
        backgroundColor: Colors.blueAccent,
      ),
      // Botão para criar novo Post (POST)
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            // Exemplo simplificado de criação
            Post newPost = Post(userId: 1, title: 'Novo Post Flutter', body: 'Conteúdo criado via App');
            try {
                Post created = await _postService.createPost(newPost);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post criado! ID: ${created.id}')));
                // Nota: O JSONPlaceholder não salva de verdade, então não aparecerá na lista ao recarregar
            } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erro ao criar post')));
            }
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum post encontrado'));
          }

          // Lista de Posts (GET)
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Post post = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        // Botão Editar (PUT)
                        IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () async {
                                Post updatedPost = Post(userId: post.userId, title: '${post.title} (Editado)', body: post.body);
                                await _postService.updatePost(post.id!, updatedPost);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post atualizado com sucesso!')));
                            },
                        ),
                        // Botão Deletar (DELETE)
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                                await _postService.deletePost(post.id!);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post deletado!')));
                                // Na vida real, aqui removeríamos o item da lista localmente
                            },
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}