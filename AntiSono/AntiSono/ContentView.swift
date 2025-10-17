//
//  ContentView.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/8/25.
//

import SwiftUI
import Package_Notificacacao_IOS
import FoundationModels
import CloudKit

struct ContentView: View {
    @State private var problema: String = ""
    @State private var resposta: Notificacao?
    
    @State var titulo: String = ""
    @State private var mensagem: String = ""
    @State private var intervalo: String = ""
    @State private var repete: Bool = false
    
    var body: some View {
        VStack(spacing: 16){
            Text("Gerador de Notificação com IA")
            TextField("Problema", text: $problema)
            Button("Gerar notificação"){
                let session = LanguageModelSession{
                    "Your job is to create an notification adequate to help an user with his problem"
                }
                Task{
                    do{
                        let response = try await session.respond(to: problema, generating: Notificacao.self)
                        resposta = response.content
                        
                        if let resposta{
                            titulo = resposta.titulo
                            mensagem = resposta.descricao
                            intervalo = "\(resposta.intervalo/60)"
                            repete = resposta.repete
                        }
                    }
                    catch{
                        print(error)
                    }
                }
            }
        }
        .padding()
        .padding(.bottom, 32)
        
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
//                agendarNotificaçãoTempo(titulo: titulo, mensagem: mensagem, intervalo: Int(intervalo) ?? 0, repete: repete)
                adicionarNotificacao(titulo: titulo)
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

func adicionarNotificacao(titulo: String) {

    let subscription = CKQuerySubscription(
        recordType: "Notificacao",
        predicate: NSPredicate(value: true),
        subscriptionID: subscriptionID,
        options: .firesOnRecordCreation
    )

    let notificationInfo = CKSubscription.NotificationInfo()
    notificationInfo.title = "Nova notificação!"
    notificationInfo.alertBody = "\(titulo)"
    notificationInfo.shouldBadge = true
    notificationInfo.soundName = "default"

    subscription.notificationInfo = notificationInfo

    CKContainer.default().publicCloudDatabase.save(subscription) { savedSubscription, error in
        if let error = error {
            print("Erro ao criar inscrição: \(error)")
        } else {
            print("Inscrição criada com sucesso!")
        }
    }
    
    let record = CKRecord(recordType: "Notificacao")
    record["mensagem"] = titulo

    CKContainer.default().publicCloudDatabase.save(record) { _, error in
        if let error = error {
            print("Erro ao salvar record: \(error)")
        } else {
            print("Record criado, subscription deve disparar push!")
        }
    }
}
