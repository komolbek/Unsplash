//
//  Created by Kamol Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

typealias HasServices = HasPhotoService & HasAuthService

private typealias HasPersistentServices = Any

// MARK: -  Singleton Services

private final class PersistentServiceContainer: HasPersistentServices {

    static var instance: PersistentServiceContainer = .init()
    
    private init() {}
    
    /// Lazy service instances with dependencies from regular service container
    ///
    /// lazy var sessionService: SessionServiceProtocol = {
    ///     return SessionService(keychainService: ServiceContainer().keychainService)
    /// }()
}

// MARK: -  Regular Services

final class ServiceContainer: HasServices {
    
    var photoService: PhotoServiceProtocol {
        return PhotoService()
    }
    
    var authService: AuthServiceProtocol {
        return AuthService()
    }
    
    /// lazy var keychainService: KeychainServiceProtocol = {
    ///     return KeychainService()
    /// }()
    
    /// var sessionService: SessionServiceProtocol {
    ///     return PersistentServiceContainer.instance.sessionService
    /// }
}
