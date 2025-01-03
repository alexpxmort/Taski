import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/data/database/task_model.dart';
import 'package:taski/presentation/screens/task_list.dart';
import 'package:taski/presentation/viewmodels/task_viewmodel.dart';
import 'package:taski/widgets/header.dart';
import 'package:taski/widgets/not-results.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<TaskModel> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    // Atualiza os resultados da busca conforme o texto muda
    _searchController.addListener(_filterTasks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTasks() {
    final tasks = ref.read(taskListProvider);
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredTasks = tasks;
      } else {
        _filteredTasks = tasks
            .where((task) =>
                task.title.toLowerCase().contains(query)) // Filtra pelo título
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(taskListProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de busca
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7F9), // Cor de fundo do campo
                borderRadius: BorderRadius.circular(30.0), // Borda arredondada
                border: Border.all(
                  color: const Color(0xFFCCE4FF), // Cor da borda
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF007BFF), // Cor do ícone de busca
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: Color(0xFF3F3D56),
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search tasks',
                        hintStyle: TextStyle(
                          color: Color(0xFF3F3D56),
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _searchController.clear(); // Limpa o texto no campo
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xFFCCE4FF),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _filteredTasks.isEmpty
                ? NoResultsWidget()
                : Expanded(child: TaskList(tasks: _filteredTasks))
          ],
        ),
      ),
    );
  }
}
