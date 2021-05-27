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
	var horaNotificacion: Date!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
      
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Asignar selector de fecha al campo de texto de hora
        createDatePicker()
        
        // Cargar configuración de usuario
        let defaults = UserDefaults.standard
        
        sw_notificaciones.isOn = defaults.bool(forKey: "Notificacion")
        tf_numero_preguntas.text = String(defaults.integer(forKey: "NumPreg"))
        tf_hora.text = defaults.string(forKey: "Hora")
    }
	
	@IBAction func guardar(_ sender: UIButton) {
		let defaults = UserDefaults.standard
		
		defaults.set(sw_notificaciones.isOn, forKey: "Notificacion")
		
		var error = false
		
		if let num = Int(tf_numero_preguntas.text!) {
			defaults.set(num, forKey: "NumPreg")
			
		} else {
			error = true
			let alert = UIAlertController(
				title: "Error",
				message: "El campo de número de preguntas no puede estar vacío",
				preferredStyle: .alert)
			
			let accion = UIAlertAction(
				title: "OK",
				style: .default,
				handler: {_ in
					self.dismiss(animated: true, completion: nil)
				})
			
			alert.addAction(accion)
			present(alert, animated: true, completion: nil)
		}
		
		if (tf_hora.text != "") {
			if (sw_notificaciones.isOn) {
				defaults.set(tf_hora.text, forKey: "Hora")
				mandarNotificacion()
			}
			
		} else {
			error = true
			let alert = UIAlertController(
				title: "Error",
				message: "Para activar las notificaciones debe especificar una hora",
				preferredStyle: .alert)
			
			let accion = UIAlertAction(
				title: "OK",
				style: .default,
				handler: {_ in
					self.dismiss(animated: true, completion: nil)
				})
			
			alert.addAction(accion)
			present(alert, animated: true, completion: nil)
		}
		
		if (!error) {
			dismiss(animated: true, completion: nil)
		}
	}
    
    // Métodos para notificaciones
    
	@IBAction func activarNotificaciones(_ sender: Any) {
		if sw_notificaciones.isOn {
			self.solicitarAutorizaciónNotificaciones()
			
		} else {
			let unc = UNUserNotificationCenter.current()
			unc.removeAllPendingNotificationRequests()
		}
	}
	
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
		if horaNotificacion == nil {
			return
		}
		
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Recordatorio de practicar"
        notificationContent.body = "La práctica hace al maestro 😁"
        notificationContent.badge = NSNumber(value: 1)
        
		let dailyTrigger = Calendar.current.dateComponents([.minute], from: horaNotificacion)
		
		let trigger = UNCalendarNotificationTrigger.init(dateMatching: dailyTrigger, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "miNotificacion",
            content: notificationContent,
            trigger: trigger)
        
		let unc = UNUserNotificationCenter.current()
		
		unc.add(request, withCompletionHandler: { (error) in
			if let error = error {
				print("Notification Error: ", error)
			}
		})
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
		horaNotificacion = datePicker.date
        self.view.endEditing(true);
    }
}
