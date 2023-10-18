import Foundation

struct ApiConstants {
    
    // Local server path
    static let serverPath = "http://localhost:3000/"
    
    // Users
    static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
    
    // Photos
    static let photosPath = serverPath + "photos"
    static let photosURL = URL(string: photosPath)
    
    // Posts
    static let postsPath = serverPath + "posts"
    static let postsURL = URL(string: postsPath)
    
    // Albums
    static let albumsPath = serverPath + "alboms"
    static let albumsURL = URL(string: albumsPath)
    
    // ToDo
    static let todosPath = serverPath + "todos"
    static let todosURL = URL(string: todosPath)
    
}
