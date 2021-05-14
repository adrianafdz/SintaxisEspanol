//
//  ConfigViewController.swift
//  SintaxisEspanol
//
//  Created by Jair Antonio on 21/04/21.
//

import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var sw_notificaciones: UISwitch!
    @IBOutlet weak var tf_hora: UITextField!
    @IBOutlet weak var tf_numero_preguntas: UITextField!
    
    let datePicker = UIDatePicker()
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.solicitarAutorizaciónNotificaciones()
        self.mandarNotificacion()

        // Do any additional setup after loading the view.
        
        // Asignar selector de fecha al campo de texto de hora
        createDatePicker()
        
        // Cargar configuración de usuario
        let defaults = UserDefaults.standard
        
        sw_notificaciones.isOn = defaults.bool(forKey: "Notificacion")
        tf_numero_preguntas.text = String(defaults.integer(forKey: "NumPreg"))
        tf_hora.text = defaults.string(forKey: "Hora")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defaults = UserDefaults.standard
        
        defaults.set(sw_notificaciones.isOn, forKey: "Notificacion")
        
        if let num = Int(tf_numero_preguntas.text!) {
            defaults.set(num, forKey: "NumPreg")
            
        } else {
            let alert = UIAlertController(
                title: "Error",
                message: "El campo de número de preguntas no puede estar vacío",
                preferredStyle: .alert)
            
            let accion = UIAlertAction(
                title: "OK",
                style: .default,
                handler: {_ in
                    self.dismiss(animated: true, completion:nil)
            })
            
            alert.addAction(accion)
            present(alert, animated: true, completion: nil)
        }
        
        defaults.set(tf_hora.text, forKey: "Hora")
    }
    
    // Métodos para notificaciones
    
    func solicitarAutorizaciónNotificaciones() {
        let opciones = UNAuthorizationOptions.init(
            arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: opciones) {
            (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func mandarNotificacion() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Recordatorio de practicar"
        notificationContent.body = "La práctica hace al maestro 😁"
        notificationContent.badge = NSNumber(value: 1)
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "testNotification",
            content: notificationContent,
            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    // Métodos para selección de fecha
    
    @objc
    func cancelAction() {
        tf_hora.resignFirstResponder()
    }
    
    @objc
    func doneAction() {
        if let datePickerView = tf_hora.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: datePickerView.date)
            tf_hora.text = dateString
            
            tf_hora.resignFirstResponder()
        }
    }
    
    // Otros métodos

    @IBAction func quitarTeclado(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let bt_listo = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector(listoPresionado))
        
        toolbar.setItems([bt_listo], animated: true)
        
        tf_hora.inputAccessoryView = toolbar
        
        tf_hora.inputView = datePicker
        
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.datePickerMode = .time
    }
    
    @objc func listoPresionado() {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        tf_hora.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true);
    }
}
