//
//  ContentView.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/8/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var titulo: String = ""
    @State private var mensagem: String = ""
    @State private var intervalo: String = ""
    @State private var repete: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Titulo da Notificação", text: $titulo)
            TextField("Mensagem da Notificação", text: $mensagem)
            if (repete){
                TextField("Intervalo (min)", text: $intervalo)
            }
            else {
                TextField("Intervalo (seg)", text: $intervalo)
            }
            Toggle(isOn: $repete){
                Text("Repetir notificação?")
            }
            Button("Agendar Notificação"){
                agendarNotificação(titulo: titulo, mensagem: mensagem, intervalo: Int(intervalo) ?? 0, repete: repete)
            }
            Button("Remover Notificações"){
                removerNotificacoes()
            }
            .foregroundStyle(Color.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

