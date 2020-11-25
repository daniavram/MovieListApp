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
    func fetchUserInfo(completion: @escaping (Result<UserInfo, Error>) -> Void)
}

protocol UserInfoWritter {
    func storeUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void)
}

class LocalUserInfoManager: UserInfoReader, UserInfoWritter {

    enum LocalUserInfoManagerError: Error {
        case missingMoviesIds
    }

    let defaults: UserDefaults

    init(
        defaults: UserDefaults = .standard
    ) {
        self.defaults = defaults
    }

    func fetchUserInfo(completion: @escaping (Result<UserInfo, Error>) -> Void) {
        if let ids = defaults.object(forKey: "watchlistMoviesIds") as? [UUID] {
            completion(.success(UserInfo(watchlistMoviesIds: ids)))
        } else {
            completion(.failure(LocalUserInfoManagerError.missingMoviesIds))
        }
    }

    func storeUserInfo(_ userInfo: UserInfo, completion: @escaping (Result<UserInfo, Error>) -> Void) {
        fetchUserInfo { result in
            let initialIds: [UUID] = {
                switch result {
                case .success(let oldValue):
                    return oldValue.watchlistMoviesIds
                case .failure:
                    return []
                }
            }()
            let newIds = Array(Set(initialIds + userInfo.watchlistMoviesIds))
            self.defaults.setValue(newIds, forKey: "watchlistMoviesIds")
            completion(.success(UserInfo(watchlistMoviesIds: newIds)))
        }
    }

}
