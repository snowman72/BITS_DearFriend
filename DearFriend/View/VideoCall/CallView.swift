//
//  CallView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 14/9/24.
//

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

struct CallView: View {
    @ObservedObject var viewModel = CallViewModel()
    
    private var client: StreamVideo

    private let apiKey: String = "mmhfdzb5evj2"
    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL1dlZGdlX0FudGlsbGVzIiwidXNlcl9pZCI6IldlZGdlX0FudGlsbGVzIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3MjY0NzQxMjMsImV4cCI6MTcyNzA3ODkyM30.wdNjLnBw2Yl-gza8N1YRbNcbawg9Gw-_9mB_3oVL7CY"
    private let userId: String = "Team_11"
    private let callId: String = "EQzXI7TXoTT4"

    init() {
        let user = User(
            id: userId,
            name: "Team_11", // name and imageURL are used in the UI
            imageURL: .init(string: "data:image/jpeg;base64,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")
        )

        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: user,
            token: .init(stringLiteral: token)
        )

        self.viewModel = .init()
    }
    
    var body: some View {
        VStack {
            VStack {
                if viewModel.call != nil {
                    CallContainer(viewFactory: DefaultViewFactory.shared, viewModel: viewModel)
                } else {
                    Text("Loading, please wait...")
                }
            }.onAppear {
                Task {
                    guard viewModel.call == nil else { return }
                    viewModel.joinCall(callType: .default, callId: callId)
                }
            }
        }
        .navigationTitle("Video Call")
    }
}
