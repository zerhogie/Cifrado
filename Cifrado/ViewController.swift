//
//  ViewController.swift
//  Cifrado
//
//  Created by Enrique Rodríguez Castañeda on 29/08/17.
//  Copyright © 2017 zerhogie. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        carga.isHidden = true
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBOutlet weak var carga: NSProgressIndicator!
    
    
    @IBOutlet weak var cifrado: NSTextFieldCell!
    @IBOutlet weak var palabra: NSTextFieldCell!
    @IBOutlet weak var semilla: NSTextFieldCell!
    @IBOutlet weak var lblResultado: NSTextFieldCell!

    
    func codificar(cadena: String) -> String {
        var codificado = ""
        let semillado = asemillar(cadena: semilla.title)
        
        for char in Array(cadena.unicodeScalars) {
            var c = char.value
            c = c * semillado - semillado
            codificado = codificado + Character(UnicodeScalar(c)!).description + "l"
        }
        return codificado
    }
    
    func asemillar(cadena: String) -> UInt32 {
        var semillado:UInt32 = 0
        
        for char in Array(cadena.unicodeScalars) {
            semillado = (semillado + char.value) / 2
        }
        
        return semillado
    }
    
    
    @IBAction func cifrar(_ sender: NSButton) {
        if palabra.title == "" || palabra.title == "" {
            let alert = NSAlert.init()
            alert.messageText = "Tienes que llenar los campos"
            alert.informativeText = "Error"
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
        else {
            lblResultado.title = "Cifrado"
            cifrado.title = ""
            let codificado = codificar(cadena: palabra.title)
            /*for visual in Array(codificado.unicodeScalars) {
                var estatico = ""
                var i:UInt32 = 0
                while i < visual.value {
                    let when = DispatchTime.now() + .milliseconds(1)
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.cifrado.title = estatico + Character(UnicodeScalar(i)!).description
                    }
                    i += 1
                }
                estatico = estatico + Character(UnicodeScalar(i)!).description
                i = 0
                
            }*/
            cifrado.title = codificado
        }
    }
    
    @IBAction func pasar(_ sender: NSButton) {
        palabra.title = cifrado.title
    }
    
    
    @IBAction func decifrar(_ sender: NSButton) {
        let semillado = asemillar(cadena: semilla.title)
        var arreglo = palabra.title.components(separatedBy: "l")
        _ = arreglo.popLast()
        var decifrado = ""
        print(arreglo.count)
        for char in arreglo {
            let ent = Array(char.unicodeScalars)[0].value
            let c = (ent + semillado) / semillado
            decifrado = decifrado + Character(UnicodeScalar(c)!).description
        }
        lblResultado.title = "Descifrado"
        cifrado.title = decifrado
    }
}

