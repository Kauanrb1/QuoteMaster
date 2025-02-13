import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: QuoteMasterApp(),
    ),
  );
}

// A classe principal do aplicativo
class QuoteMasterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuoteMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Definindo a HomeScreen como tela inicial
    );
  }
}

// Classe da tela principal que controla a navegação entre as telas
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice da tela selecionada na navegação inferior
  int _selectedIndex = 0;

  // Lista de telas que serão exibidas no corpo da aplicação
  static List<Widget> _screens = [
    QuoteListScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  // Função chamada quando o usuário clica em um item da barra de navegação inferior
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice da tela selecionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QuoteMaster')), // Título da aplicação
      body: _screens[_selectedIndex], // Exibe a tela correspondente ao índice selecionado
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice da tela selecionada
        onTap: _onItemTapped, // Função chamada ao clicar em um item da barra
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

// Classe para representar uma citação
class Quote {
  final String quote;
  final String author;

  Quote({required this.quote, required this.author});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          quote == other.quote &&
          author == other.author;

  @override
  int get hashCode => quote.hashCode ^ author.hashCode;
}

// Tela que exibe a lista de citações
class QuoteListScreen extends StatefulWidget {
  @override
  _QuoteListScreenState createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  // Lista de citações
  final List<Quote> quotes = [
    Quote(quote: 'A jornada de mil milhas começa com um único passo.', author: 'Lao Tsé'),
    Quote(quote: 'O sucesso é ir de fracasso em fracasso sem perder o entusiasmo.', author: 'Winston Churchill'),
    Quote(quote: 'A vida é o que acontece enquanto você está ocupado fazendo outros planos.', author: 'John Lennon'),
  ];

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        final isFavorite = favoritesProvider.favoriteQuotes.contains(quote);

        return Card(
          child: ListTile(
            title: Text(quote.quote),
            subtitle: Text('- ' + quote.author),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () => favoritesProvider.toggleFavorite(quote),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuoteDetailScreen(quote: quote),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Tela que exibe os detalhes de uma citação
class QuoteDetailScreen extends StatelessWidget {
  final Quote quote; // Citação recebida como parâmetro

  // Construtor para receber a citação
  QuoteDetailScreen({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da Citação')), // Título da tela
      body: Padding(
        padding: EdgeInsets.all(16.0), // Padding para o conteúdo da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda
          children: [
            Text(
              quote.quote, // Exibe a citação
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('- ' + quote.author, style: TextStyle(fontSize: 16)), // Exibe o autor
            SizedBox(height: 20),
            Text('Aqui pode ser adicionada uma explicação sobre o contexto da citação.'), // Espaço para mais informações
          ],
        ),
      ),
    );
  }
}

// Tela de favoritos, que exibe as citações que foram favoritas
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteQuotes = favoritesProvider.favoriteQuotes.toList();

    return ListView.builder(
      itemCount: favoriteQuotes.length, // Número de citações favoritas
      itemBuilder: (context, index) {
        // Exibe cada citação favorita
        return Card(
          child: ListTile(
            title: Text(favoriteQuotes[index].quote),
            subtitle: Text('- ' + favoriteQuotes[index].author),
          ),
        );
      },
    );
  }
}

// Tela de perfil do usuário
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Perfil do usuário"), // Exibe um texto simples para o perfil
    );
  }
}

// Classe para gerenciar as citações favoritas
class FavoritesProvider extends ChangeNotifier {
  final Set<Quote> _favoriteQuotes = Set();

  Set<Quote> get favoriteQuotes => _favoriteQuotes;

  void toggleFavorite(Quote quote) {
    if (_favoriteQuotes.contains(quote)) {
      _favoriteQuotes.remove(quote);
    } else {
      _favoriteQuotes.add(quote);
    }
    notifyListeners();
  }
}