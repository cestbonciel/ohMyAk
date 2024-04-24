//
//  ShazamView.swift
//  SoundLog
//
//  Created by Seohyun Kim on 2023/11/08.
//
import Combine
import SwiftUI

struct ShazamView: View {
	@State private var shouldShowAnimationView = false
	@State private var shouldShowRecordButton = false
	@State private var shouldShowInfoAlert = false
	@State private var shouldShowRecordPermissionAlert = false
	@State private var shouldShowNoResultView = false
	@State private var foundSong: SongData!
	@State private var cancellables: Set<AnyCancellable> = []
	@EnvironmentObject private var shazamViewModel: ShazamViewModel
	
	@State var isAnimating: Bool = false
	
	
	
	 var body: some View {
		 ZStack {
			 Color.init(.pastelSkyblue)
			 
			 ZStack {
				 
				 VStack(spacing: 20) {
					 if shouldShowAnimationView {
						 RippleView(
							style: .solid,
							rippleCount: 5,
							tintColor: Color.init(uiColor: .neonPurple),
							timeIntervalBetweenRipples: 0.18
						 )
						 .padding(.horizontal, 48)
					 }
					 
					 if shouldShowNoResultView {
						 NoResultView {
							 onRecordButtonTapped()
						 }
					 }
					 
					 if shouldShowRecordButton {
						 recordButton
							 .alert(isPresented: $shouldShowRecordPermissionAlert, content: {
								 permissionAlert
							 })
					 }
					 
					 if foundSong != nil {
						 VStack {
							 SongDetail(song: foundSong)
								 .animation(.easeInOut, value: isAnimating)
							 Spacer(minLength: 32)
							 recordButton
						 }
                         .padding(.vertical, 48)
						 //.padding(.vertical, 64)
					 }
					 
					 
				 }
				 VStack {
					 HStack {
						 Spacer()
						 infoButton
							 .alert(isPresented: $shouldShowInfoAlert, content: {
								 infoAlert
							 })
					 }
                     .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32))
					 //.padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 32))
					 
					 Spacer()
				 }
				 
			 }// : ZSTACK
             .padding(EdgeInsets(top: 16, leading: 0, bottom: 24, trailing: 0))
			 //.padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0))
             
		 }
		 .onAppear(perform: { bindViewModel() })
		 .onDisappear(perform: { shazamViewModel.stopListening() })
		 .ignoresSafeArea()
	 }
	
	private var infoAlert: Alert {
		 Alert(
			  title: Text("소리의기록 - Shazam 검색"),
			  message: Text("버튼을 누르고 주변 소음 외에 음악만 녹음해주세요."),
			  dismissButton: .default(Text("OK"))
		 )
	}

	private var permissionAlert: Alert {
		 Alert(
			  title: Text("마이크 사용 접근을 허용하지 않았습니다."),
			  message: Text("마이크를 켜고 주변음을 탐색하세요."),
			  primaryButton: .default(
					Text("설정으로 가기"),
					action: {
						 goToPermissionSettings()
					}
			  ),
			  secondaryButton: .cancel(Text("닫기"))
		 )
	}

	@ViewBuilder
	var infoButton: some View {
		 Button(action: {
			  shazamViewModel.showInfo()
		 }, label: {
			  Image(systemName: "info.circle")
					.resizable()
					.frame(width: 20, height: 20, alignment: .center)
					.scaledToFit()
					.foregroundColor(Color.black.opacity(0.7))
		 })
         .padding(.top, 24)

	}

	@ViewBuilder
	private var recordButton: some View {
		 Button(action: {
			  onRecordButtonTapped()
             //shazamViewModel.toggleShazam()
		 }, label: {
			  Image(systemName: "headphones.circle.fill")
					.font(.system(size: 48, weight: .bold))
					.foregroundColor(.white)
					.frame(width: 100, height: 100, alignment: .center)
					.background(
                        Circle().fill(Color.slneonPurple)
							  .shadow(radius: 1)
					)
		 })
         .padding(.bottom, 48)
	}


	private func bindViewModel() {
		 shazamViewModel.$viewState.sink { viewState in
			  switch viewState {
			  case .initial:
					shouldShowAnimationView = false
					shouldShowRecordButton = true
					shouldShowNoResultView = false
			  case .recordingInProgress:
					shouldShowRecordButton = false
				  shouldShowAnimationView = true
					shouldShowNoResultView = false
					foundSong = nil
			  case .infoAlert:
					shouldShowInfoAlert = true
			  case .recordPermissionSettingsAlert:
					shouldShowRecordPermissionAlert = true
			  case .noResult:
				  shouldShowAnimationView = false
					shouldShowNoResultView = true
					foundSong = nil
			  case .result(let song):
					withAnimation {
						 foundSong = song
					}
				  shouldShowAnimationView = false
			  }
		 }.store(in: &cancellables)
	}

	
	
	private func onRecordButtonTapped() {
		shazamViewModel.startListening()
	}
	
	private func goToPermissionSettings() {
		if let bundleID = Bundle.main.bundleIdentifier,
			let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleID)") {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		}
	}
	
	
	
}

struct ShazamView_Previews: PreviewProvider {
	 static var previews: some View {
		 ShazamView()
	 }
}

extension Color {
    static let slneonPurple = Color("soundLogPurple")
}
