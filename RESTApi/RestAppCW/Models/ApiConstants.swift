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
    
    // Alboms
    static let albomsPath = serverPath + "albums"
    static let albomsURL = URL(string: albomsPath)
    
    // ToDo
    static let todosPath = serverPath + "todos"
    static let todosURL = URL(string: todosPath)
   
    // Comments
    static let commentsPath = serverPath + "comments"
    static let commentsURL = URL(string: commentsPath)
}

