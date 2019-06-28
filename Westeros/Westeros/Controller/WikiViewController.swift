//
//  WikiViewController.swift
//  Westeros
//
//  Created by Alexandre Freire on 18/06/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit
import WebKit

final class WikiViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // MARK: Properties
    private var model: House
    
    // MARK: Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)) )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Asignar delegados
        webView.navigationDelegate = self
        syncModelWithView()
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotifications()
    }
}

// MARK: - Extensions
extension WikiViewController {
    private func subscribeToNotifications() {
        let notificationCenter = NotificationCenter.default
        // Nos damos de alta en las notifications
        notificationCenter.addObserver(
            self,
            selector: #selector(houseDidChange),
            name: .houseDidNotificationName,
            object: nil) // Objecto que envia la notification
    }
    
    private func unsubscribeNotifications() {
        // Nos damos de baja de las notificaciones
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func houseDidChange(notification: Notification) {
        // Averiguar la casa
        guard let dictionary = notification.userInfo else {
            return
        }
        
        guard let house = dictionary[HouseListViewController.Constants.houseKey] as? House else {
            return
        }
        
        // Cuando se detecta el cambio de la casa pulsada, primero se actualiza el modelo y luego se vuelve a sincronizar modelo - vista
        model = house
        syncModelWithView()
        
    }
}


extension WikiViewController {
    private func syncModelWithView() {
        title = model.name
        
        // Mostramos y arrancamos el loading view
        loadingView.isHidden = false
        loadingView.startAnimating()
        
        // Cargar la url
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
    }
}

extension WikiViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Detenemos el loading view
        loadingView.stopAnimating()

        // Ocultarlo
        loadingView.isHidden = true
    }
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy
    ) -> Void) {
        
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
        
    }
}
