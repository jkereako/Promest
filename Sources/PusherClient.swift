//
//  PusherClient.swift
//  Pusher
//
//  Created by Jeff Kereakoglow on 2/15/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import PusherSwift

final class PusherClient {
    private let pusher: Pusher

    init(host: String, key: String) {
        let options = PusherClientOptions(
            host: .cluster(host)
        )
        pusher = Pusher(key: key, options: options)
        pusher.connect()
    }

    func subscribeToChannel(_ channelName: String, listeningForEvent eventName: String,
                            eventHandler: @escaping (String) -> Void) {
        // subscribe to channel and bind to event
        let channel = pusher.subscribe(channelName)

        channel.bind(eventName: eventName) { (data) in
            // TODO: Replace with real code
            guard let data = data as? [String: AnyObject],
                let message = data["message"] as? String else {
                    return
            }

            eventHandler(message)
        }
    }

    func unsubscribe() {

        pusher.unsubscribeAll()
    }
}
