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
    var lista = "users/detailMassage"
    var recuperarPass = "users/recoverPassword"
    var profile = "profile"
    var register = "users/registerUser"
    var editProfile = "users/editProfile"
    var getTherapistInMap = "users/getTherapistInMap"
    var getTherapistForMassage = "users/getTherapistForMassage"
    var getServices = "users/getServices"


    

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
    func editProfile(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
            Connection().connection(to: editProfile, params: params, method: "POST") { data in
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
    func getTherapistInMap(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
            Connection().connection(to: getTherapistInMap, params: params, method: "POST") { data in
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self, from: data)
                            completion(response)
                    } catch let e {
                        print(e.localizedDescription)
                        completion(nil)
                    }
            }
    
    }
    func getTherapistForMassage(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
            Connection().connection(to: getTherapistForMassage, params: params, method: "POST") { data in
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self, from: data)
                            completion(response)
                    } catch let e {
                        print(e.localizedDescription)
                        completion(nil)
                    }
            }
    
    }
    func getServices(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
            Connection().connection(to: getServices, params: params, method: "POST") { data in
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(Response.self, from: data)
                            completion(response)
                    } catch let e {
                        print(e.localizedDescription)
                        completion(nil)
                    }
            }
    
    }
}
