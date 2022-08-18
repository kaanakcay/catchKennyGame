//
//  ViewController.swift
//  CatchKenny
//
//  Created by Kaan Akçay on 9.08.2022.
//

//Oyun özellikleri:
//1. Sayaç ondan geriye sayıyo ve bitince uyarı veriyo. Uyarı'da iki seçenek var

import UIKit

class ViewController: UIViewController {
    
    //Views
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
   //Variables
    var count = 0 //bu score için oluşturduğum variable (atıl hoca: score)
    var timer = Timer() //bu üstteki timer için
    var timerCount = 0
    var highScore = 0
    var storedCountGlobal : Int = 0
    var kaanArray = [UIImageView]() //kaan fotosundan oluşan bir array oluşturduk
    var hideTimer = Timer() //bu kenny lerin otomatik gizlenip ortaya çıkması için
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerCount = 10
        timerLabel.text = "\(timerCount)"
        
        scoreLabel.text = "Score: \(count)"
        
       
       //Images
        imageView.isUserInteractionEnabled = true //bu şekilde imageView artık tıklanabilir yani interaktif bir image bunu da her kaan için ayrı ayrı yazıyon
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        imageView4.isUserInteractionEnabled = true
        imageView5.isUserInteractionEnabled = true
        imageView6.isUserInteractionEnabled = true
        imageView7.isUserInteractionEnabled = true
        imageView8.isUserInteractionEnabled = true
        imageView9.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))//her kaan için farklı recognizer yazmam lazım
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(scoreIncrement))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        imageView2.addGestureRecognizer(gestureRecognizer2)
        imageView3.addGestureRecognizer(gestureRecognizer3)
        imageView4.addGestureRecognizer(gestureRecognizer4)
        imageView5.addGestureRecognizer(gestureRecognizer5)
        imageView6.addGestureRecognizer(gestureRecognizer6)
        imageView7.addGestureRecognizer(gestureRecognizer7)
        imageView8.addGestureRecognizer(gestureRecognizer8)
        imageView9.addGestureRecognizer(gestureRecognizer9)

        
        //Timers
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        //ece
        //kaan'ı hareket ettirme
        kaanArray = [imageView, imageView2,imageView3,imageView4,imageView5,imageView6,imageView7,imageView8,imageView9] //arraye fotoları ekledik
        
        hideKenny() //bunu buraya yazdık çünkü uygulamayı ilk açtığımızda hiçbir kaan gözükmesin istiyoruz.
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        //HIGHSCORE CHECK
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{ //ilk başta nil olacağı için hata vermemesi için böyle yapıyoz
            highScore = 0
            highScoreLabel.text = "Highscore \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
            
    }
    
    @objc func hideKenny(){ //kenny'i gizlemek için bunu yaptık
        for kenny in kaanArray{
            kenny.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kaanArray.count-1))) //bu random sayı oluşturma fonsiyonu ve bu şekilde kullanılıyor bu kaanArray.count-1 yazdığımız şey de 0 dan kaça kadar olsun anlamında. -1 dedik çünkü kaanArray 9 elemanlı ama 9. indeks yok en son 8 de bitiyo 0 dan başladığı için. ayrıca atıyorum buraya 8 yazdık ya 8 dahil oluyor
        
        kaanArray[random].isHidden = false
        
    }

    @objc func scoreIncrement(){
        count += 1
        scoreLabel.text = "Score: \(count)"
        
    }
    
    @objc func timerFunc(){
        timerLabel.text = "\(timerCount)"
        timerCount -= 1
        if timerCount == 0{
            
            for kenny in kaanArray{
                kenny.isHidden = true
            }
            hideTimer.invalidate()
            
            //HIGHSCORE
            if count > highScore{
                highScore = count
                highScoreLabel.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert) //uyarıyı bir variable'a atadık
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            
            let yesButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                self.count = 0 //self diyoruz çünkü bir sürü süslü parantez içindeyiz ve globaldeki count'a erişmek istediğimizi koda anlatmış oluyoruz
                self.scoreLabel.text = "Score: \(self.count)"
                self.timerCount = 10
                self.timerLabel.text = String(self.timerCount)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)//timer ı tekrar çalıştırıyoruz
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okButton)
            alert.addAction(yesButton)
            
            self.present(alert, animated: true, completion: nil)
            
            timer.invalidate()//bu fonksiyon timerı bitirmeye yarıyo.
            timerLabel.text = "0"
            
        }
        
    }

}

