//
//  CloudKitUser.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/9/25.
//

import SwiftUI
import Combine
import CloudKit

class CloudKitUserViewModel: ObservableObject {
    
    var container: CKContainer = .default()
    
    @Published var isAvailable: Bool = false
    @Published var error: String = ""
    
    init(){
        getICloudStatus()
    }
    
    private func getICloudStatus(){
        CKContainer.default().accountStatus {  [weak self] (status, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error getting iCloud status: \(error)")
                    
                } else {
                    switch status {
                    case .available:
                        self?.isAvailable = true
                        self?.error = "Deu certo mulekote"
                    case .noAccount:
                        self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                    case .couldNotDetermine:
                        self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                    case .restricted:
                        self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                    default:
                        self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                    }
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func discoverICloudUser(UserRecordID: CKRecord.ID){
    }
}

struct CloudKitUser: View {
    @StateObject private var vm = CloudKitUserViewModel()
    
    var body: some View {
        VStack {
            Text("Disponibilidade: \(vm.isAvailable.description.uppercased())")
            Text(vm.error.description)
        }
    }
}

#Preview {
    CloudKitUser()
}
