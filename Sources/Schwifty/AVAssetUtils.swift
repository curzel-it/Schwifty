import AVFoundation

public extension AVAsset {
    func firstTrack(withMediaType mediaType: AVMediaType) async throws -> AVAssetTrack {
        let tracks = try await loadTracks(withMediaType: mediaType)
        return try tracks.first.unwrap()
    }
    
    func durationInSeconds() async throws -> TimeInterval {
        let duration = try await load(.duration)
        return duration.seconds
    }
}

public extension AVAssetTrack {
    func cmAudioFormatDescription() async throws -> CMAudioFormatDescription {
        let formatDescriptions = try await load(.formatDescriptions)
        return try formatDescriptions.first.unwrap()
    }
}
