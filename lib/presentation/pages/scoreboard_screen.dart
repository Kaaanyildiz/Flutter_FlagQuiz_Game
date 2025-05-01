import 'package:flutter/material.dart';
import 'package:flagquizgame/data/models/score_model.dart';
import 'package:flagquizgame/services/firestore_services.dart';
import 'package:intl/intl.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({Key? key}) : super(key: key);

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirestoreService _firestoreService = FirestoreService();
  
  final List<String> _gameModes = ['Klasik Mod', 'Zaman Yarışı', 'Yarışma Modu'];
  final Map<String, String> _gameModeValues = {
    'Klasik Mod': 'classic',
    'Zaman Yarışı': 'timeRace',
    'Yarışma Modu': 'competition',
  };
  
  String _selectedCategory = 'Tümü';
  bool _isLoading = false;
  List<ScoreModel> _scores = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _gameModes.length, vsync: this);
    _loadScores();
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _loadScores();
      }
    });
  }

  Future<void> _loadScores() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final String gameMode = _gameModeValues[_gameModes[_tabController.index]] ?? 'classic';
      final scores = await _firestoreService.getScores(
        gameMode: gameMode,
        category: _selectedCategory,
      );
      
      if (mounted) {
        setState(() {
          _scores = scores;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Skorlar yüklenirken bir hata oluştu: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skor Tablosu', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: _gameModes.map((mode) => Tab(text: mode)).toList(),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          indicatorWeight: 3,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              value: _selectedCategory,
              items: [
                'Tümü',
                'Avrupa',
                'Asya',
                'Amerika',
                'Afrika',
                'Okyanusya',
                'Orta Doğu',
                'Kolay',
                'Orta',
                'Zor'
              ].map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                  _loadScores();
                }
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(_gameModes.length, (index) {
                return _buildScoreList();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_scores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Henüz skor kaydı yok!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Bu mod ve kategori için ilk skoru siz ekleyin.',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _scores.length,
      itemBuilder: (context, index) {
        final score = _scores[index];
        final bool isTopThree = index < 3;
        
        return Card(
          elevation: isTopThree ? 4 : 1,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isTopThree
                ? BorderSide(color: _getPositionColor(index), width: 2)
                : BorderSide.none,
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: _getPositionColor(index),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              score.playerName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Kategori: ${score.category} • ${DateFormat('dd.MM.yyyy').format(score.timestamp)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${score.score} puan',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 0:
        return Colors.amber[700]!; // Altın
      case 1:
        return Colors.blueGrey[300]!; // Gümüş
      case 2:
        return Colors.brown[300]!; // Bronz
      default:
        return Colors.grey[400]!;
    }
  }
}