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
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.solicitarAutorizaciónNotificaciones()
        self.mandarNotificacion()

        // Do any additional setup after loading the view.
        
        // Asignar selector de fecha al campo de texto de hora
        tf_hora.datePicker(
            target: self,
            doneAction: #selector(doneAction),
            cancelAction: #selector(cancelAction),
            datePickerMode: .time)
        
        // Cargar configuración de usuario
        let defaults = UserDefaults.standard
        
        sw_notificaciones.isOn = defaults.bool(forKey: "Notificacion")
        tf_numero_preguntas.text = String(defaults.integer(forKey: "NumPreg"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defaults = UserDefaults.standard
        
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
}

extension UITextField {
    func datePicker(
        target: Any,
        doneAction: Selector,
        cancelAction: Selector,
        datePickerMode: UIDatePicker.Mode = .date
    ) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                    case .cancel:
                        return cancelAction
                    case .done:
                        return doneAction
                    default:
                        return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(
                barButtonSystemItem: style,
                target: buttonTarget,
                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(
            frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        
        let toolBar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        
        toolBar.setItems(
            [buttonItem(withSystemItemStyle: .cancel),
             buttonItem(withSystemItemStyle: .flexibleSpace),
             buttonItem(withSystemItemStyle: .done)],
            animated: true
        )
        
        self.inputAccessoryView = toolBar
    }
}
