//
//  ListaNotas.swift
//  ProjetoDiario
//
//  Created by Felipe Ferreira on 01/06/20.
//  Copyright © 2020 Felipe Ferreira. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListaNotas: UIViewController, UITableViewDelegate {
    @IBOutlet weak var outletNotaDiaria: UIButton!
    override var prefersStatusBarHidden: Bool {
        return true
    }
    var objetoGerenciado: NSManagedObjectContext!
    @IBOutlet weak var tabelaNotas: UITableView!
    var entradas: [NSManagedObject]!
    
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        outletNotaDiaria.layer.cornerRadius = 40
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buscarEntradas()
    }
    
    func buscarEntradas(){
        let pedidoBusca = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
        do {
            let objetosEntrada = try objetoGerenciado.execute(pedidoBusca)
            self.entradas = (objetosEntrada as! [NSManagedObject])
        } catch let erro as NSError {
            print("Não foi possível buscar entradas\(erro), \(erro.userInfo)")
        }
        self.tabelaNotas.reloadData()
    }
    
   
    
}

class ListaController: UITableViewController {
    @IBOutlet weak var outletNotaDiaria: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    var objetoGerenciado: NSManagedObjectContext!
    @IBOutlet weak var tabelaNotas: UITableView!
    var entradas: [NSManagedObject]!
    
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        //outletNotaDiaria.layer.cornerRadius = 40
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buscarEntradas()
    }
    
    func buscarEntradas(){
        let pedidoBusca = NSFetchRequest<NSFetchRequestResult>(entityName: "Nota")
        do {
            let objetosEntrada = try objetoGerenciado.execute(pedidoBusca)
            self.entradas = (objetosEntrada as! [NSManagedObject])
        } catch let erro as NSError {
            print("Não foi possível buscar entradas\(erro), \(erro.userInfo)")
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entradas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celula entrada", for: indexPath)
        let entrada = entradas[indexPath.row]
        
        cell.textLabel?.text = entrada.value(forKey: "corpoTexto") as? String
        cell.detailTextLabel?.text = entrada.value(forKey: "criadoEm") as? String
        
        return cell
    }
    
}

