import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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
  const QuoteMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuoteMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(), // Definindo a HomeScreen como tela inicial
      debugShowCheckedModeBanner: false, // Oculta o banner de debug
    );
  }
}

// Classe da tela principal que controla a navegação entre as telas
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice da tela selecionada na navegação inferior
  int _selectedIndex = 0;

  // Lista de telas que serão exibidas no corpo da aplicação
  static final List<Widget> _screens = [
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
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _screens[_selectedIndex], // Exibe a tela correspondente ao índice selecionado
      ),
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
  final String category;
  final String context; // Adiciona o contexto

  Quote({required this.quote, required this.author, required this.category, required this.context});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          quote == other.quote &&
          author == other.author &&
          category == other.category &&
          context == other.context;

  @override
  int get hashCode => quote.hashCode ^ author.hashCode ^ category.hashCode ^ context.hashCode;
}

// Lista de categorias
const List<String> categories = [
  'Motivação',
  'Filosofia',
  'Amor',
];

// Tela que exibe a lista de citações
class QuoteListScreen extends StatefulWidget {
  const QuoteListScreen({super.key});

  @override
  _QuoteListScreenState createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  String selectedCategory = 'Motivação'; // Categoria selecionada

  // Lista de citações
  final List<Quote> quotes = [
    Quote(
      quote: 'A jornada de mil milhas começa com um único passo.',
      author: 'Lao Tsé',
      category: 'Motivação',
      context: 'Essa frase do filósofo chinês enfatiza a importância de dar o primeiro passo, independentemente do tamanho da meta. É um lembrete de que toda grande conquista começa com pequenas ações.',
    ),
    Quote(
      quote: 'O sucesso é ir de fracasso em fracasso sem perder o entusiasmo.',
      author: 'Winston Churchill',
      category: 'Motivação',
      context: 'Churchill foi primeiro-ministro britânico durante a Segunda Guerra Mundial e enfrentou inúmeras derrotas antes de levar a Inglaterra à vitória. Essa frase incentiva a resiliência e a perseverança, pois o sucesso não vem sem falhas.',
    ),
    Quote(
      quote: 'Acredite em si próprio e chegará um dia em que os outros não terão escolha senão acreditar com você.',
      author: 'Cynthia Kersey',
      category: 'Motivação',
      context: 'Cynthia é autora e palestrante motivacional. Sua frase reforça a importância da autoconfiança e do esforço contínuo para que o reconhecimento venha naturalmente.',
    ),
    Quote(
      quote: 'Tudo parece impossível até que seja feito.',
      author: 'Nelson Mandela',
      category: 'Motivação',
      context: 'Durante sua luta contra o Apartheid, Mandela enfrentou desafios aparentemente intransponíveis. Essa frase inspira a persistência diante de dificuldades.',
    ),
    Quote(
      quote: 'Penso, logo existo.',
      author: 'René Descartes',
      category: 'Filosofia',
      context: 'Essa é a base do pensamento cartesiano. Descartes buscava uma verdade incontestável e chegou à conclusão de que a própria capacidade de pensar era a prova da existência.',
    ),
    Quote(
      quote: 'A felicidade depende de nós mesmos.',
      author: 'Aristóteles',
      category: 'Filosofia',
      context: 'Aristóteles defendia a ideia de que a felicidade não depende apenas de fatores externos, mas sim de nossas ações e virtudes.',
    ),
    Quote(
      quote: 'O homem é livre no momento em que deseja ser.',
      author: 'Voltaire',
      category: 'Filosofia',
      context: 'Voltaire foi um dos grandes pensadores do Iluminismo e essa frase reflete sua crença na liberdade de pensamento e na autonomia do indivíduo.',
    ),
    Quote(
      quote: 'Somos o que repetidamente fazemos. A excelência, portanto, não é um feito, mas um hábito.',
      author: 'Will Durant (atribuída a Aristóteles)',
      category: 'Filosofia',
      context: 'Muitas vezes atribuída a Aristóteles, essa frase foi escrita por Will Durant ao interpretar os escritos do filósofo. Ela sugere que a excelência não é um talento nato, mas o resultado de práticas contínuas.',
    ),
    Quote(
      quote: 'O amor não se vê com os olhos, mas com o coração.',
      author: 'William Shakespeare',
      category: 'Amor',
      context: 'Essa frase está em Sonho de uma Noite de Verão e expressa a ideia de que o amor transcende a aparência física, sendo algo mais profundo e emocional.',
    ),
    Quote(
      quote: 'Amar não é olhar um para o outro, é olhar juntos na mesma direção.',
      author: 'Antoine de Saint-Exupéry',
      category: 'Amor',
      context: 'Escritor de O Pequeno Príncipe, Saint-Exupéry enfatiza que o amor verdadeiro não é apenas atração, mas sim um projeto de vida compartilhado.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    // Filtra as citações com base na categoria selecionada
    final filteredQuotes = quotes.where((quote) => quote.category == selectedCategory).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: categories.map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: selectedCategory == category,
                onSelected: (bool selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredQuotes.length,
            itemBuilder: (context, index) {
              final quote = filteredQuotes[index];
              final isFavorite = favoritesProvider.favoriteQuotes.contains(quote);

              return Card(
                child: ListTile(
                  title: Text(quote.quote),
                  subtitle: Text('- ${quote.author}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        onPressed: () => favoritesProvider.toggleFavorite(quote),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          Share.share('${quote.quote} - ${quote.author}');
                        },
                      ),
                    ],
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
          ),
        ),
      ],
    );
  }
}

// Tela que exibe os detalhes de uma citação
class QuoteDetailScreen extends StatelessWidget {
  final Quote quote; // Citação recebida como parâmetro

  // Construtor para receber a citação
  const QuoteDetailScreen({super.key, required this.quote});

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
            Text('- ${quote.author}', style: TextStyle(fontSize: 16)), // Exibe o autor
            SizedBox(height: 20),
            Text(quote.context.isNotEmpty ? quote.context : 'Contexto não disponível.'), // Exibe o contexto
          ],
        ),
      ),
    );
  }
}

// Tela de favoritos, que exibe as citações que foram favoritas
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteQuotes = favoritesProvider.favoriteQuotes.toList();

    return ListView.builder(
      itemCount: favoriteQuotes.length, // Número de citações favoritas
      itemBuilder: (context, index) {
        final quote = favoriteQuotes[index];

        return Card(
          child: ListTile(
            title: Text(quote.quote),
            subtitle: Text('- ${quote.author}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Remover dos Favoritos'),
                          content: Text('Você tem certeza que deseja remover esta citação dos favoritos?'),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Remover'),
                              onPressed: () {
                                favoritesProvider.toggleFavorite(quote);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share('${quote.quote} - ${quote.author}');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Tela de perfil do usuário
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Perfil do usuário"), // Exibe um texto simples para o perfil
    );
  }
}

// Classe para gerenciar as citações favoritas
class FavoritesProvider extends ChangeNotifier {
  final Set<Quote> _favoriteQuotes = {};

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