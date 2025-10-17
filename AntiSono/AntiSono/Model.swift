//
//  Model.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/13/25.
//
import FoundationModels

@Generable
struct Notificacao{
    
    @Guide(description: "Notification's title in 20 characters or less")
    let titulo: String
    
    @Guide(description: "Description of the notification in 100 characters or less")
    let descricao: String
    
    @Guide(description: "Time to wait for a notification, if 'repete' variable is true the time will be in minutes, so 1 will represent 1 minute, if 'repete' var9able is false the time will be in seconds, so 1 will represent 1 second and so on")
    let intervalo: Int
    
    @Guide(description: "This variable will determine if the notification will be repeated or not")
    let repete: Bool
}
