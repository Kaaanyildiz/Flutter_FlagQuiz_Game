import 'package:flutter/material.dart';
import 'package:flagquizgame/core/constants/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> with TickerProviderStateMixin {
  // PageView için controller
  late final PageController _pageController;
  // Mevcut sayfayı izlemek için
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tam ekran sayfa olarak değiştirdik (Dialog yerine)
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppTheme.mainGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Başlık ve Kapat Butonu
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        "Nasıl Oynanır?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Kapat butonu
                    Material(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(30),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Ana içerik bölümü - Genişletilmiş alan
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Ana içerik - PageView ile kaydırılabilir
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            children: [
                              // Sayfa 1: Oyuna Genel Bakış
                              _buildHowToPlayPage(
                                title: "Oyuna Hoş Geldiniz!",
                                description: "World Quest, dünya bayraklarını eğlenceli bir şekilde öğrenmenizi sağlar. Üç farklı oyun modu ile bilginizi test edin!",
                                animation: _buildWelcomeAnimation(),
                                tips: [
                                  "Farklı oyun modlarını deneyin",
                                  "Kategorileri keşfedin",
                                  "Skorunuzu skor tablosunda görün"
                                ],
                              ),
                              
                              // Sayfa 2: Klasik Mod
                              _buildHowToPlayPage(
                                title: "Klasik Mod",
                                description: "Bu modda 10 soruda ne kadar doğru cevap verebileceğinizi test edin.",
                                animation: _buildClassicModeAnimation(),
                                tips: [
                                  "Gösterilen bayrağın hangi ülkeye ait olduğunu seçin",
                                  "Her soru için süre sınırı var",
                                  "Zorluk seviyesini ayarlayabilirsiniz"
                                ],
                                customContent: _buildAnimatedGameplayDemo(
                                  flag: 'https://flagcdn.com/w320/jp.png',
                                  options: ["Japonya", "Çin", "Vietnam", "Güney Kore"],
                                  correctAnswer: "Japonya"
                                ),
                              ),
                              
                              // Sayfa 3: Zaman Yarışı Modu
                              _buildHowToPlayPage(
                                title: "Zaman Yarışı",
                                description: "60 saniye içinde kaç tane bayrağı doğru tahmin edebilirsiniz?",
                                animation: _buildTimeTrialAnimation(),
                                tips: [
                                  "Hızlı düşünün ve hızlı cevap verin",
                                  "Yanlış cevaplar ceza vermez",
                                  "Süreniz dolduğunda oyun biter"
                                ],
                                customContent: _buildTimerDemo(),
                              ),
                              
                              // Sayfa 4: Yarışma Modu
                              _buildHowToPlayPage(
                                title: "Yarışma Modu",
                                description: "Ne kadar ilerleyebilirsiniz? Sadece 3 yanlış hakkınız var!",
                                animation: _buildStreakModeAnimation(),
                                tips: [
                                  "Her yanlış cevap bir can kaybettirir",
                                  "Can sayınız sol üstte gösterilir",
                                  "Mümkün olduğunca çok soru cevaplamaya çalışın"
                                ],
                                customContent: _buildLivesDemo(),
                              ),
                              
                              // Sayfa 5: Kategoriler
                              _buildHowToPlayPage(
                                title: "Kategoriler",
                                description: "Farklı kıtalar veya zorluk seviyeleri arasında seçim yapabilirsiniz.",
                                animation: _buildCategoriesAnimation(),
                                tips: [
                                  "Kıtalara göre filtreleme yapın",
                                  "Kolay, Orta, Zor zorluk seviyeleri",
                                  "İstediğiniz zaman kategori değiştirebilirsiniz"
                                ],
                                customContent: _buildCategoriesDemo(),
                              ),
                              
                              // Sayfa 6: İpuçları
                              _buildHowToPlayPage(
                                title: "Pro İpuçları",
                                description: "Daha iyi skor elde etmek için bu ipuçlarını uygulayın!",
                                animation: _buildTipsAnimation(),
                                tips: [
                                  "Bayrakların renklerine ve sembollerine dikkat edin",
                                  "Benzer bayrakları ezberleyin",
                                  "Düzenli olarak pratik yapın",
                                  "Her oyundan sonra yanlış cevapladığınız ülkeleri öğrenin"
                                ],
                                customContent: _buildTipsContent(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Alt navigasyon bölümü
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Sayfa göstergeleri
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(6, (index) {
                                return Container(
                                  width: _currentPage == index ? 24 : 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: _currentPage == index 
                                        ? AppTheme.primaryColor 
                                        : Colors.grey.withOpacity(0.3),
                                  ),
                                );
                              }),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // İleri/Geri butonları
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Geri butonu
                                if (_currentPage > 0)
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _pageController.previousPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                                    label: const Text("Geri", style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryColor.withOpacity(0.7),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(width: 100),
                                    
                                // İleri veya Bitir butonu
                                ElevatedButton.icon(
                                  onPressed: () {
                                    if (_currentPage < 5) {
                                      _pageController.nextPage(
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  icon: Icon(
                                    _currentPage < 5 ? Icons.arrow_forward : Icons.check,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    _currentPage < 5 ? "İleri" : "Anladım",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  
  // Özel animasyon widget'ları - Lottie yerine Flutter Animate kullanıyoruz
  Widget _buildWelcomeAnimation() {
    return Container(
      width: 260,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.flag_rounded,
        size: 100,
        color: AppTheme.primaryColor,
      )
      .animate(onPlay: (controller) => controller.repeat())
      .scale(
        duration: 2.seconds,
        begin: const Offset(1, 1),
        end: const Offset(1.1, 1.1),
        curve: Curves.easeInOut,
      )
      .then()
      .scale(
        duration: 2.seconds,
        begin: const Offset(1.1, 1.1),
        end: const Offset(1, 1),
        curve: Curves.easeInOut,
      )
      .shimmer(
        duration: 1.7.seconds,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }

  Widget _buildClassicModeAnimation() {
    return Container(
      width: 260,
      height: 200,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Bayrak sembolleri
          Positioned(
            child: const Icon(
              Icons.flag_circle,
              size: 70,
              color: AppTheme.primaryColor,
            )
            .animate(onPlay: (controller) => controller.repeat())
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.5, end: 0, duration: 600.ms, curve: Curves.easeOutQuad)
            .then(delay: 1.seconds)
            .fadeOut(duration: 300.ms)
            .slideY(begin: 0, end: -0.3, duration: 300.ms),
          ),
          
          // Tick sembolleri
          Positioned(
            right: 70,
            bottom: 60,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 30,
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .fadeIn(delay: 1.3.seconds, duration: 400.ms)
            .scale(
              delay: 1.3.seconds,
              duration: 400.ms, 
              begin: const Offset(0.5, 0.5),
              end: const Offset(1, 1),
              curve: Curves.easeOutBack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeTrialAnimation() {
    return Container(
      width: 260,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Arka plan kronometre
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.orange.withOpacity(0.5),
                width: 8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
          )
          .animate(onPlay: (controller) => controller.repeat())
          .custom(
            duration: 5.seconds,
            builder: (context, value, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  child!,
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: 1 - value,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        value > 0.75 ? Colors.green :
                        value > 0.5 ? Colors.orange : 
                        Colors.red,
                      ),
                      backgroundColor: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ],
              );
            }
          ),
          
          // Kronometre ikonu
          const Icon(
            Icons.timer,
            size: 40,
            color: Colors.orange,
          )
          .animate(onPlay: (controller) => controller.repeat())
          .shake(duration: 400.ms, delay: 4.5.seconds),
          
          // Sayaç metin
          Positioned(
            bottom: 50,
            child: const Text(
              "60",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .custom(
              duration: 5.seconds,
              builder: (context, value, child) {
                final secondsLeft = (60 * (1 - value)).round();
                return Text(
                  "$secondsLeft",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: value > 0.75 ? Colors.green :
                          value > 0.5 ? Colors.orange : 
                          Colors.red,
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStreakModeAnimation() {
    return Container(
      width: 260,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Kalplar
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 60,
                )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  duration: 800.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  duration: 800.ms,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1, 1),
                  curve: Curves.easeInOut,
                ),
                
                const SizedBox(width: 20),
                
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 60,
                )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  delay: 300.ms,
                  duration: 800.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  duration: 800.ms,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1, 1),
                  curve: Curves.easeInOut,
                ),
                
                const SizedBox(width: 20),
                
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 60,
                )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                  delay: 600.ms,
                  duration: 800.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  curve: Curves.easeInOut,
                )
                .then()
                .scale(
                  duration: 800.ms,
                  begin: const Offset(1.1, 1.1),
                  end: const Offset(1, 1),
                  curve: Curves.easeInOut,
                ),
              ],
            ),
          ),
          
          // Skor metni
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                "15 Soru!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
              duration: 2.seconds,
              color: AppTheme.primaryColor.withOpacity(0.8),
              delay: 2.seconds,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoriesAnimation() {
    return Container(
      width: 260,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Kıtalar
          Align(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                _buildAnimatedCategoryPill("Avrupa", Colors.blue),
                _buildAnimatedCategoryPill("Asya", Colors.red),
                _buildAnimatedCategoryPill("Amerika", Colors.purple),
                _buildAnimatedCategoryPill("Afrika", Colors.brown),
                _buildAnimatedCategoryPill("Okyanusya", Colors.teal),
              ],
            ),
          ),
          
          // Alt kısımdaki zorluk seviyeleri
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAnimatedDifficultyPill("Kolay", Colors.green, 0),
                const SizedBox(width: 10),
                _buildAnimatedDifficultyPill("Orta", Colors.orange, 150),
                const SizedBox(width: 10),
                _buildAnimatedDifficultyPill("Zor", Colors.red, 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAnimatedCategoryPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
    .animate(onPlay: (controller) => controller.repeat())
    .fadeIn(
      duration: 600.ms,
      delay: Duration(milliseconds: (500 * text.hashCode % 5)),
    )
    .slideY(
      begin: 0.3,
      end: 0,
      duration: 600.ms,
      delay: Duration(milliseconds: (500 * text.hashCode % 5)),
      curve: Curves.easeOutQuad,
    )
    .then(delay: 4.seconds)
    .fadeOut(duration: 600.ms)
    .slideY(
      begin: 0,
      end: -0.3,
      duration: 600.ms,
    );
  }
  
  Widget _buildAnimatedDifficultyPill(String text, Color color, int delayMs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    )
    .animate(onPlay: (controller) => controller.repeat())
    .scale(
      delay: Duration(milliseconds: 2000 + delayMs),
      duration: 600.ms,
      begin: const Offset(0.8, 0.8),
      end: const Offset(1, 1),
      curve: Curves.elasticOut,
    );
  }
  
  Widget _buildTipsAnimation() {
    return Container(
      width: 260,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ipucu ampulü
          Positioned(
            top: 20,
            child: const Icon(
              Icons.lightbulb,
              color: Colors.amber,
              size: 80,
            )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(
              duration: 1.5.seconds,
              color: Colors.white,
            )
            .then()
            .fadeOut(duration: 200.ms)
            .then()
            .fadeIn(duration: 200.ms),
          ),
          
          // Ipucu metinleri
          Positioned(
            bottom: 20,
            child: Column(
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppTheme.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "İpucu ${index + 1}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .fadeIn(
                  delay: Duration(milliseconds: 500 + index * 300),
                  duration: 500.ms,
                )
                .slideX(
                  begin: 0.5,
                  end: 0,
                  delay: Duration(milliseconds: 500 + index * 300),
                  duration: 500.ms,
                  curve: Curves.easeOutQuad,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
  
  // Yardım sayfası widget'ı
  Widget _buildHowToPlayPage({
    required String title,
    required String description,
    required Widget animation,
    required List<String> tips,
    Widget? customContent,
  }) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Center(
              child: Animate(
                effects: const [
                  FadeEffect(duration: Duration(milliseconds: 400)),
                  SlideEffect(
                    begin: Offset(0, -20),
                    end: Offset(0, 0),
                    duration: Duration(milliseconds: 400),
                  ),
                ],
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Açıklama
            Center(
              child: Animate(
                effects: const [
                  FadeEffect(
                    duration: Duration(milliseconds: 400),
                    delay: Duration(milliseconds: 100),
                  ),
                ],
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Özel Animate animasyonları
            if (customContent == null)
              Animate(
                effects: const [
                  FadeEffect(
                    duration: Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 200),
                  ),
                  ScaleEffect(
                    begin: Offset(0.8, 0.8),
                    end: Offset(1, 1),
                    duration: Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 200),
                  ),
                ],
                child: Center(
                  child: animation, // flutter_animate ile özel animasyon
                ),
              )
            else
              // Özel içerik varsa onu göster
              Animate(
                effects: const [
                  FadeEffect(
                    duration: Duration(milliseconds: 600),
                    delay: Duration(milliseconds: 200),
                  ),
                ],
                child: customContent,
              ),
            
            const SizedBox(height: 24),
            
            // İpuçları listesi
            Animate(
              effects: const [
                FadeEffect(
                  duration: Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 300),
                ),
                SlideEffect(
                  begin: Offset(20, 0),
                  end: Offset(0, 0),
                  duration: Duration(milliseconds: 600),
                  delay: Duration(milliseconds: 300),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.lightbulb,
                          color: AppTheme.primaryColor,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "İpuçları:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...tips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              tip,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Klasik mod için animasyonlu oynanış demosu
  Widget _buildAnimatedGameplayDemo({
    required String flag,
    required List<String> options,
    required String correctAnswer,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: AspectRatio(
        aspectRatio: 0.9,  // Daha fazla dikey alan için aspectRatio değerini arttırdım
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bayrak gösterimi - boyutu biraz küçülttüm
              Animate(
                effects: const [
                  FadeEffect(duration: Duration(milliseconds: 600)),
                  SlideEffect(
                    begin: Offset(0, -20),
                    end: Offset(0, 0),
                    duration: Duration(milliseconds: 600),
                  ),
                ],
                child: Container(
                  width: 160, // Daha küçük bayrak
                  height: 100, // Daha küçük bayrak
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      flag,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16), // Daha küçük boşluk
              
              // Cevap seçenekleri - daha kompakt
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: options.asMap().entries.map((entry) {
                      int index = entry.key;
                      String option = entry.value;
                      bool isCorrect = option == correctAnswer;
                      
                      return Animate(
                        effects: [
                          FadeEffect(
                            duration: const Duration(milliseconds: 400),
                            delay: Duration(milliseconds: 300 + index * 100),
                          ),
                          SlideEffect(
                            begin: const Offset(30, 0),
                            end: const Offset(0, 0),
                            duration: const Duration(milliseconds: 400),
                            delay: Duration(milliseconds: 300 + index * 100),
                          ),
                        ],
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8), // daha az alt boşluk
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: isCorrect ? AppTheme.correctAnswerColor.withOpacity(0.2) : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isCorrect ? AppTheme.correctAnswerColor : Colors.grey.withOpacity(0.3),
                                width: isCorrect ? 2 : 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // daha az padding
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 14, // daha küçük font boyutu
                                      fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
                                      color: isCorrect ? AppTheme.correctAnswerColor : Colors.black87,
                                    ),
                                  ),
                                ),
                                if (isCorrect)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppTheme.correctAnswerColor,
                                    size: 18, // daha küçük ikon
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Zaman yarışı demo
  Widget _buildTimerDemo() {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Zamanlayıcı dış çember
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return SizedBox(
                  width: 220,
                  height: 220,
                  child: CircularProgressIndicator(
                    value: 1.0 - value,
                    strokeWidth: 15,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      value < 0.25 ? Colors.red :
                      value < 0.5 ? Colors.orange : Colors.green,
                    ),
                  ),
                );
              },
            ),
            
            // İç içerik
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.timer,
                  size: 46,
                  color: Colors.orange,
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 60, end: 0),
                  duration: const Duration(seconds: 5),
                  builder: (context, value, child) {
                    return Text(
                      "$value",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: value < 10 ? Colors.red :
                            value < 30 ? Colors.orange : Colors.green,
                      ),
                    );
                  },
                ),
                const Text(
                  "saniye",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // Yarışma modu - Can demosu
  Widget _buildLivesDemo() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Can sayısı gösterimi
                TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 3, end: 1),
                  duration: const Duration(seconds: 4),
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        ...List.generate(value, (index) => 
                          Animate(
                            effects: [
                              ShakeEffect(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 1000 * (3 - value)),
                              ),
                            ],
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 34,
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(3 - value, (index) => 
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.grey,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                
                const SizedBox(width: 12),
                
                const Text(
                  "Kalan Can",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Skor gösterimi
          Container(
            width: 200,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Mevcut Skor",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: 12),
                  duration: const Duration(seconds: 5),
                  builder: (context, value, child) {
                    return Text(
                      "$value",
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Kategoriler demosu
  Widget _buildCategoriesDemo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Kıtalar başlığı
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Kıtalar",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Kıtalar - 2 sütunlu grid görünümü
            Wrap(
              spacing: 6,
              runSpacing: 6,
              alignment: WrapAlignment.center,
              children: [
                _buildCategoryChip("Tümü", Icons.public, Colors.blue),
                _buildCategoryChip("Avrupa", Icons.euro, Colors.blue),
                _buildCategoryChip("Asya", Icons.temple_buddhist, Colors.red),
                _buildCategoryChip("Amerika", Icons.location_city, Colors.purple),
                _buildCategoryChip("Afrika", Icons.terrain, Colors.brown),
                _buildCategoryChip("Av/Pasifik", Icons.waves, Colors.teal),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Zorluk seviyeleri başlığı
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Zorluk Seviyeleri",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Zorluk seviyeleri
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryChip("Kolay", Icons.sentiment_satisfied, Colors.green),
                const SizedBox(width: 8),
                _buildCategoryChip("Orta", Icons.sentiment_neutral, Colors.orange),
                const SizedBox(width: 8),
                _buildCategoryChip("Zor", Icons.sentiment_very_dissatisfied, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCategoryChip(String label, IconData icon, Color color) {
    return Animate(
      effects: [
        FadeEffect(
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: 100 * (label.hashCode % 8)),
        ),
        ScaleEffect(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: const Duration(milliseconds: 400),
          delay: Duration(milliseconds: 100 * (label.hashCode % 8)),
        ),
      ],
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13, // Font boyutunu küçülttüm
          ),
        ),
        avatar: Icon(
          icon,
          color: color,
          size: 18, // İkon boyutunu küçülttüm
        ),
        backgroundColor: color.withOpacity(0.1),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), // Padding'i azalttım
        labelPadding: const EdgeInsets.only(left: 4, right: 4), // Label padding'i azalttım
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Hedef boyutunu küçülttüm
      ),
    );
  }
  
  // İpuçları içeriği
  Widget _buildTipsContent() {
    return Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: _buildFlagComparisonItem(
                    "https://flagcdn.com/w320/se.png",
                    "İsveç",
                    Colors.blue.withOpacity(0.1),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildFlagComparisonItem(
                    "https://flagcdn.com/w320/no.png",
                    "Norveç",
                    Colors.red.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Animate(
              effects: const [
                FadeEffect(duration: Duration(milliseconds: 800), delay: Duration(milliseconds: 300)),
                SlideEffect(
                  begin: Offset(0, 10),
                  end: Offset(0, 0),
                  duration: Duration(milliseconds: 800),
                  delay: Duration(milliseconds: 300),
                ),
              ],
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Text(
                  "Benzer bayrakları ayırt etmeyi öğrenin!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFlagComparisonItem(String flagUrl, String country, Color bgColor) {
    return Animate(
      effects: const [
        FadeEffect(duration: Duration(milliseconds: 600)),
        SlideEffect(
          begin: Offset(0, 10),
          end: Offset(0, 0),
          duration: Duration(milliseconds: 600),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                flagUrl,
                height: 60,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 60,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              country,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Nasıl Oynanır ekranını gösteren fonksiyon
void showHowToPlayScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const HowToPlayScreen()
    ),
  );
}