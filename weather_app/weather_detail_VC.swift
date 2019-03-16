//
//  weather_detail_VC.swift
//  weather_app
//
//  Created by manpreet on 1/3/19.
//  Copyright © 2019 manpreet. All rights reserved.
//

import UIKit


class weather_detail_VC: UIViewController {
    
    var detail_array = [AnyObject]()
    
    @IBOutlet weak var weather_detail_bkGround_image: UIImageView!
    
    @IBOutlet weak var scroll_view: UIScrollView!
   
    @IBOutlet weak var humid_lb: UILabel!
    
    @IBOutlet weak var pressure_lb: UILabel!
    
    @IBOutlet weak var speed_lb: UILabel!
    
    @IBOutlet weak var sunrise_lb: UILabel!
    
    @IBOutlet weak var sunset_lb: UILabel!
    
    @IBOutlet weak var visibility_lb: UILabel!
    
    @IBOutlet weak var description_lb: UILabel!
    
    @IBOutlet weak var city_name_lbl: UILabel!
    
    @IBOutlet weak var temp_lbl: UILabel!
    
    @IBOutlet weak var weather_img_Vw: UIImageView!
    
    @IBOutlet weak var max_temp: UILabel!
    
    @IBOutlet weak var min_temp: UILabel!
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("detail_array", detail_array)
        
       //print("\(String(describing: detail_array[0]["humidity"]!!))")
        city_name_lbl.text = "\(String(describing: detail_array[0]["city_name"]!!))"
        humid_lb.text = "\(String(describing: detail_array[0]["humidity"]!!))"+"%"
        pressure_lb.text = "\(String(describing: detail_array[0]["pressure"]!!))"+"hPa"
        speed_lb.text = "\(String(describing: detail_array[0]["speed"]!!))"+"km/h"
        sunrise_lb.text = "\(String(describing: detail_array[0]["sunrise"]!!))"
        sunset_lb.text = "\(String(describing: detail_array[0]["sunset"]!!))"
        
        let visibile = "\(String(describing: detail_array[0]["visibility"]!!))"
        visibility_lb.text = visibile.prefix(2)+" Km"
       // visibility_lb.text = "\(String(describing: detail_array[0]["visibility"]!!))"+" km"
        description_lb.text = "\(String(describing: detail_array[0]["description"]!!))"
        
        let max_temp_ = "\(String(describing: detail_array[0]["temp_max"]!!))"
        let min_temp_ = "\(String(describing: detail_array[0]["temp_min"]!!))"
       
        max_temp_.prefix(2)
        min_temp_.prefix(2)

        
       max_temp.text = "\(max_temp_.prefix(2))"
        min_temp.text = "\(min_temp_.prefix(2))"
        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
