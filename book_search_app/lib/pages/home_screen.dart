import 'package:flutter/material.dart';
import 'package:book_search_app/pages/favorites_screen.dart';
import '../services/open_library_api.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';

class homeScreen extends StatefulWidget {
  @override
  homeScreenState createState() => homeScreenState();
}

class homeScreenState extends State<homeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();
  List<Book> _books = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _searchBooks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final books = await OpenLibraryApi.searchBooks(_controller.text);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToBookDetail(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => bookDetailScreen(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Busca de Livros'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pesquisa'),
            Tab(text: 'Favoritos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Digite o nome do livro',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchBooks,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_books.isEmpty)
                  const Text('Nenhum livro encontrado')
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: _books.length,
                      itemBuilder: (context, index) {
                        final book = _books[index];
                        return ListTile(
                          leading: book.coverId.isNotEmpty
                              ? Image.network(book.coverUrl,
                                  width: 50, fit: BoxFit.cover)
                              : null,
                          title: Text(book.title),
                          subtitle: Text(book.authorName),
                          onTap: () => _navigateToBookDetail(book),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          FavoritesScreen(),
        ],
      ),
    );
  }
}
