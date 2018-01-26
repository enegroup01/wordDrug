import SpriteKit
import GameplayKit

class ElementScene: SKScene {
    
    
    var location = CGPoint()
    
    var elements = ["le0","le1","le2","le3","le4","le5","le6","le7","le8","le9"]
    var spotNumber = Int()
    
    override func didMove(to view: SKView) {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ElementScene.notifyPassUnitNumber), name: NSNotification.Name("passUnitNumber"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ElementScene.notifyJumpBackToMap), name: NSNotification.Name("backToMap"), object: nil)
        
                        NotificationCenter.default.addObserver(self, selector: #selector(ElementScene.gamePassUpdate), name: NSNotification.Name("gamePassUpdate"), object: nil)

        
        //製作元素背景
        makeImageNode(name: "elementBg", image: "elementBg", x: 0, y: 0, width: 750, height: 1334, z: 0, alpha: 1, isAnchoring: false)
        
        //製造元素
        makeImageNode(name: "de0", image: "e1", x: -230, y: 500, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le0", image: "le1", x: -230, y: 500, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "de1", image: "e2", x: -30, y: 400, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le1", image: "le2", x: -30, y: 400, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "de2", image: "e3", x: 150, y: 520, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le2", image: "le3", x: 150, y: 520, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        

        makeImageNode(name: "de3", image: "e4", x: -230, y: 200, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le3", image: "le4", x: -230, y: 200, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "de4", image: "e5", x: -30, y: 100, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le4", image: "le5", x: -30, y: 100, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "de5", image: "e6", x: 250, y: 160, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le5", image: "le6", x: 250, y: 160, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
    
        
        makeImageNode(name: "de6", image: "e7", x: -240, y: -200, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le6", image: "le7", x: -240, y: -200, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        makeImageNode(name: "de7", image: "e8", x: -70, y: -100, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le7", image: "le8", x: -70, y: -100, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "de8", image: "e9", x: 240, y: -160, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le8", image: "le9", x: 240, y: -160, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        
        makeImageNode(name: "de9", image: "e10", x: 0, y: -360, width: 120, height: 135, z: 1, alpha: 1, isAnchoring: false)
        makeImageNode(name: "le9", image: "le10", x: 0, y: -360, width: 160, height: 174, z: 2, alpha: 0, isAnchoring: false)
        

        makeLabelNode(x: -300, y: 600, alignMent: .left, fontColor: .green, fontSize: 40, text: "< back", zPosition: 1, name: "backButton", fontName: "Helvetica Bold", isHidden: false, alpha: 1)
        
        
        
        //在此確認已過關卡
        for (s,u) in gamePassed!{
            
            if s > spotNumber {
            
                //全亮
                for e in elements{
                    findImageNode(name: e).alpha = 1
                }
                
            } else if s == spotNumber{
                
                //只亮該關卡的通過數字
                for i in 0 ..< u + 1{
                    
                    findImageNode(name: elements[i]).alpha = 1
                    
                }
                
                
            }

            
            }
        
    }
 
    @objc func notifyPassUnitNumber(){
        

    }
    
    @objc func notifyJumpBackToMap(){
        

    }
    
    //通知關卡更新
    @objc func gamePassUpdate(){
        
        //在此確認已過關卡
        for (s,u) in gamePassed!{
            
            if s > spotNumber {
                
                //全亮
                for e in elements{
                    findImageNode(name: e).alpha = 1
                }
                
            } else if s == spotNumber{
                
                //只亮該關卡的通過數字
                for i in 0 ..< u + 1{
                    
                    findImageNode(name: elements[i]).alpha = 1
                    
                }
                
                
            }
            
            
        }

        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
        
        location = touch.location(in: self)
        
        let node : SKNode = self.atPoint(location)
        
            
            for i in 0 ..< elements.count{
                
                if node.name == elements[i]{
             
                    /*
                    let nodeNameToChange = "le" + String(i)
                    
                    changeImageAlfa(name: nodeNameToChange, toAlpha: 1, time: 0.1)
 */
                    
                    let unitSelected:[String:Int] = ["unitNumber":i]
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "passUnitNumber"), object: nil, userInfo: unitSelected)
                    
       
                }
                
                if node.name == "backButton"{
                    
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToMap"), object: nil, userInfo: nil)
                    

                }
                
                
            }
        
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    
    
    //製作image的skspriteNode
    func makeImageNode(name:String, image:String, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, alpha:CGFloat, isAnchoring:Bool){
        
        let bundlePath = Bundle.main.path(forResource: image, ofType: "png")
        let imageFile = UIImage(contentsOfFile: bundlePath!)
        let texture = SKTexture(image: imageFile!)
        let node = SKSpriteNode()
        
        node.size = CGSize(width: width, height: height)
        node.name = name
        node.texture = texture
        node.position = CGPoint(x: x, y: y)
        node.zPosition = z
        node.alpha = alpha
        
        if isAnchoring{
            
            node.anchorPoint = CGPoint(x: 0, y: 0)
        }
        
        addChild(node)
        
    }
    //製作一般labelNode
    func makeLabelNode(x:CGFloat,y:CGFloat,alignMent:SKLabelHorizontalAlignmentMode,fontColor:UIColor,fontSize:CGFloat,text:String,zPosition:CGFloat,name:String,fontName:String, isHidden:Bool, alpha:CGFloat){
        
        let node = SKLabelNode()
        node.position = CGPoint(x: x, y: y)
        node.horizontalAlignmentMode = alignMent
        node.fontSize = fontSize
        node.text = text
        node.fontColor = fontColor
        node.zPosition = zPosition
        node.name = name
        node.fontName = fontName
        node.isHidden = isHidden
        node.alpha = alpha
        
        addChild(node)
        
    }
    
    //製作SKNode
    func makeNode(name:String, color:UIColor, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, z:CGFloat, isAnchoring:Bool, alpha: CGFloat){
        
        let size = CGSize(width: width, height: height)
        let node = SKSpriteNode(color: color, size: size)
        node.alpha = alpha
        node.name = name
        node.position = CGPoint(x: x, y: y)
        node.zPosition = z
        
        if isAnchoring{
            
            node.anchorPoint = CGPoint(x: 0, y: 0)
        }
        
        addChild(node)
        
    }
    
    
    func changeImageAlfa(name:String, toAlpha:CGFloat, time:TimeInterval){
        
        if let node = childNode(withName: name) as? SKSpriteNode{
            let alphaAction = SKAction.fadeAlpha(to: toAlpha, duration: time)
            node.run(alphaAction)
            
        }
        
    }
    
    func changeLabelAlfa(name:String, toAlpha:CGFloat, time:TimeInterval){
        
        if let node = childNode(withName: name) as? SKLabelNode{
            let alphaAction = SKAction.fadeAlpha(to: toAlpha, duration: time)
            node.run(alphaAction)
            
        }
        
    }
    
    //找labelNode
    func findLabelNode(name:String) -> SKLabelNode{
        var node:SKLabelNode?
        node = childNode(withName: name) as? SKLabelNode
        return node!
        
    }
    
    //找IMAGE的skspritenode
    func findImageNode(name:String) -> SKSpriteNode{
        var node:SKSpriteNode?
        node = childNode(withName: name) as? SKSpriteNode
        return node!
        
    }
    
    
}

