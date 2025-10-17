//
//  outro.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/9/25.
//
//

import Foundation
import UserNotifications

func pedirPermissão() -> Void {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            print("All set!")
        } else if let error {
            print(error.localizedDescription)
        }
    }
}

func agendarNotificaçãoTempo(titulo: String, mensagem: String, intervalo: Int, repete: Bool) -> Void {
    
    var tempo_intervalo: String
    
    if (repete){ //se repetir tem q ser uma notificação com tempo de pelo menos 1 minuto, por isso multiplico os segundos
        tempo_intervalo = String(intervalo * 60)
    }
    else {
        tempo_intervalo = String(intervalo)
    }
    
    print("Clicou no botão!")
    pedirPermissão()
    let content = UNMutableNotificationContent()
    content.title = titulo
    content.subtitle = mensagem
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(tempo_intervalo)!, repeats: repete)
    
    // Escolhe um identificador aleatorio
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    // Adiciona nossa requisição de notificação
    UNUserNotificationCenter.current().add(request)
    print("Request lançado")
}

func removerNotificacoes(){
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
}


