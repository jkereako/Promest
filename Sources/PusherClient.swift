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

    func subscribe(toChannel channelName: String) {
        // subscribe to channel and bind to event
        let channel = pusher.subscribe(channelName)
    }

    func unsubscribe() {
        pusher.unsubscribeAll()
    }
}
