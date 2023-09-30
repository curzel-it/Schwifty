import AVFoundation

public extension AVAsset {
    func firstTrack(withMediaType mediaType: AVMediaType) async throws -> AVAssetTrack {
        if #available(macOS 12.0, *) {
            let tracks = try await loadTracks(withMediaType: mediaType)
            return try tracks.first.unwrap()
        } else {
            return try tracks(withMediaType: mediaType).first.unwrap()
        }
    }
    
    func durationInSeconds() async throws -> TimeInterval {
        if #available(macOS 12, *) {
            let duration = try await load(.duration)
            return duration.seconds
        } else {
            return duration.seconds
        }
    }
}

public extension AVAssetTrack {
    @available(macOS 12, *)
    func cmAudioFormatDescription() async throws -> CMAudioFormatDescription {
        let formatDescriptions = try await load(.formatDescriptions)
        return try formatDescriptions.first.unwrap()
    }
}
