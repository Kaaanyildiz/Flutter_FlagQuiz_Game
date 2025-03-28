import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';

void main() {
  runApp(FlagQuizApp());
}

class FlagQuizApp extends StatelessWidget {
  const FlagQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlagQuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlagQuizScreen extends StatefulWidget {
  const FlagQuizScreen({super.key});

  @override
  _FlagQuizScreenState createState() => _FlagQuizScreenState();
}

class _FlagQuizScreenState extends State<FlagQuizScreen> {
  final Map<String, String> countryFlags = {
    "Türkiye": "https://flagcdn.com/w320/tr.png",
    "Almanya": "https://flagcdn.com/w320/de.png",
    "Fransa": "https://flagcdn.com/w320/fr.png",
    "İtalya": "https://flagcdn.com/w320/it.png",
    "İspanya": "https://flagcdn.com/w320/es.png",
    "İngiltere": "https://flagcdn.com/w320/gb.png",
    "Japonya": "https://flagcdn.com/w320/jp.png",
    "Brezilya": "https://flagcdn.com/w320/br.png",
    "Arjantin": "https://flagcdn.com/w320/ar.png",
    "Meksika": "https://flagcdn.com/w320/mx.png",
    "Hindistan": "https://flagcdn.com/w320/in.png",
    "Endonezya": "https://flagcdn.com/w320/id.png",
    "Filipinler": "https://flagcdn.com/w320/ph.png",
    "Güney Kore": "https://flagcdn.com/w320/kr.png",
    "Şili": "https://flagcdn.com/w320/cl.png",
    "Kolombiya": "https://flagcdn.com/w320/co.png",
    "Pakistan": "https://flagcdn.com/w320/pk.png",
    "Tayland": "https://flagcdn.com/w320/th.png",
    "Vietnam": "https://flagcdn.com/w320/vn.png",
    "Mısır": "https://flagcdn.com/w320/eg.png",
    "Tunus": "https://flagcdn.com/w320/tn.png",
    "Yunanistan": "https://flagcdn.com/w320/gr.png",
    "Portekiz": "https://flagcdn.com/w320/pt.png",
    "Belçika": "https://flagcdn.com/w320/be.png",
    "İsveç": "https://flagcdn.com/w320/se.png",
    "Danimarka": "https://flagcdn.com/w320/dk.png",
    "Norveç": "https://flagcdn.com/w320/no.png",
    "İsviçre": "https://flagcdn.com/w320/ch.png",
    "Gana": "https://flagcdn.com/w320/gh.png",
    "Kenya": "https://flagcdn.com/w320/ke.png",
    "Kosta Rika": "https://flagcdn.com/w320/cr.png",
    "Moğolistan": "https://flagcdn.com/w320/mn.png",
    "Lübnan": "https://flagcdn.com/w320/lb.png",
    "Kazakistan": "https://flagcdn.com/w320/kz.png",
    "Gürcistan": "https://flagcdn.com/w320/ge.png",
    "Nepal": "https://flagcdn.com/w320/np.png",
    "Avustralya": "https://flagcdn.com/w320/au.png",
    "Kanada": "https://flagcdn.com/w320/ca.png",
    "ABD": "https://flagcdn.com/w320/us.png",
    "Çin": "https://flagcdn.com/w320/cn.png",
    "Rusya": "https://flagcdn.com/w320/ru.png",
    "Suudi Arabistan": "https://flagcdn.com/w320/sa.png",
    "Güney Afrika": "https://flagcdn.com/w320/za.png",
    "Fiji": "https://flagcdn.com/w320/fj.png",
    "Bhutan": "https://flagcdn.com/w320/bt.png",
    "Eritre": "https://flagcdn.com/w320/er.png",
    "Belize": "https://flagcdn.com/w320/bz.png",
    "Vanuatu": "https://flagcdn.com/w320/vu.png",
    "Tonga": "https://flagcdn.com/w320/to.png",
    "Kiribati": "https://flagcdn.com/w320/ki.png",
    "Eswatini": "https://flagcdn.com/w320/sz.png",
    "Surinam": "https://flagcdn.com/w320/sr.png",
    "Guyana": "https://flagcdn.com/w320/gy.png",
    "Dominika": "https://flagcdn.com/w320/dm.png",
    "Barbados": "https://flagcdn.com/w320/bb.png",
    "Grenada": "https://flagcdn.com/w320/gd.png",
    "Bahamalar": "https://flagcdn.com/w320/bs.png",
    "Jamaika": "https://flagcdn.com/w320/jm.png",
    "Trinidad ve Tobago": "https://flagcdn.com/w320/tt.png",
    "Haiti": "https://flagcdn.com/w320/ht.png",
    "Dominik Cumhuriyeti": "https://flagcdn.com/w320/do.png",
    "Küba": "https://flagcdn.com/w320/cu.png",
    "Honduras": "https://flagcdn.com/w320/hn.png",
    "El Salvador": "https://flagcdn.com/w320/sv.png",
    "Guatemala": "https://flagcdn.com/w320/gt.png",
    "Nicaragua": "https://flagcdn.com/w320/ni.png",
    "Panama": "https://flagcdn.com/w320/pa.png",
    "Senegal": "https://flagcdn.com/w320/sn.png",
    "Bolivya": "https://flagcdn.com/w320/bo.png",
    "Peru": "https://flagcdn.com/w320/pe.png",
    "Ekvador": "https://flagcdn.com/w320/ec.png",
    "Katar": "https://flagcdn.com/w320/qa.png",
    "Yeni Zelanda": "https://flagcdn.com/w320/nz.png",
    "İran": "https://flagcdn.com/w320/ir.png",
    "Bangladeş": "https://flagcdn.com/w320/bd.png",
    "Malezya": "https://flagcdn.com/w320/my.png",
    "Myanmar": "https://flagcdn.com/w320/mm.png",
    "Singapur": "https://flagcdn.com/w320/sg.png",
    "Kamboçya": "https://flagcdn.com/w320/kh.png",
    "Lao": "https://flagcdn.com/w320/la.png",
    "Sudan": "https://flagcdn.com/w320/sd.png",
    "Zambiya": "https://flagcdn.com/w320/zm.png",
    "Zimbabve": "https://flagcdn.com/w320/zw.png",
    "Madagaskar": "https://flagcdn.com/w320/mg.png",
    "Botsvana": "https://flagcdn.com/w320/bw.png",
    "Malavi": "https://flagcdn.com/w320/mw.png",
    "Mozambik": "https://flagcdn.com/w320/mz.png",
    "Katar": "https://flagcdn.com/w320/qa.png",
    "Birleşik Arap Emirlikleri": "https://flagcdn.com/w320/ae.png",
    "Yeni Zelanda": "https://flagcdn.com/w320/nz.png",
    "Singapur": "https://flagcdn.com/w320/sg.png",
    "Malezya": "https://flagcdn.com/w320/my.png",
    "Bangladeş": "https://flagcdn.com/w320/bd.png",
    "Sri Lanka": "https://flagcdn.com/w320/lk.png",
    "Afganistan": "https://flagcdn.com/w320/af.png",
    "Irak": "https://flagcdn.com/w320/iq.png",
    "İran": "https://flagcdn.com/w320/ir.png",
    "Suriye": "https://flagcdn.com/w320/sy.png",
    "Özbekistan": "https://flagcdn.com/w320/uz.png",
    "Türkmenistan": "https://flagcdn.com/w320/tm.png",
    "Bolivya": "https://flagcdn.com/w320/bo.png",
    "Paraguay": "https://flagcdn.com/w320/py.png",
  };

