//
//  FloatingParticipantView.swift
//  DearFriend
//
//  Created by Vũ Minh Hà on 14/9/24.
//

import SwiftUI
import StreamVideoSwiftUI
import StreamVideo

struct FloatingParticipantView: View {
    var participant: CallParticipant?
    var size: CGSize = .init(width: 120, height: 120)

    var body: some View {
        if let participant = participant {
            VStack {
                HStack {
                    Spacer()
                    VideoRendererView(id: participant.id, size: size) { videoRenderer in
                        videoRenderer.handleViewRendering(for: participant, onTrackSizeUpdate: { _, _ in })
                    }
                    .frame(width: size.width, height: size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    FloatingParticipantView()
}
