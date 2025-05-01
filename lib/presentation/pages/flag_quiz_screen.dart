import 'package:flagquizgame/core/constants/flag_data.dart';
import 'package:flagquizgame/core/constants/flag_categories.dart';
import 'package:flagquizgame/data/models/flag_model.dart';
import 'package:flagquizgame/data/models/score_model.dart';
import 'package:flagquizgame/presentation/widgets/flag_option_button.dart';
import 'package:flutter/material.dart';
import 'package:flagquizgame/services/firestore_services.dart';

class FlagQuizScreen extends StatefulWidget {
  final String gameMode;
  final int? timeLimit;
  final int? maxErrors;
  final String category;

  const FlagQuizScreen({
    super.key, 
    this.gameMode = 'classic',
    this.timeLimit,
    this.maxErrors,
    this.category = 'Tümü', required String difficulty,
  });

  @override
  State<FlagQuizScreen> createState() => _FlagQuizScreenState();
}

class _FlagQuizScreenState extends State<FlagQuizScreen> with SingleTickerProviderStateMixin {
  late List<FlagModel> _allFlags;
  late List<FlagModel> _categoryFlags;
  late List<FlagModel> _availableFlags; // Henüz sorulmamış bayrakları tutacak
  late List<FlagModel> _usedFlags; // Sorulmuş bayrakları tutacak
  late List<FlagModel> _currentOptions;
  late FlagModel _correctFlag;
  late AnimationController _animationController;
  late Animation<double> _animation;

  int _score = 0;
  int _questionCount = 0;
  int _wrongAnswers = 0;
  bool _isAnswered = false;
  String? _selectedAnswer;
  int _timeRemaining = 15; // Saniye cinsinden süre
  bool _isTimerActive = false;

  // Varsayılan değerleri tanımlayalım
  int _maxQuestions = 10; // Klasik mod için
  int _maxTime = 60; // Zaman yarışı modu için
  int _maxErrors = 3; // Yarışma modu için
  
  final Color _primaryColor = const Color(0xFF3F51B5); // Indigo
  final Color _accentColor = const Color(0xFFFF9800); // Orange
  final FirestoreService _firestoreService = FirestoreService();

  // Oyun zorluk seviyelerini tanımlayalım
  final Map<String, int> _difficultyLevels = {
    'Kolay': 20,
    'Orta': 15,
    'Zor': 10,
  };
  String _currentDifficulty = 'Orta'; // Varsayılan zorluk

