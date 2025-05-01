import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Uygulamada kullanılan tüm animasyonları içeren yardımcı sınıf.
class AppAnimations {
  /// Sayfa geçişleri için kullanılan animasyon.
  /// Varsayılan olarak sağdan sola doğru kaydırır.
  static PageRouteBuilder pageTransition(Widget page, {Offset? beginOffset}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
  
  /// Eleman için fade in animasyonu oluşturur.
  static Widget fadeIn(Widget child, {Duration? duration}) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: duration ?? const Duration(milliseconds: 500),
      child: child,
    );
  }
  
  /// Eleman için scale (büyütme/küçültme) animasyonu oluşturur.
  static Widget scale(Widget child, {Duration? duration, double? begin, double? end}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: begin ?? 0.8, end: end ?? 1.0),
      duration: duration ?? const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
  
  /// Eleman için bounce (sıçrama) animasyonu oluşturur.
  static Widget bounce(Widget child, {Duration? duration}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration ?? const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
  
  // Bayrak kartları için kart flip animasyonu
  static Animation<double> createFlipAnimation(AnimationController controller) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );
  }
  
  // Seçenek butonları için animasyonlar
  static List<Effect> getButtonEffects({required int index}) {
    return [
      SlideEffect(
        begin: const Offset(0, 30),
        end: const Offset(0, 0),
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: 300 + (index * 100)),
        curve: Curves.easeOutQuart,
      ),
      FadeEffect(
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: 300 + (index * 100)),
      ),
    ];
  }
  
  // Puan animasyonları
  static List<Effect> getScoreEffects() {
    return [
      ScaleEffect(
        begin: const Offset(0.0, 0.0),
        end: const Offset(1.2, 1.2),
        duration: const Duration(milliseconds: 300),
      ),
      ScaleEffect(
        begin: const Offset(1.2, 1.2),
        end: const Offset(1.0, 1.0),
        duration: const Duration(milliseconds: 200),
      ),
    ];
  }
}