import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/quote_list_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/profile_screen.dart';

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