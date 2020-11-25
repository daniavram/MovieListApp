//
//  UserInfoManager.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import Foundation

struct UserInfo {
    let watchlistMoviesIds: [UUID]
}

protocol UserInfoReader {
    var userInfo: UserInfo { get }
}

protocol UserInfoWritter {
    func storeUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void)
}

typealias UserInfoManager = UserInfoReader & UserInfoWritter

class LocalUserInfoManager: UserInfoManager {

    enum LocalUserInfoManagerError: Error {
        case missingMoviesIds
    }

    let defaults: UserDefaults

    init(
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
    }

    var userInfo: UserInfo {
        let ids = defaults.object(forKey: "watchlistMoviesIds") as? [String] ?? []
        return UserInfo(watchlistMoviesIds: ids.compactMap { UUID(uuidString: $0) })
    }

    func storeUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        let newIds = userInfo.watchlistMoviesIds.map { $0.uuidString }
        defaults.setValue(newIds, forKey: "watchlistMoviesIds")
        completion(.success(UserInfo(watchlistMoviesIds: userInfo.watchlistMoviesIds)))
    }

}
