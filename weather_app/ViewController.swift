//
//  ViewController.swift
//  weather_app
//
//  Created by manpreet on 22/2/19.
//  Copyright © 2019 manpreet. All rights reserved.
//

import UIKit
import Alamofire


var states_id =  ["4163971","2147714","2174003"]

var array_to_pass_val = [[String: String]]()   // created array to pass the value to next controller

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var Weather_table_Vw: UITableView!
    
    @IBOutlet weak var activity_indicator: UIActivityIndicatorView!
    
    
    var city_name_array = [String]()
    var city_temp_array = [String]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        Weather_table_Vw.backgroundView = UIImageView(image: UIImage(named: "day_back.png"))
        // tableview delegates
        Weather_table_Vw.dataSource = self
        Weather_table_Vw.delegate = self
        
       
        activity_indicator.startAnimating()
    
        for i in states_id
        {
            print(i)
            
            
            let str = "http://api.openweathermap.org/data/2.5/weather?id="+i
            let str2 = "&units=metric&APPID=42703c3596a74b4c2c12152163f8e21c"
            let urlstring = str+str2
            print(urlstring)
            
            
            // post method
            
            let url =  Alamofire.request(urlstring, method: .post, parameters: nil,encoding: JSONEncoding.default, headers: nil).responseJSON
                {
                response in
                switch response.result {
                case .success:
                    print(response)
                    
                    if let jsonData = response.result.value
                    
                    {
                        
                        let data  = jsonData as! NSDictionary
                        
                        print("Data: \(data)")
                        let city_name = data["name"]!
                        print(data["name"]!)
                        self.city_name_array.append(city_name as! String)
                        print(data["main"]!)
                       // print(data["main"]["temp_min"] as AnyObject?)
                        
                        let filterdata = data["main"] as? NSDictionary
                        let tem = "\(String(describing: filterdata!["temp_min"]!))"
                        //let tem = filterdata?["temp"] as! any
                        let tem_val = tem.prefix(2)
                        //let max_tem = filterdata!["temp_max"]
                        print(tem_val,"tem_val")
                       // print(max_tem!)
                        
                        
                        // data need to pass next view append in dictionary
                        
                        let max_tem = filterdata!["temp_max"]   // max temp
                        
                        let min_tem = filterdata!["temp_min"]  // min temp
                        
                        let humidity = filterdata!["humidity"]
                        
                         let pressure = filterdata!["pressure"]
                        
                        let sun_timings_data = data["sys"] as? NSDictionary
                        
                        let sun_set = sun_timings_data?["sunset"]
                        
                        let sun_rise = sun_timings_data?["sunrise"]
                        
                        let visibility = data["visibility"]
                        
                        let weather_descript = data["weather"] as! NSArray
                        print("\(String(describing: weather_descript))" )
                        let weather_descript_cond = (weather_descript.value(forKey: "main")as! NSArray).object(at: 0)
                        print(weather_descript_cond,"weather_descript_cond")
                        
                       
                        
                    
                        
                            
                        
                        
                        
                          let weather_wind = data["wind"] as? NSDictionary
                        let wind_speed = weather_wind?["speed"]
                        
                        
                        
                        var detail_Dictionary = [String: Any]() // craeted dictionary
                        
                       
                        
                        detail_Dictionary = ["city_name" : "\(String(describing: city_name))",
                        "temp_max" : "\(String(describing: max_tem!))",
                                "temp_min" :"\(String(describing:  min_tem!))",
                                "humidity" : "\(String(describing: humidity!))",
                                "pressure" : "\(String(describing: pressure!))",
                                "sunset" : "\(String(describing: sun_set!))",
                                "sunrise" : "\(String(describing: sun_rise!))",
                                "visibility" : "\(String(describing: visibility!))",
                                "description" : "\(String(describing: weather_descript_cond))",
                                "speed" : "\(String(describing: wind_speed!))"]
                        
                        print("detail_Dictionary",detail_Dictionary)
                        
                        UserDefaults.standard.set(detail_Dictionary, forKey: "addItem")
                        
                        // getting from memory
                        if let addItem = UserDefaults.standard.dictionary(forKey: "addItem")
                        {
                            array_to_pass_val.append(addItem as! [String : String])
                        }
                        
                       print("array_to_pass_val",array_to_pass_val)
                        
                        self.city_temp_array.append(String(describing: tem_val))
                       
                        
                        print(self.city_temp_array)
                        self.Weather_table_Vw.reloadData()
                        
                       
                    }
                    
                   

                    break
                case .failure(let error):

                    print(error)
                }
            }
             print(url)
            
        }
        activity_indicator.isHidden = true
        activity_indicator.stopAnimating()
       
        
    }


  // tableview delegate and datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return city_name_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell"))!
        
        var imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 100, height: 200))
        
        let image = UIImage(named: "day_back.png")
        
        cell.backgroundColor = UIColor.clear
        
        imageView = UIImageView(image:image)
        
        cell.backgroundView = imageView
        
        let city_name_lb = cell.contentView.viewWithTag(101) as! UILabel
        
        
        city_name_lb.text = city_name_array[indexPath.row]
        
        let city_weather_lb = cell.contentView.viewWithTag(102) as! UILabel
        
        city_weather_lb.text = city_temp_array[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail_VC = storyboard.instantiateViewController(withIdentifier: "weather_detail_VC") as! weather_detail_VC
    
        detail_VC.detail_array.append(array_to_pass_val[indexPath.row] as AnyObject)
        self.navigationController?.pushViewController(detail_VC, animated: true)
       
    
    }
    
}

