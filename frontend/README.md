# tripflutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

flutter pub run build_runner build --delete-conflicting-outputs
flutter run --web-renderer html
flutter run -d chrome --web-renderer html
flutter build web --release --web-renderer html

https://stackoverflow.com/questions/65653801/flutter-web-cant-load-network-image-from-another-domain

//流程
1. 非會員
   報名活動->加入會員->閱讀條款->填寫會員資料->收驗證信->驗證email->填寫付款資料->報名成功
   加入會員->閱讀條款->填寫會員資料->收驗證信->驗證email->首頁-登入狀態? (->瀏覽活動->報名活動->填寫付款資料->報名成功)
2. 會員
   報名活動->登入會員->填寫付款資料->報名成功
   登入會員->報名活動->填寫付款資料->報名成功