# 透明UI - カメラ背景ログインアプリ

**SwiftUIで実装された革新的な透明カメラUIログインシステム**

![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%2014.0+-lightgrey.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

---

## 概要

リアルタイムカメラプレビューを背景に使用した、独創的な透明UIログイン画面アプリケーションです。ぼかし効果を加えたカメラ映像がUI要素の背景として表示され、モダンで洗練されたユーザー体験を提供します。

SwiftUIとAVFoundationを組み合わせることで、従来にない視覚的に魅力的なログインインターフェースを実現しています。

---

## 主な機能

* **リアルタイムカメラプレビュー** - 背景に端末のカメラ映像を表示
* **ぼかし効果** - カメラ映像に美しいブラー効果を適用
* **透明UI要素** - テキストやボタンが透明で、背景のカメラ映像が透けて見える
* **マスク技術** - SwiftUIのマスク機能を使用した高度なレイアウト
* **カメラ権限管理** - AVFoundationによる適切な権限処理
* **レスポンシブデザイン** - 様々な画面サイズに対応

---

## 技術仕様

| 項目 | 詳細 |
|------|------|
| 言語 | Swift 5.0以上 |
| フレームワーク | SwiftUI, AVFoundation, Combine |
| 最小対応OS | iOS 14.0以上 |
| カメラ | AVCaptureSession使用 |
| アーキテクチャ | MVVM (StateObject使用) |
| UI技術 | マスク、ぼかし効果、ZStack |

---

## システム要件

* **Xcode**: 12.0以上
* **iOS**: 14.0以上
* **デバイス**: カメラ搭載のiPhone/iPad（シミュレーターではカメラプレビューは表示されません）
* **権限**: カメラアクセス許可が必要

---

## インストール

### Xcodeプロジェクトとして実行

1. リポジトリをクローン:

```bash
git clone [your-repository-url]
cd 透明UI
```

2. Xcodeでプロジェクトを開く:

```bash
open 透明UI.xcodeproj
```

3. 実機を接続してビルド＆実行

---

## 使用方法

### 初回起動時

1. アプリを起動すると、カメラへのアクセス許可を求められます
2. 「許可」をタップしてカメラアクセスを承認
3. カメラプレビューが背景に表示されます

### ログイン画面の操作

* **アカウント名入力**: 上部のテキストフィールドにユーザー名を入力
* **パスワード入力**: 下部のセキュアフィールドにパスワードを入力
* **ログインボタン**: LOGINボタンをタップしてログイン
* **ソーシャルログイン**: 画面下部の4つのアイコンから選択可能

---

## コードの仕組み

### アーキテクチャ

```
ContentView (メインビュー)
    |
    ├── CameraManager (カメラ管理)
    |       └── AVCaptureSession
    |
    ├── CameraPreview (カメラ表示)
    |       └── AVCaptureVideoPreviewLayer
    |
    └── UI要素
            ├── TransparentTextField
            └── TransparentSecureField
```

### レイヤー構造

1. **背景レイヤー**: 完全な黒色
2. **カメラプレビューレイヤー**: ぼかし効果付きカメラ映像（マスクで制限）
3. **UIレイヤー**: 透明なテキストフィールドとボタン

### 主要コンポーネント

#### CameraManager

```swift
class CameraManager: NSObject, ObservableObject {
    @Published var session = AVCaptureSession()
    
    func checkPermission() { ... }
    private func setupCamera() { ... }
}
```

カメラセッションを管理し、権限チェックとセットアップを担当します。

#### TransparentTextField

```swift
struct TransparentTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    var body: some View { ... }
}
```

透明な背景のカスタムテキストフィールドコンポーネントです。

---

## カスタマイズ方法

### ぼかし効果の強度変更

```swift
CameraPreview(session: cameraManager.session)
    .blur(radius: 20)  // 数値を変更（0-100推奨）
```

### UI要素の色調整

```swift
.foregroundColor(.clear)  // 完全透明
.foregroundColor(.white.opacity(0.5))  // 半透明白
```

### カメラの位置変更

```swift
// CameraManagerのsetupCamera()内
guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, 
                                          for: .video, 
                                          position: .back),  // .front に変更でフロントカメラ
```

### グロー効果の調整

```swift
.shadow(color: .cyan.opacity(0.3), radius: 10, x: 0, y: 0)
// color: グローの色
// radius: グローの広がり
```

---

## 実装の詳細

### マスク技術の活用

このアプリの核心は、SwiftUIの`.mask()`モディファイアを使用して、カメラプレビューを特定のUI要素の形状に切り抜く技術です：

```swift
CameraPreview(session: cameraManager.session)
    .blur(radius: 20)
    .mask(
        // マスクとして使用するUI要素
        VStack { ... }
    )
```

### 二重レイヤー構造

1. **カメラレイヤー（マスク適用）**: UI要素の形状でカメラ映像を切り抜き
2. **透明UIレイヤー**: 実際に操作可能な透明なUI要素

これにより、UI要素の背景だけがカメラ映像になり、操作性を保ちながら視覚効果を実現しています。

---

## トラブルシューティング

### カメラが表示されない

**原因**: カメラ権限が許可されていない

**解決策**:
```
1. 設定アプリを開く
2. アプリ一覧から「透明UI」を選択
3. カメラをオンにする
4. アプリを再起動
```

### シミュレーターで動作しない

**原因**: シミュレーターにはカメラがありません

**解決策**: 実機でテストしてください

### ビルドエラーが発生する

**原因**: iOS バージョンまたはXcodeバージョンの不一致

**解決策**:
```swift
// プロジェクト設定でDeployment Targetを確認
iOS Deployment Target: 14.0以上
```

### カメラプレビューが遅延する

**原因**: セッションプリセットが高すぎる

**解決策**:
```swift
session.sessionPreset = .medium  // .highから.mediumに変更
```

---

## パフォーマンス最適化

### カメラセッションの最適化

```swift
// バックグラウンドスレッドでセッション開始
DispatchQueue.global(qos: .userInitiated).async {
    self.session.startRunning()
}
```

### メモリ管理

```swift
// weak self を使用してメモリリークを防止
AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
    // ...
}
```

---

## 応用例

このテクニックは様々な用途に応用できます：

* **ARフィルターアプリ**: カメラ映像にリアルタイムエフェクト
* **仮想試着アプリ**: 商品プレビューの背景として
* **クリエイティブエディター**: 独自のUIデザイン
* **セキュリティアプリ**: 生体認証と組み合わせたログイン
* **教育アプリ**: 拡張現実を使った学習体験

---

## Info.plist設定

カメラを使用するため、以下のプライバシー設定が必要です：

```xml
<key>NSCameraUsageDescription</key>
<string>ログイン画面の背景にカメラプレビューを表示するために使用します</string>
```

Xcodeの場合:
```
1. Info.plistを開く
2. 「+」ボタンをクリック
3. "Privacy - Camera Usage Description"を選択
4. 使用目的を日本語で記述
```

---

## セキュリティに関する注意事項

このアプリはデモンストレーション用です。実際のプロダクションで使用する場合：

* **通信の暗号化**: HTTPSを使用してログイン情報を送信
* **認証トークン**: JWTなど安全な認証方式を実装
* **入力検証**: SQL インジェクション等の対策を実施
* **カメラ映像の保存禁止**: プライバシー保護のため映像は保存しない
* **生体認証の追加**: Face ID/Touch IDの統合を検討

---

## ライセンス

MITライセンスの下で公開されています。

```
MIT License

Copyright (c) 2025 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 貢献

プルリクエストを歓迎します。大きな変更の場合は、まずissueを開いて変更内容を議論してください。

1. プロジェクトをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/AmazingFeature`)
3. 変更をコミット (`git commit -m 'Add some AmazingFeature'`)
4. ブランチにプッシュ (`git push origin feature/AmazingFeature`)
5. プルリクエストを作成

---

## 参考資料

* [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
* [AVFoundation Programming Guide](https://developer.apple.com/av-foundation/)
* [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
* [Swift.org](https://swift.org/)

---

## 作者

**JP-WHack** - 初期作成 - 2025/12/18

---

## 謝辞

* SwiftUIコミュニティの皆様
* Apple Developer Forums
* Stack Overflowの貢献者の方々

---

## バージョン履歴

* **1.0.0** (2025-12-18)
    * 初回リリース
    * カメラプレビュー背景機能
    * 透明UI要素実装
    * ログイン画面デザイン完成

---

*SwiftUIで創る、次世代のUIエクスペリエンス*
