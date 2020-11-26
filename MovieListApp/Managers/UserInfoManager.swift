//
//  UserInfoManager.swift
//  MovieListApp
//
//  Created by daniel.avram on 24/11/2020.
//

import Foundation

struct UserInfo {
    let watchlistMoviesIds: [String]
}

protocol UserInfoReader {
    var userInfo: UserInfo { get }
}

protocol UserInfoWritter {
    func storeUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void)
    func updateUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void)
    func deleteUserInfo(completion: @escaping (Error?) -> Void)
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
        return UserInfo(watchlistMoviesIds: ids)
    }

    func storeUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        defaults.setValue(userInfo.watchlistMoviesIds, forKey: "watchlistMoviesIds")
        completion(.success(UserInfo(watchlistMoviesIds: userInfo.watchlistMoviesIds)))
    }

    func updateUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        let oldValues = self.userInfo.watchlistMoviesIds
        let newValues = userInfo.watchlistMoviesIds
        let deduplicated = Array(Set(oldValues).union(Set(newValues)))
        storeUserInfo(
            UserInfo(watchlistMoviesIds: deduplicated),
            completion: completion
        )
    }

    func deleteUserInfo(completion: @escaping (Error?) -> Void) {
        storeUserInfo(
            UserInfo(watchlistMoviesIds: []),
            completion: { result in
                switch result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        )
    }

}
