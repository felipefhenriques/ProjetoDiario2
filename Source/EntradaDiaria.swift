//
//  EntradaDiaria.swift
//  ProjetoDiario
//
//  Created by Felipe Ferreira on 01/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EntradaDiaria: UIViewController, UITextViewDelegate {
    @IBOutlet weak var viewNota: UIView!
    @IBOutlet weak var textViewNota: UITextView!
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var bttAdicionar: UIButton!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    var objetoGerenciado: NSManagedObjectContext!
    var entrada: NSManagedObject!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        estetica(view: viewNota, textView: textViewNota, labelData: labelData, botao: bttAdicionar)
        textViewNota.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        objetoGerenciado = appDelegate.persistentContainer.viewContext

        
        if (entrada != nil){
            self.textViewNota.text = entrada.value(forKey: "corpoTexto") as? String
        } else {
            self.textViewNota.text = ""
        }
        
    }
    
    @IBAction func bttAdicionar(_ sender: UIButton) {
        if (entrada != nil) {
            self.atualizarEntrada()
        } else {
            if (textViewNota.text != ""){
                self.criarNovaEntrada()
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func atualizarEntrada(){
        
    }
    
    func criarNovaEntrada(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let stringData = formatter.string(from: date)
        
        let entidadeEntrada = NSEntityDescription.entity(forEntityName: "Nota", in: self.objetoGerenciado)
        let objetoEntrada = NSManagedObject(entity: entidadeEntrada!, insertInto: self.objetoGerenciado)
        
        objetoEntrada.setValue(self.textViewNota.text, forKey: "corpoTexto")
        objetoEntrada.setValue(stringData, forKey: "criadoEm")
        
        do {
            try objetoGerenciado.save()
        } catch let error as NSError {
            print("could not save the new entry \(error.description)")
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    @IBAction func bttVoltar(_ sender: UIButton) {
        
    }
}

func estetica(view: UIView, textView: UITextView, labelData: UILabel, botao: UIButton){
    view.layer.cornerRadius = 50
    textView.layer.cornerRadius = 50
    botao.layer.cornerRadius = 40
    textView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    defineData(label: labelData)
}

func defineData(label: UILabel){
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyy"
    label.text = formatter.string(from: date)
}
