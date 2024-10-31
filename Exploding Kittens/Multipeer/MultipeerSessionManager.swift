//
//  MultipeerSessionManager.swift
//  Exploding Kittens
//
//  Created by Trịnh Kiết Tường on 31/10/24.
//

import Foundation
import MultipeerConnectivity

import Foundation
import MultipeerConnectivity

class MultipeerSessionManager: NSObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {
    var session: MCSession
    var peerID: MCPeerID
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    var nearbyServiceBrowser: MCNearbyServiceBrowser
    var connectedPeers: [MCPeerID] = []

    override init() {
        self.peerID = MCPeerID(displayName: UIDevice.current.name)
        self.session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        self.nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "exploding-kittens")
        self.nearbyServiceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: "exploding-kittens")

        super.init()

        self.session.delegate = self
        self.nearbyServiceAdvertiser.delegate = self
        self.nearbyServiceBrowser.delegate = self
    }

    func startHosting() {
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }

    func stopHosting() {
        nearbyServiceAdvertiser.stopAdvertisingPeer()
    }

    func startBrowsing() {
        nearbyServiceBrowser.startBrowsingForPeers()
    }

    func stopBrowsing() {
        nearbyServiceBrowser.stopBrowsingForPeers()
    }

    // MCSessionDelegate methods
    func session(_ session: MCSession, peer: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            connectedPeers.append(peer)
            print("\(peer.displayName) connected")
        case .notConnected:
            if let index = connectedPeers.firstIndex(of: peer) {
                connectedPeers.remove(at: index)
                print("\(peer.displayName) disconnected")
            }
        case .connecting:
            print("Connecting to \(peer.displayName)...")
        @unknown default:
            fatalError()
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // Handle received data here
        print("Received data from \(peerID.displayName)")
        // Decode data and update game state as needed
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Handle incoming stream data here if using streams
        print("Received stream from \(peerID.displayName) with name \(streamName)")
    }

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Handle the start of resource reception here
        print("Started receiving resource \(resourceName) from \(peerID.displayName)")
    }

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Handle the received resource
        if let error = error {
            print("Error receiving resource \(resourceName): \(error.localizedDescription)")
        } else {
            print("Finished receiving resource \(resourceName) from \(peerID.displayName)")
        }
    }

    func session(_ session: MCSession, didReceiveResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, with progress: Progress) {
        // Handle receiving resource with progress here
        print("Receiving resource \(resourceName) from \(peerID.displayName), progress: \(progress.fractionCompleted)")
    }

    // MCNearbyServiceAdvertiserDelegate methods
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("Received invitation from \(peerID.displayName)")
        // Accept the invitation and create a session
        invitationHandler(true, session)
    }

    // MCNearbyServiceBrowserDelegate methods
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        print("Found peer: \(peerID.displayName)")
        // Optionally send an invitation to the found peer
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 30)
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Lost peer: \(peerID.displayName)")
        // Handle losing a peer if necessary
        if let index = connectedPeers.firstIndex(of: peerID) {
            connectedPeers.remove(at: index)
        }
    }
}
