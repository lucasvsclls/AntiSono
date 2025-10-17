//
//  Intents.swift
//  AntiSono
//
//  Created by Lucas Vasconcellos Côrtes on 10/17/25.
//
import AppIntents
import FoundationModels

struct CriarNotificacao: AppIntent {
    
    static var title: LocalizedStringResource = "Criar Notificação"

    static var description = IntentDescription("Cria uma notificação com titulo e mensagem geradas por IA")
    
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Problema", description: "O problema para gerar a notificação customizada")
    var problema: String
    
    @MainActor
    func perform() async throws -> some IntentResult {
        var resposta: Notificacao?
        
        let session = LanguageModelSession{
            "Your job is to create an notification adequate to help an user with his problem"
        }
        do{
            let response = try await session.respond(to: problema, generating: Notificacao.self)
            resposta = response.content
            
            if let resposta{
                adicionarNotificacao(titulo: resposta.titulo)
            }
        }
        catch{
            print(error)
        }
        
        return .result()
    }
}
