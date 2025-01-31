//
//  Service.swift
//  Kumbaram
//
//  Created by Ozcan Akkoca on 6.01.2024.
//

import Foundation
import Alamofire
import Combine


public final class ServiceManager {

    public init() {}
    
    private let mockJSONResponse = """
    [
        {
            "step": "step_1",
            "type": "button",
            "content": {
                "text": "Merhaba, canlı destek hattına hoş geldiniz! Hangi konuda yardım almak istersiniz?",
                "buttons": [
                    {
                        "label": "İade işlemi",
                        "action": "step_2"
                    },
                    {
                        "label": "Sipariş durumu",
                        "action": "step_3"
                    },
                    {
                        "label": "Ürün rehberi",
                        "action": "step_4"
                    },
                    {
                        "label": "Sohbeti bitir",
                        "action": "end_conversation"
                    }
                ]
            },
            "action": "await_user_choice"
        },
        {
            "step": "step_2",
            "type": "button",
            "content": {
                "text": "İade işlemleri için ürününüzü kargoya verdiniz mi?",
                "buttons": [
                    {
                        "label": "Evet, kargoya verdim",
                        "action": "step_5"
                    },
                    {
                        "label": "Hayır, henüz vermedim",
                        "action": "step_6"
                    },
                    {
                        "label": "Sohbeti bitir",
                        "action": "end_conversation"
                    }
                ]
            },
            "action": "await_user_choice"
        },
        {
            "step": "step_3",
            "type": "text",
            "content": "Siparişiniz şu anda kargoda. Takip numaranız: TR123456789",
            "action": "end_conversation"
        },
        {
            "step": "step_4",
            "type": "image",
            "content": "https://www.botem.com.tr/imaj/akim-korumali-priz-nedir.png",
            "action": "show_guide"
        },
        {
            "step": "step_5",
            "type": "text",
            "content": "Teşekkür ederiz! İade işleminiz kargoya ulaştığında işleme alınacaktır.",
            "action": "end_conversation"
        },
        {
            "step": "step_6",
            "type": "text",
            "content": "İade işlemi için ürünü kargoya verdikten sonra işlemler başlatılacaktır. Yardıma ihtiyacınız olursa bizimle iletişime geçebilirsiniz.",
            "action": "end_conversation"
        },
        {
            "step": "step_7",
            "type": "button",
            "content": {
                "text": "Başka nasıl yardımcı olabilirim?",
                "buttons": [
                    {
                        "label": "Yeni bir işlem başlat",
                        "action": "step_1"
                    },
                    {
                        "label": "Sohbeti bitir",
                        "action": "end_conversation"
                    }
                ]
            },
            "action": "await_user_choice"
        }
    ]

    """
}

extension ServiceManager: ServiceProtocol {
    public func fetchData<T>(completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        guard let data = mockJSONResponse.data(using: .utf8) else {
            completion(.failure(NSError(domain: "InvalidMockData", code: -1, userInfo: nil)))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
}
