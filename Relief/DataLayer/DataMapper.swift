//
//  DataMapper.swift
//  Relief
//
//  Created by Alejandro Botana on 6/3/22.
//
import Foundation

final class DataMapper{
    
    static let shared = DataMapper()
    private init() {}
    
    var login = "login"
    var lista = "lista"
    var recuperarPass = "recoverPassword"
    var profile = "profile"
    var register = "registerUser"

    func login(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connection(to: login, params: params, method: "POST") { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                        completion(response)
                } catch {
                    completion(nil)
                }
        }
    
    }
    
    func list(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connection(to: lista, params: params, method: "POST") { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                        completion(response)
                } catch {
                    completion(nil)
                }
        }
    
    }
    
    func recoverPass(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connection(to: recuperarPass, params: params, method: "POST") { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                        completion(response)
                } catch {
                    completion(nil)
                }
        }
    
    }
    
    func profile(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connection(to: profile, params: params, method: "POST") { data in
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                        completion(response)
                } catch {
                    completion(nil)
                }
        }
    }
    
    func register(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
            Connection().connection(to: register, params: params, method: "PUT") { data in
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self, from: data)
                            completion(response)
                    } catch {
                        completion(nil)
                    }
            }
    
    }
}
