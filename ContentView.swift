//
//  ContentView.swift
//
//

import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            // 背景は完全に黒
            Color.black.ignoresSafeArea()
            
            // 1) カメラプレビュー（モザイク）をマスクで制限
            ZStack {
                CameraPreview(session: cameraManager.session)
                    .blur(radius: 20)
                    .ignoresSafeArea()
            }
            .mask(
                // すべてのUI要素にカメラ背景を適用するマスク
                VStack(spacing: 30) {
                    Spacer()
                    
                    // タイトルエリア（カメラ表示）
                    VStack(spacing: 8) {
                        Text("Hello World!")
                            .font(.system(size: 48, weight: .heavy))
                            .foregroundColor(.white)
                        
                        VStack(spacing: 4) {
                            Text("Create your own world.")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                            Text("Just swipe one be flawless")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 60)
                    
                    // ユーザー名フィールドエリア（カメラ表示）
                    HStack(spacing: 18) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 24)
                        Text("Please enter your account name")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 60)
                    .frame(height: 60)
                    
                    // パスワードフィールドエリア（カメラ表示）
                    HStack(spacing: 18) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 24)
                        Text("Please enter your password")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 60)
                    .frame(height: 60)
                    
                    // ログインボタンエリア（カメラ表示）
                    HStack {
                        Text("LOGIN")
                            .font(.system(size: 22, weight: .heavy))
                            .foregroundColor(.white)
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    
                    // パスワードを忘れた場合エリア（カメラ表示）
                    Text("Would you like to log in using another method?")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                    
                    Spacer()
                    
                    // ソーシャルボタンエリア（カメラ表示）
                    HStack(spacing: 30) {
                        Image(systemName: "play.rectangle.fill")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                        Image(systemName: "message.fill")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                        Image(systemName: "xmark")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                        Text("G")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                    }
                    .padding(.bottom, 40)
                }
            )
            
            // 2) UI要素（テキストとボタン）
            VStack(spacing: 30) {
                Spacer()
                
                // タイトル - 透明カメラ背景
                VStack(spacing: 8) {
                    Text("Hello World!")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundColor(.clear)
                        .shadow(color: .cyan.opacity(0.3), radius: 10, x: 0, y: 0)
                    
                    VStack(spacing: 4) {
                        Text("Create your own world.")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.clear)
                        Text("Just swipe one be flawless")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.clear)
                    }
                }
                .padding(.bottom, 60)
                
                // ユーザー名フィールド
                TransparentTextField(
                    placeholder: "Please enter your account name",
                    text: $username,
                    icon: "person.fill"
                )
                .frame(height: 60)
                .padding(.horizontal, 40)
                
                // パスワードフィールド
                TransparentSecureField(
                    placeholder: "Please enter your password",
                    text: $password,
                    icon: "lock.fill"
                )
                .frame(height: 60)
                .padding(.horizontal, 40)
                
                // ログインボタン
                Button(action: {
                    // ログイン処理
                }) {
                    Text("LOGIN")
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.white.opacity(0.3), lineWidth: 2)
                        )
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                // パスワードを忘れた場合 - 透明カメラ背景
                Button(action: {}) {
                    Text("Would you like to log in using another method?")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.clear)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                
                Spacer()
                
                // ソーシャルログインボタン
                HStack(spacing: 30) {
                    // YouTube
                    Button(action: {}) {
                        Image(systemName: "play.rectangle.fill")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.clear)
                    }
                    
                    // LINE
                    Button(action: {}) {
                        Image(systemName: "message.fill")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.clear)
                    }
                    
                    // X (Twitter)
                    Button(action: {}) {
                        Image(systemName: "xmark")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.clear)
                    }
                    
                    // Google
                    Button(action: {}) {
                        Text("G")
                            .font(.system(size: 36, weight: .heavy))
                            .foregroundColor(.clear)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            cameraManager.checkPermission()
        }
    }
}

// 透明テキストフィールド
struct TransparentTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.clear)
                .frame(width: 24)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.clear)
                }
                
                TextField("", text: $text)
                    .foregroundColor(.clear)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.3), lineWidth: 2)
        )
    }
}

// 透明パスワードフィールド
struct TransparentSecureField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 18) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.clear)
                .frame(width: 24)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.clear)
                }
                
                SecureField("", text: $text)
                    .foregroundColor(.clear)
                    .font(.system(size: 16, weight: .bold))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.3), lineWidth: 2)
        )
    }
}

// カメラマネージャー
class CameraManager: NSObject, ObservableObject {
    @Published var session = AVCaptureSession()
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.setupCamera()
                    }
                }
            }
        default:
            break
        }
    }
    
    private func setupCamera() {
        session.beginConfiguration()
        session.sessionPreset = .high
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        session.commitConfiguration()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.startRunning()
        }
    }
}

// カメラプレビュー
struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        context.coordinator.previewLayer = previewLayer
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            context.coordinator.previewLayer?.frame = uiView.bounds
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var previewLayer: AVCaptureVideoPreviewLayer?
    }
}

#Preview {
    ContentView()
}
