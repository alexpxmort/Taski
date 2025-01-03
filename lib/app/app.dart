import 'package:flutter/material.dart';
import 'package:taski/presentation/screens/createTask_screen.dart';
import 'package:taski/presentation/screens/done_tasks.dart';
import 'package:taski/presentation/screens/home_screen.dart';

class TaskiApp extends StatefulWidget {
  const TaskiApp({Key? key}) : super(key: key);

  @override
  _TaskiAppState createState() => _TaskiAppState();
}

class _TaskiAppState extends State<TaskiApp> {
  int _selectedIndex = 0;

  // Função para alternar a aba
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Lista de widgets para cada tela
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CreateTaskScreen(),
    Text('Search Screen',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    TasksDoneScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taski',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      scrollBehavior:
          MaterialScrollBehavior(), // Comportamento de rolagem padrão
      home: Scaffold(
        appBar: AppBar(
          title: Text('Taski App'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          unselectedItemColor: Color(0xFFA2B9D4),
          selectedItemColor: Colors.blue,
          selectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFA2B9D4)), // Tamanho da fonte do item selecionado
          unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFA2B9D4)), //
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Todo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.create),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: 'Done',
            ),
          ],
        ),
      ),
    );
  }
}
