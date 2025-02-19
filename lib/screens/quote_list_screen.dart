import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../providers/favorites_provider.dart';
import 'quote_detail_screen.dart';

const List<String> categories = [
  'Motivação',
  'Filosofia',
  'Amor',
];

class QuoteListScreen extends StatefulWidget {
  const QuoteListScreen({super.key});

  @override
  _QuoteListScreenState createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  String selectedCategory = 'Motivação';

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