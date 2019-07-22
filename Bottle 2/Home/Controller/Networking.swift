//
//  Networking.swift
//  Bottle 2
//
//  Created by Vedant Jain on 16/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

extension HomeCollectionViewController {
    
    /// Main networking function. All networking calls are made through this function.
    /// - Note: Send -1 if either parameter is unavailable
    /// Parameter userId: Int, user id of the current user.
    /// Parameter workspaceId: Int, id of the current workspace.
    /// Returns: Void  (sets all variables)
    
    func networking(userId: Int, workspaceId: Int, completion: @escaping () -> ()) {
        
        if let window = UIApplication.shared.keyWindow {
            LoadingOverlay.shared.showOverlay(view: window)
        }
        
        let name = UserDefaults.standard.string(forKey: "username") ?? "err"
        
        getUserId(name: name) { (user) in
            self.mainUser = user
            self.tabViewControllerInstance?.userId = user.id
            self.dispatchGroup.leave()
        }
        
        getTasksByMe(userId: userId) { (tasks) in
            self.tasksByMe = tasks
            self.dispatchGroup.leave()
        }
        
        getTasksForMe(userId: userId) { (tasks) in
            self.tasksForMe = tasks
            self.dispatchGroup.leave()
        }
        
        getWorkspaces(userId: userId) { (workspacesArray) in
            self.workspaces = workspacesArray
            self.dispatchGroup.leave()
        }
        
        getUsers(workspaceId: workspaceId) { () in
            self.tabViewControllerInstance?.users = self.users
            self.formLauncher.users = self.users
            self.dispatchGroup.leave()
        }
        
        getProjects(userId: userId) { (projects) in
            self.projects = projects
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            LoadingOverlay.shared.hideOverlayView()
            completion()
        }
        
    }
    
