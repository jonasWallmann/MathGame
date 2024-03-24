
//
//  GifView.swift
//  GifView_SwiftUI
//
//  Created by Pedro Rojas on 16/08/21.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String

    init(name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }

}

#Preview {
    GifImage(name: "firework")
}
