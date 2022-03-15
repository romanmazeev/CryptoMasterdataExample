//
//  StateStoreTableViewController.swift
//  BitpandaTest
//
//  Created by Roman Mazeev on 07/03/22.
//

import Combine
import ComposableArchitecture
import UIKit

/// Convenience class for view controllers that are powered by state stores.
class StateStoreTableViewController<State: Equatable, Action>: UITableViewController {
    
    // MARK: Properties
    
    /// The store powering the view controller.
    var store: Store<State, Action>
    
    /// The view store wrapping the store for the actual view.
    var viewStore: ViewStore<State, Action>
    
    /// Keeps track of subscriptions.
    var cancellables: Set<AnyCancellable> = []
    
    // MARK: Initialization
    
    /// Creates a new store view controller with the given store.
    ///
    /// - Parameter store: The store to use with the view controller.
    ///
    /// - Returns: A new view controller.
    init(store: Store<State, Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
