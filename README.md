# 🌍 WORLD QUEST 🚩

<div align="center">
  
  ![World Quest Banner](assets/images/app_logo.png)
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)
  [![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](LICENSE)
  [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](http://makeapullrequest.com)
  
  ### 🧠 Dünya bayraklarını öğrenmenin en eğlenceli yolu! 🎯
  ### 190+ ülke | 3 Oyun Modu | Çoklu Kategori

</div>

## ✨ Neden World Quest?

> *"Coğrafyayı bilmek, tarihimizi, kültürümüzü ve dünyayı anlamaktır."*

**World Quest**, dünya bayraklarını tanıma ve öğrenme becerinizi geliştirmenizi sağlayan, hem eğlenceli hem de eğitici bir Flutter mobil uygulamasıdır. Farklı oyun modları, kıtasal kategoriler ve zorluk seviyeleri ile 190'dan fazla ülke bayrağını keşfedin!

<div align="center">
  <table>
    <tr>
      <td align="center"><b>🎮 Eğlencelidir</b></td>
      <td align="center"><b>🧠 Öğreticidir</b></td>
      <td align="center"><b>🚀 Hızlıdır</b></td>
      <td align="center"><b>🔄 Çeşitlidir</b></td>
    </tr>
    <tr>
      <td align="center">Rekabet et, puanları karşılaştır</td>
      <td align="center">190+ ülke bayrağı hakkında bilgi edin</td>
      <td align="center">Hızlı oyun deneyimi</td>
      <td align="center">Farklı mod ve kategoriler</td>
    </tr>
  </table>
</div>

## 🎮 Oyun Modları

<table>
  <tr>
    <td width="33%" align="center">
      <img src="assets/images/classic_mode.png" alt="Klasik Mod" width="80"/><br/>
      <b>🔵 Klasik Mod</b><br/>
      <small>10 soruda ne kadar doğru cevap verebilirsin? Her soru için süren var!</small>
    </td>
    <td width="33%" align="center">
      <img src="assets/images/time_mode.png" alt="Zaman Yarışı" width="80"/><br/>
      <b>⏱️ Zaman Yarışı</b><br/>
      <small>60 saniye içinde kaç bayrağı doğru tahmin edebilirsin? Zamanla yarış!</small>
    </td>
    <td width="33%" align="center">
      <img src="assets/images/streak_mode.png" alt="Yarışma Modu" width="80"/><br/>
      <b>🏆 Yarışma Modu</b><br/>
      <small>Sadece 3 yanlış hakkın var! Ne kadar ilerleyebilirsin?</small>
    </td>
  </tr>
</table>

## 🌎 Kategori Sistemi

### Kıtalara Göre Keşfet
Farklı kıtaların bayraklarını öğren ve test et:

<div align="center">
  <code>🇪🇺 Avrupa</code> • 
  <code>🇦🇸 Asya</code> • 
  <code>🇺🇸 Amerika</code> • 
  <code>🇿🇦 Afrika</code> • 
  <code>🇦🇺 Avustralya ve Pasifik</code> • 
  <code>🌍 Tümü</code>
</div>

### Zorluğu Seç
Kendi seviyene göre oyna:

<div align="center">
  <span style="color:green">⭐ Kolay</span> • 
  <span style="color:orange">⭐⭐ Orta</span> • 
  <span style="color:red">⭐⭐⭐ Zor</span> • 
  <span style="color:purple">🌟 Uzman</span>
</div>

## 📸 Ekran Görüntüleri

<div align="center">
  <img src="screenshots/home_screen.png" alt="Ana Ekran" width="19%"/>
  <img src="screenshots/category_selection.png" alt="Kategori Seçimi" width="19%"/>
  <img src="screenshots/difficulty_selection.png" alt="Zorluk Seçimi" width="19%"/>
  <img src="screenshots/gameplay.png" alt="Oyun Ekranı" width="19%"/>
  <img src="screenshots/results.png" alt="Sonuç Ekranı" width="19%"/>
</div>

## 🌟 Özellikler

<table>
  <tr>
    <td>
      <h3>📊 Temel Özellikler</h3>
      <ul>
        <li>✅ Modern, canlı ve etkileşimli arayüz</li>
        <li>✅ Akıcı animasyonlar ve geçişler</li>
        <li>✅ Sezgisel bayrak tanıma oyunu</li>
        <li>✅ Zamanlayıcı ve puan göstergeleri</li>
        <li>✅ 190+ ülke bayrağı</li>
      </ul>
    </td>
    <td>
      <h3>🚀 Gelişmiş Özellikler</h3>
      <ul>
        <li>✅ Skor tablosu ve liderlik sıralaması</li>
        <li>✅ Firebase ile çevrimiçi veri saklama</li>
        <li>✅ Ayarlanabilir ses efektleri</li>
        <li>✅ Detaylı "Nasıl Oynanır" rehberi</li>
        <li>✅ Bayraklar hakkında bilgiler</li>
      </ul>
    </td>
  </tr>
</table>

## 🛠️ Teknik Detaylar

<div align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey?style=flat-square"/>
  <img src="https://img.shields.io/badge/Languages-Dart-blue?style=flat-square"/>
  <img src="https://img.shields.io/badge/Database-Firebase-orange?style=flat-square"/>
</div>

World Quest, modern Flutter geliştirme prensipleri ve mimarisi kullanılarak geliştirilmiştir:

```mermaid
graph TD
    A[main.dart] --> B[core]
    A --> C[data]
    A --> D[domain]
    A --> E[presentation]
    A --> F[services]
    B --> B1[constants]
    C --> C1[models]
    D --> D1[entities]
    E --> E1[pages]
    E --> E2[widgets]
    F --> F1[firestore_services.dart]
```

### 💻 Kullanılan Teknolojiler

- **Flutter**: Modern ve duyarlı kullanıcı arayüzü geliştirme
- **Firebase Firestore**: Kullanıcı skorlarını ve istatistiklerini saklamak için
- **flutter_animate**: Zengin animasyonlar ve geçişler için
- **Provider/Bloc**: Etkili durum yönetimi

## 🚀 Başlangıç

### Gereksinimler

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 2.18.0)
- Firebase hesabı (skor tablosu için)
- Android Studio / VS Code

### ⚡ Hızlı Kurulum

```bash
# 1. Repo'yu klonlayın
git clone https://github.com/yourusername/flagquizgame.git

# 2. Proje dizinine gidin
cd flagquizgame

# 3. Bağımlılıkları yükleyin
flutter pub get

# 4. Uygulamayı çalıştırın
flutter run
```

## 🔥 Firebase Kurulumu

<details>
<summary><b>Firebase entegrasyonu için adımlar</b> (tıklayın)</summary>
<br>

1. [Firebase Console](https://console.firebase.google.com/)'da yeni bir proje oluşturun
2. Flutter uygulamanızı Firebase'e ekleyin:
   ```bash
   flutterfire configure
   ```
3. Firestore veritabanını etkinleştirin
4. Authentication ayarlarını yapılandırın
5. Firebase yapılandırma dosyalarını projenize ekleyin

</details>

## 📋 Gelecek Özellikler

<table>
  <tr>
    <td>
      <img src="https://progress-bar.dev/0/" alt="Progress 0%"> Çoklu dil desteği
    </td>
    <td>
      <img src="https://progress-bar.dev/20/" alt="Progress 20%"> Karanlık mod
    </td>
  </tr>
  <tr>
    <td>
      <img src="https://progress-bar.dev/10/" alt="Progress 10%"> Kullanıcı profilleri
    </td>
    <td>
      <img src="https://progress-bar.dev/50/" alt="Progress 50%"> Daha fazla bayrak
    </td>
  </tr>
  <tr>
    <td>
      <img src="https://progress-bar.dev/30/" alt="Progress 30%"> Arkadaşlarla rekabet
    </td>
    <td>
      <img src="https://progress-bar.dev/70/" alt="Progress 70%"> Performans iyileştirmeleri
    </td>
  </tr>
</table>

## 🤝 Katkıda Bulunma

Katkılarınız her zaman memnuniyetle karşılanır! Lütfen katkıda bulunmadan önce [katkıda bulunma kılavuzumuzu](CONTRIBUTING.md) okuyun.

<details>
<summary><b>Katkıda bulunma adımları</b> (tıklayın)</summary>
<br>

1. Bu repo'yu fork edin
2. Yeni bir özellik branch'i oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Add some amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

</details>

## 📜 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır. Daha fazla bilgi için [LICENSE](LICENSE) dosyasına bakın.

---

<div align="center">
  
  <h3>🚩 WORLD QUEST 🚩</h3>
  
  <p>Dünyanın tüm bayraklarını öğrenirken eğlenin!</p>
  
  <p>
    <a href="mailto:info@worldquest.com">İletişim</a>
    •
    <a href="https://github.com/yourusername/flagquizgame/issues">Hata Bildir</a>
    •
    <a href="https://github.com/yourusername/flagquizgame/issues">Özellik İste</a>
  </p>
  
  <p>❤️ ile yapılmıştır - 2025</p>
  
</div>
