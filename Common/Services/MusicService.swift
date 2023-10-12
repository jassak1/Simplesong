//
//  MusicService.swift
//  Simplesong
//
//  Created by Adam Jassak on 16/07/2023.
//

import Foundation
import MusicKit

/// Music Service Protocol defining base functionality
protocol MusicServiceProto {
    /// Current `MusicAuthorization` status
    var authStatus: MusicAuthorization.Status { get }

    /// Method responsible for displaying system default Media permission request alert
    func requestAuthorization()

    /// Method responsible for retrieving Songs from local library, sorted by the starting with most recent ones
    ///
    ///  - Parameters:
    ///     - downloadedOnly: `Bool` flag indicating whether to include downloaded songs only
    ///
    ///  - Returns: `Song` as a request's response
    func getLocalLibrarySongs(downloadedOnly: Bool) async throws -> MusicLibraryResponse<Song>

    /// Method reponsible for retrievig index of the current played Song from Local library
    ///
    ///  - Parameters:
    ///     - downloadedOnly: `Bool` flag indicating whether to search through downloaded songs only
    ///
    ///  - Returns: Integer with position of song in Local library
    func getCurrentSongIndex(downloadedOnly: Bool) async -> Int

    /// Method responsible for retrieving recently played Songs
    ///
    ///  - Returns: `Song` as a request's response
    func getRecentlyPlayedSongs() async throws -> MusicRecentlyPlayedResponse<Song>

    /// Method responsible for appending songs into current queue, when it's empty
    func prepareSystemMusicQueue() async throws
}

/// MusicService - Service responsible for actions related to Apple Music
struct MusicService: MusicServiceProto {
    private var authorization = MusicAuthorization.self
    
    var authStatus: MusicAuthorization.Status {
        get { authorization.currentStatus }
    }
    
    func requestAuthorization() {
        Task {
            _ = await authorization.request()
        }
    }
    
    func getLocalLibrarySongs(downloadedOnly: Bool = false) async throws -> MusicLibraryResponse<Song> {
        var request = MusicLibraryRequest<Song>()
        request.sort(by: \.libraryAddedDate, ascending: false)
        request.includeOnlyDownloadedContent = downloadedOnly
        
        return try await request.response()
    }
    
    func getCurrentSongIndex(downloadedOnly: Bool = false) async -> Int {
        let allSongs = try? await MusicService().getLocalLibrarySongs(downloadedOnly: downloadedOnly).items
        let currentSong = SystemMusicPlayer.shared.queue.currentEntry?.title ?? ""
        let oneSong = allSongs?.first(where: {
            $0.title == currentSong
        })
        
        if let oneSong {
            return Int(allSongs?.firstIndex(of: oneSong) ?? 0)
        } else {
            return 0
        }
    }
    
    func getRecentlyPlayedSongs() async throws -> MusicRecentlyPlayedResponse<Song> {
        let request = MusicRecentlyPlayedRequest<Song>()
        let response = try await request.response()
        return response
    }
    
    func prepareSystemMusicQueue() async throws {
        let allSongs = try await getLocalLibrarySongs().items
        let allIndices = allSongs.indices
        if allIndices.contains(15) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[10],
                                              allSongs[11],
                                              allSongs[12],
                                              allSongs[13],
                                              allSongs[14],
                                              allSongs[15]]
        } else if allIndices.contains(14) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[10],
                                              allSongs[11],
                                              allSongs[12],
                                              allSongs[14]]
        } else if allIndices.contains(13) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[10],
                                              allSongs[11],
                                              allSongs[12],
                                              allSongs[13]]
        } else if allIndices.contains(12) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[10],
                                              allSongs[11],
                                              allSongs[12]]
        } else if allIndices.contains(11) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[10],
                                              allSongs[11]]
        } else if allIndices.contains(10) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[10]]
        } else if allIndices.contains(9) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8],
                                              allSongs[9]]
        } else if allIndices.contains(8) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7],
                                              allSongs[8]]
        } else if allIndices.contains(7) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6],
                                              allSongs[7]]
        } else if allIndices.contains(6) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5],
                                              allSongs[6]]
        } else if allIndices.contains(5) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4],
                                              allSongs[5]]
        } else if allIndices.contains(4) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3],
                                              allSongs[4]]
        } else if allIndices.contains(3) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2],
                                              allSongs[3]]
        } else if allIndices.contains(2) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1],
                                              allSongs[2]]
        } else if allIndices.contains(1) {
            SystemMusicPlayer.shared.queue = [allSongs[0],
                                              allSongs[1]]
        } else if allIndices.contains(0) {
            SystemMusicPlayer.shared.queue = [allSongs[0]]
        }
    }
}