  @override
  void initState() {
    super.initState();
    
    // Oyun modu parametrelerini ayarlayalım
    if (widget.gameMode == 'time' && widget.timeLimit != null) {
      _maxTime = widget.timeLimit!;
      _timeRemaining = _maxTime;
      _maxQuestions = 1000; // Pratik olarak sınırsız soru
    } else if (widget.gameMode == 'streak' && widget.maxErrors != null) {
      _maxErrors = widget.maxErrors!;
      _maxQuestions = 1000; // Pratik olarak sınırsız soru
    } else {
      // Klasik mod
      _timeRemaining = _difficultyLevels[_currentDifficulty] ?? 15;
    }
    
    // Animasyon controller'ını ayarlayalım
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _loadFlags();
    _generateQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadFlags() {
    // Tüm bayrakları yükle
    _allFlags = countryFlags.entries
        .map((entry) => FlagModel.fromMap(entry))
        .toList();
    
    // Seçilen kategoriye göre filtreleme yap
    _categoryFlags = FlagCategories.getFilteredFlags(_allFlags, widget.category);
    
    // Bayrakları karıştır
    _categoryFlags.shuffle();
    
    // Kullanılabilir bayrakları başlangıçta tüm kategorideki bayraklar olarak ayarla
    _availableFlags = List.from(_categoryFlags);
    
    // Kullanılmış bayraklar listesini başlangıçta boş olarak ayarla
    _usedFlags = [];
  }

  void _generateQuestion() {
    _animationController.reset();
    
    // Eğer mevcut kullanılabilir bayraklar tükendiyse ve hala sorulara devam edilecekse
    if (_availableFlags.isEmpty) {
      // Klasik modda, oyuncunun tüm bayrakları tamamlamasına izin verebiliriz
      if (widget.gameMode == 'classic' && _questionCount >= _maxQuestions) {
        _endGame();
        return;
      }
      
      // Diğer modlarda, kullanılmış bayrakları tekrar kullanılabilir hale getir
      // Ancak önceki sıradan farklı bir sıralama ile
      _availableFlags = List.from(_usedFlags)..shuffle();
      _usedFlags = [];
    }

    // Doğru cevap için bir bayrak seç ve kullanılabilir bayraklardan çıkar
    _correctFlag = _availableFlags.removeAt(0);
    
    // Bu bayrağı kullanılmış bayraklar listesine ekle
    _usedFlags.add(_correctFlag);
    
    // Seçenekleri oluştur (doğru cevap ve 3 yanlış)
    _currentOptions = [_correctFlag];
    
    // Yanlış cevapları eklerken, aynı bayrakları tekrar kullanmamaya dikkat et
    List<FlagModel> otherFlags = List.from(_allFlags)
      ..shuffle()
      ..removeWhere((flag) => flag.name == _correctFlag.name);
    
    // Daha önce sorulmuş bayrakları önce çıkar (Tüm opsiyonlar bitene kadar)
    if (otherFlags.length > 3) {
      otherFlags.removeWhere((flag) => _usedFlags.any((used) => used.name == flag.name));
    }
    
    // Yeterli sayıda yanıltıcı seçenek ekle
    _currentOptions.addAll(otherFlags.take(3));
    _currentOptions.shuffle(); // Seçenekleri karıştır
    
    _isAnswered = false;
    _selectedAnswer = null;
    
    // Oyun moduna göre zamanlayıcıyı ayarlayalım
    if (widget.gameMode == 'time') {
      // Zaman yarışı modunda süre sabit kalır
    } else {
      _timeRemaining = _difficultyLevels[_currentDifficulty] ?? 15;
    }
    
    _animationController.forward();
    _startTimer();
  }

  void _startTimer() {
    // Zamanın ikişer ikişer azalma sorununu düzeltmek için
    // Önce zamanlayıcıyı durduralım ve yeni zamanlayıcı başlatalım
    _stopTimer();
    _isTimerActive = true;
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _isTimerActive) {
        setState(() {
          if (_timeRemaining > 0) {
            _timeRemaining--;
            _startTimer();
          } else {
            // Süre dolduğunda farklı davranışlar
            if (widget.gameMode == 'time') {
              _endGame(); // Zaman yarışı modunda oyunu bitir
            } else {
              _handleTimeOut(); // Diğer modlarda soru süresini aş
            }
          }
        });
      }
    });
  }

  void _stopTimer() {
    _isTimerActive = false;
  }

  void _handleTimeOut() {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        
        // Yarışma modunda yanlış cevap sayılır
        if (widget.gameMode == 'streak') {
          _wrongAnswers++;
          if (_wrongAnswers >= _maxErrors) {
            Future.delayed(const Duration(seconds: 1), () {
              _endGame();
            });
            return;
          }
        }
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (widget.gameMode == 'classic' && _questionCount + 1 >= _maxQuestions) {
          _endGame();
        } else {
          setState(() {
            _questionCount++;
            _generateQuestion();
          });
        }
      });
    }
  }

  void _checkAnswer(String selected) {
    _stopTimer();
    setState(() {
      _isAnswered = true;
      _selectedAnswer = selected;
      
      // Doğru cevap kontrolü
      if (selected == _correctFlag.name) {
        _score++;
      } else {
        // Yanlış cevap kontrolü
        if (widget.gameMode == 'streak') {
          _wrongAnswers++;
          if (_wrongAnswers >= _maxErrors) {
            Future.delayed(const Duration(seconds: 1), () {
              _endGame();
            });
            return;
          }
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      // Klasik modda soru limiti kontrolü
      if (widget.gameMode == 'classic' && _questionCount + 1 >= _maxQuestions) {
        _endGame();
      } else {
        setState(() {
          _questionCount++;
          _generateQuestion();
        });
      }
    });
  }

  void _endGame() {
    _stopTimer();
    _showGameOverDialog();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final nameController = TextEditingController();
        
        // Oyun modu başlığı
        String gameTypeTitle;
        if (widget.gameMode == 'time') {
          gameTypeTitle = "Zaman Yarışı";
        } else if (widget.gameMode == 'streak') {
          gameTypeTitle = "Yarışma Modu";
        } else {
          gameTypeTitle = "Klasik Mod";
        }
        
        // Oyun modu açıklaması
        String gameDescription;
        if (widget.gameMode == 'time') {
          gameDescription = "$_maxTime saniyede $_score bayrak bildin!";
        } else if (widget.gameMode == 'streak') {
          gameDescription = "$_score doğru tahmin yaptın!";
        } else {
          gameDescription = "$_maxQuestions sorudan $_score tanesini doğru bildin!";
        }
        
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Column(
            children: [
              Text(
                "Oyun Bitti",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                gameTypeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: _accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Skor dairesi
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _primaryColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$_score",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "puan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                gameDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _getScoreMessage(_score, widget.gameMode == 'classic' ? _maxQuestions : _score),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "İsminiz",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              child: Text(
                "Yeniden Başla",
                style: TextStyle(color: _primaryColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  // Skoru Firestore'a kaydet
                  final scoreModel = ScoreModel(
                    id: '',
                    playerName: name,
                    score: _score,
                    gameMode: widget.gameMode,
                    category: widget.category,
                    timestamp: DateTime.now(),
                  );
                  
                  await _firestoreService.saveScore(scoreModel);
                  if (mounted) { // Widget hala monte edilmiş mi kontrol et
                    Navigator.of(context).pop();
                    _restartGame();
                  }
                }
              },
              child: const Text(
                "Skoru Kaydet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  String _getScoreMessage(int score, int total) {
    // Zaman yarışı ve yarışma modunda farklı mesajlar
    if (widget.gameMode == 'time') {
      if (score >= 20) return "İnanılmaz hız!";
      if (score >= 15) return "Çok iyi bir performans!";
      if (score >= 10) return "Güzel bir skor!";
      if (score >= 5) return "Fena değil, daha hızlı olabilirsin!";
      return "Daha fazla pratik yapmalısın!";
    } else if (widget.gameMode == 'streak') {
      if (score >= 30) return "Efsanevi bir performans!";
      if (score >= 20) return "İnanılmaz bilgi!";
      if (score >= 10) return "Çok iyi gidiyorsun!";
      if (score >= 5) return "Güzel başlangıç!";
      return "Bir sonraki sefere daha iyi olacak!";
    } else {
      // Klasik mod
      final percentage = (score / total) * 100;
      if (percentage >= 90) return "Muhteşem! Bayrak bilgisine hakimsin!";
      if (percentage >= 70) return "Çok iyi! Biraz daha çalışırsan mükemmel olacak.";
      if (percentage >= 50) return "Fena değil. Pratik yapmaya devam et!";
      if (percentage >= 30) return "Daha fazla çalışmaya ihtiyacın var.";
      return "Yeniden dene ve kendini geliştir!";
    }
  }

  void _restartGame() {
    setState(() {
      _score = 0;
      _questionCount = 0;
      _wrongAnswers = 0;
      
      // Zaman yarışı modunda süreyi sıfırla
      if (widget.gameMode == 'time') {
        _timeRemaining = _maxTime;
      }
      
      // Bayrakları yeniden yükle ve kullanılan bayrakları sıfırla
      _loadFlags();
      _generateQuestion();
    });
  }

  void _showDifficultyDialog() {
    // Zaman yarışı modunda zorluk ayarı gösterme
    if (widget.gameMode == 'time') {
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Zorluk Seviyesi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _difficultyLevels.keys.map((level) {
              return RadioListTile<String>(
                title: Text(level),
                value: level,
                groupValue: _currentDifficulty,
                onChanged: (value) {
                  setState(() {
                    _currentDifficulty = value!;
                    Navigator.of(context).pop();
                    _stopTimer();
                    _timeRemaining = _difficultyLevels[_currentDifficulty]!;
                    _startTimer();
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("İptal"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category != 'Tümü' 
              ? "${widget.category} Bayrakları" 
              : widget.gameMode == 'time'
                  ? "Zaman Yarışı" 
                  : widget.gameMode == 'streak'
                      ? "Yarışma Modu"
                      : "World Quest",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: _primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showDifficultyDialog,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _primaryColor.withOpacity(0.8),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _currentOptions.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Skor ve soru bilgisi
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.emoji_events, color: _accentColor),
                          const SizedBox(width: 8),
                          Text(
                            "Skor: $_score${widget.gameMode == 'classic' ? ' / $_maxQuestions' : ''}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Soru numarası, zamanlayıcı ve yarışma modu için can sayısı
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Soru numarası (yarışma modunda gösterme)
                        if (widget.gameMode != 'streak')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              widget.gameMode == 'time'
                                  ? "$_questionCount. Soru"
                                  : "${_questionCount + 1}. Soru",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        
                        // Yarışma modunda can sayısı
                        if (widget.gameMode == 'streak')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                ...List.generate(
                                  _maxErrors - _wrongAnswers,
                                  (index) => const Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                ...List.generate(
                                  _wrongAnswers,
                                  (index) => const Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        // Zamanlayıcı
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: widget.gameMode == 'time'
                                ? (_timeRemaining < 10 ? Colors.red : Colors.orange)
                                : (_timeRemaining < 5 ? Colors.red : Colors.green),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.timer,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "$_timeRemaining",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),

                    // Bayrak görseli
                    FadeTransition(
                      opacity: _animation,
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            _correctFlag.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.flag, size: 100),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Seçenekler
                    ..._currentOptions.map(
                      (flag) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: FlagOptionButton(
                            text: flag.name,
                            isCorrect: _isAnswered && flag.name == _correctFlag.name,
                            isSelected: _isAnswered && flag.name == _selectedAnswer,
                            isDisabled: _isAnswered,
                            onTap: () => _checkAnswer(flag.name),
                          ),
                        );
                      },
                    ).toList(),
                  ],
                ),
        ),
      ),
    );
  }
}