    func getUserId(name: String, completion: @escaping (User) -> ()) {
        
        // not a very good way
        // but server never returns userId anywhere
        
        dispatchGroup.enter()
        
        if name == "err" {
            dispatchGroup.leave()
            return
        }
        
        let url = "https://qkvee3o84e.execute-api.ap-south-1.amazonaws.com/default/getusers"
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: [:], headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([User].self, from: data)
                        for element in response {
                            if element.username == name {
                                completion(element)
                            }
                        }
                    }
                    catch let error {
                        print("error", error)
                    }
                    
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func getUsers(workspaceId: Int, completion: @escaping () -> ()) {
        
        // get list of users in workspace
        // use userIds to get details of each user
        
        dispatchGroup.enter()
        
        let url = "https://j8008zs2ol.execute-api.ap-south-1.amazonaws.com/default/workspaceusers"
        
        let parameters = [
            "workspaceId": workspaceId
        ]
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        users = []
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([WorkspaceUser].self, from: data)
                        self.getUserDetails(users: response, completion: { (users) in
                            self.users = users
                            completion()
                        })
                    }
                    catch let error {
                        print("error", error)
                    }
                    
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func getUserDetails(users: [WorkspaceUser], completion: @escaping ([User]) -> ()){
        
        var userDetailsArray: [User] = []
        
        if users.isEmpty == true {
            completion([User(id: -1, username: "@err", createdAt: "", updatedAt: "")])
        }
        
        for user in users {
            
            let userId = user.userId
            
            if userId == -1 {print("err")}
            
            let url = "https://qkvee3o84e.execute-api.ap-south-1.amazonaws.com/default/getusers"
            
            let headers = [
                "Content-type": "application/json"
            ]
            
            let parameters = [
                "id": userId
            ]
            
            var userDetails: User?
            
            Alamofire.request(url, method: .get, parameters: parameters as Parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let response = try JSONDecoder().decode([User].self, from: data)
                            for user in response {
                                // only one element
                                userDetails = User(id: user.id, username: user.username, createdAt: user.createdAt, updatedAt: user.updatedAt)
                                userDetailsArray.append(userDetails!)
                            }
                            if user.userId == users.last?.userId {completion(userDetailsArray)}
                        }
                        catch let error {
                            print("error", error)
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
    }
    
    func getTasksForMe(userId: Int, completion: @escaping ([Task]) -> ()) {
        
        dispatchGroup.enter()
        
        var tasks: [Task] = []
        
        let url = "https://wa01k4ful5.execute-api.ap-south-1.amazonaws.com/default/tasks"
        
        // goes into tasksforme
        let parameters = [
            "assignedTo": userId
        ]
        
        let header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Task].self, from: data)
                        if response.isEmpty == true {
                            completion(tasks)
                        }
                        for element in response {
                            tasks.append(element)
                            if element.id == response.last?.id {
                                completion(tasks)
                            }
                        }
                    }
                    catch let error {
                        print("error", error)
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func getTasksByMe(userId: Int, completion: @escaping ([Task]) -> ()) {
        
        dispatchGroup.enter()
        
        var tasks: [Task] = []
        
        let url = "https://wa01k4ful5.execute-api.ap-south-1.amazonaws.com/default/tasks"
        
        // goes into tasksbyme
        let parameters = [
            "createdBy": userId
        ]
        
        let header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Task].self, from: data)
                        if response.isEmpty == true {
                            completion(tasks)
                        }
                        for element in response {
                            tasks.append(element)
                            if element.id == response.last?.id {
                                completion(tasks)
                            }
                        }
                    }
                    catch let error {
                        print("error", error)
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func getWorkspaces(userId: Int, completion: @escaping ([Workspace]) -> ()) {
        
        dispatchGroup.enter()
        
        workspaces = []
        
        let url = "https://j8008zs2ol.execute-api.ap-south-1.amazonaws.com/default/workspaceusers"
        
        let parameters = [
            "userId": userId
        ]
        
        let header = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([WorkspaceUser].self, from: data)
                        self.getWorkspaceDetails(ids: response, completion: { (workspacesArray) in
                            completion(workspacesArray)
                        })
                        
                    }
                    catch let error {
                        print("error", error)
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    func getWorkspaceDetails(ids: [WorkspaceUser], completion: @escaping ([Workspace]) -> ()) {
        
        var workspaceDetailsArray: [Workspace] = []
        
        // if no workspace is available
        if ids.isEmpty == true {
            completion([])
            return
        }
        
        for id in ids {
            
            let url = "https://7dq8nzhy1e.execute-api.ap-south-1.amazonaws.com/default/workspace"
            
            let parameters = [
                "id": id.workspaceId
            ]
            
            let headers = [
                "Content-type": "application/json"
            ]
            
            Alamofire.request(url, method: .get, parameters: parameters as Parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let response = try JSONDecoder().decode([Workspace].self, from: data)
                            for element in response {
                                workspaceDetailsArray.append(element)
                            }
                            if id.workspaceId == ids.last?.workspaceId {
                                completion(workspaceDetailsArray)
                            }
                        }
                        catch let error {
                            print("error", error)
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
            
        }
        
    }
    
    func getProjects(userId: Int, completion: @escaping ([Project]) -> ()) {
        
        dispatchGroup.enter()
        
        var projectDetailsArray: [Project] = []
        
        let url = "https://wg9fx8sfq8.execute-api.ap-south-1.amazonaws.com/default/projects"
        
        let parameters = [
            "createdBy": userId
        ]
        
        let headers = [
            "Content-type": "application/json"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    do {
                        let response = try JSONDecoder().decode([Project].self, from: data)
                        if response.isEmpty == true {
                            completion([Project(id: -1, name: "No projects found", createdBy: self.tabViewControllerInstance?.userId, createdAt: "", updatedAt: "", workspace: UserDefaults.standard.integer(forKey: "selectedWorkspace"))])
                            return
                        }
                        for element in response {
                            projectDetailsArray.append(element)
                            if element.id == response.last?.id {
                                completion(projectDetailsArray)
                            }
                        }
                    }
                    catch let error {
                        print("error", error)
                    }
                }
                break
            case .failure(let err):
                print(err)
                break
            }
        }
        
    }
    
}