  late String correctAnswer;
  late String flagUrl;
  List<String> options = [];
  int score = 0;
  int questionCount = 0;
  String playerName = "Oyuncu1";
  String? selectedAnswer;


  List<String> askedCountries = [];

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    final random = Random();
    List<String> keys = countryFlags.keys.toList();


    String newCountry;
    do {
      newCountry = keys[random.nextInt(keys.length)];
    } while (askedCountries.contains(newCountry));

    correctAnswer = newCountry;
    flagUrl = countryFlags[correctAnswer]!;


    options = [correctAnswer];
    while (options.length < 4) {
      String randomOption = keys[random.nextInt(keys.length)];
      if (!options.contains(randomOption)) {
        options.add(randomOption);
      }
    }
    options.shuffle(); 


    askedCountries.add(correctAnswer);

    if (askedCountries.length > 10) {
      askedCountries = [];
    }

    selectedAnswer = null;
    setState(() {});
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      if (answer == correctAnswer) {
        score++;
      }
      questionCount++;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (questionCount >= 10) {
        showGameOverDialog();
      } else {
        generateNewQuestion();
      }
    });
  }

  void showGameOverDialog() async {
    try {
      await FirebaseFirestore.instance.collection('scores').doc(playerName).set({
        'name': playerName,
        'score': score,
      });
    } catch (e) {
      print("Firestore hatası: $e");
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Oyun Bitti"),
        content: Text("Skorunuz: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                questionCount = 0;
                score = 0;
                generateNewQuestion();
              });
            },
            child: Text("Tekrar Oyna"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bayrak Quiz")),
      backgroundColor: const Color.fromARGB(255, 146, 145, 145), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              flagUrl,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 100, color: Colors.red);
              },
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 20),
            Column(
              children: options.map((option) {
                bool isCorrect = option == correctAnswer;
                bool isSelected = selectedAnswer == option;


                Color buttonColor;
                if (selectedAnswer != null) {
                  if (isCorrect) {
                    buttonColor = Colors.green; 
                  } else if (isSelected) {
                    buttonColor = Colors.red; 
                  } else {
                    buttonColor = Colors.grey[300]!; 
                  }
                } else {
                  buttonColor = const Color.fromARGB(255, 233, 241, 248); 
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: selectedAnswer == null
                        ? () => checkAnswer(option)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    child: Text(option),
                  ).animate().scale(duration: 300.ms),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Skor: $score", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}