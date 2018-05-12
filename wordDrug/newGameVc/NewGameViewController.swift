//
//  NewGameViewController.swift
//  wordDrug
//
//  Created by Ethan on 2018/2/1.
//  Copyright © 2018年 playplay. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Speech
import AVFoundation
import SwiftSiriWaveformView
import NVActivityIndicatorView


let showSentenceKey = "showSentence"
let backToSpellKey = "backToSpell"
let practiceNextWordKey = "practiceNextWord"
let startCountDownKey = "startCountDown"
let timesUpKey = "timesUp"
let showTagKey = "showTag"
let readyToReadSentenceKey = "readyToReadSentence"
let readSentenceKey = "readSentence"
let onlyPracticeSentenceKey = "onlyPracticeSentence"
let restartGame2Key = "restartGame2"
let restartCountingKey = "restartCounting"


class NewGameViewController: UIViewController, SFSpeechRecognizerDelegate, TagListViewDelegate, AVSpeechSynthesizerDelegate{
    
    //中文字粉紅色
    let pinkColor = UIColor.init(red: 1, green: 153/255, blue: 212/255, alpha: 1)
    let waveColor = UIColor.init(red: 1, green: 237/255, blue: 241/255, alpha: 1)
    let recordingPinkColor = UIColor.init(red: 1, green: 0, blue: 149/255, alpha: 1)
    
    //顯示辨識字的label
    @IBOutlet weak var recogTextLabel: UILabel!
    
    //句子中文label
    @IBOutlet weak var chiSentenceLabel: UILabel!
    
    //句子英文label
    @IBOutlet weak var sentenceLabel: UILabel!
    
    //錄音鍵
    @IBOutlet weak var recordBtn: UIButton!
    
    //接收數字
    var spotNumber = Int()
    var unitNumber = Int()
    var mapNumber = Int()
    var gameMode = Int()

    
    //辨識聲音用的變數
    
    var speechRecognizer = SFSpeechRecognizer()!
    
    let audioEngine = AVAudioEngine()
    var recognitionRequest:SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask:SFSpeechRecognitionTask?
 
    //暫時使用的句子
    var sentenceSets = [String]()
    
     var allSentenceSets = [[String]]()
    
    //音波用的變數
    var timer:Timer?
    var change:CGFloat = 0.01
    @IBOutlet weak var audioView: SwiftSiriWaveformView!
    
    //辨識的答案
    var wordToReceive = String()
    //辨識所錄到的聲音
    var wordRecorded = String()
    
    //發音的句子名稱
    var sentenceToPronounce = String()
    
    //辨識單字是否正確
    var isRecogWordCorrect = Bool()
    
    //所收到的單字次序
    var wordSequenceToReceive = String()
    
    //句子的文字
    var sentence = String()
    
    //是否是在確認句子
    var isCheckingSentence = Bool()
    
    
    //所選到的tag
    //var tagsSelected = [String]()
    
    var attrTagsSelected = [NSMutableAttributedString]()

    //製作tag
    @IBOutlet weak var tagView: TagListView!

    //這兩個應該用不到
    var player: AVAudioPlayer?
    var mp3FileName = String()
    
    
    //發音單字
    var synWord = String()
    
    //Text to speech合成器
    var synth = AVSpeechSynthesizer()
    
    @IBOutlet weak var resultBg: UIImageView!
    
    @IBOutlet weak var coverBg: UIImageView!
    @IBOutlet weak var firstWordBtn: UIButton!
    
    @IBOutlet weak var secondWordBtn: UIButton!
    @IBOutlet weak var thirdWordBtn: UIButton!
    //避免按鍵
    @IBOutlet weak var coverBtn: UIButton!
    
    @IBOutlet weak var firstEngWord: UILabel!
    
    @IBOutlet weak var secondEngWord: UILabel!
    @IBOutlet weak var thirdEngWord: UILabel!
    @IBOutlet weak var firstChiWord: UILabel!
    
    @IBOutlet weak var secondChiWord: UILabel!
    
    @IBOutlet weak var bigOkBtn: UIButton!
    @IBOutlet weak var thirdChiWord: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    var answerTime = 0
 
    //用來顯示正確與否
    var wordBtns = [UIButton]()
    
    //我的字集
    var myWords = [String]()
    //抓字上傳後台使用
    var firstEngWordText = String()
    var secondEngWordText = String()
    var thirdEngWordText = String()
    var isParseEnabled = true
    
    @IBOutlet weak var wordCountLabel: UILabel!
    
    let word1Label = UILabel()
    let word2Label = UILabel()
    let word3Label = UILabel()

    let inCircle = UIImageView()
    let midCircle = UIImageView()
    let outCircle = UIImageView()
    
    var isCelebratingMapPassed = false
    
    //@IBOutlet weak var talkCircle: UIView!
    
    //用來顯示正確答案的變數, 保留標點符號大小寫
    var completeWordsToShow = String()
    var sentenceTag = [String]()
    
    //錄音動畫
    var recordingIndicator:NVActivityIndicatorView?
    //var pointsIndicator:NVActivityIndicatorView?
    
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var waitTimer = Timer()
    //紀錄錯誤發音字
    
    let relevantWords:[[String:[String]]] = [["and":["n","end","in"]], ["ant":["aunt", "and"]], ["ham":["pam"]], ["age":["h"]], ["base":["pace", "bass"]], ["bake":["bank"]], ["aim":["m", "am", "game", "i am", "came"]], ["yam":["yeah", "I'm", "game", "damn"]], ["cause":["calls", "plus", "cost", "course", "cocks", "cox"]], ["pause":["paul's", "pose", "pass"]], ["be":["b", "bit", "been", "p"]], ["beneath":["the neath"]], ["bass":["based", "base", "best"]], ["bag":["back"]], ["badge":["batch", "bage"]], ["bin":["pen", "been"]], ["as":["s"]], ["dawn":["don", "done", "dan"]], ["draw":["drawl", "jaw"]], ["bit":["but", "beat"]], ["by":["bye", "buy"]], ["bomb":["mom"]], ["bond":["pond", "and on"]], ["crab":["crap", "cram"]], ["bee":["b", "bg", "be", "p"]], ["employ":["i love ploy", "employee"]], ["ear":["here"]], ["few":["feel"]], ["sea":["c", "see", "sing"]], ["end":["and"]], ["hen":["hand", "ham"]], ["pet":["pat", "at"]], ["fog":["fuck"]], ["dew":["do you", "due", "do"]], ["lift":["left"]], ["donkey":["thank u"]], ["fill":["feel"]], ["grade":["great"]], ["grape":["greatg"]], ["grass":["quest"]], ["hill":["he'll"]], ["his":["yes", "he's"]], ["kid":["can't"]], ["lid":["lead", "let"]], ["high":["hi"]], ["miss":["mess", "bass"]], ["sir":["siri"]], ["ill":["io", "yell"]], ["lip":["that", "nap", "leap"]], ["leg":["lag"]], ["less":["les"]], ["kneepad":["hey pat", "we pack", "kneepad", "the pad"]], ["ring":["rain", "rheem"]], ["king":["teen", "10"]], ["ink":["inc."]], ["pin":["pain", "penn"]], ["did":["dead", "dig"]], ["dig":["dick"]], ["rhino":["right now"]], ["mind":["mine"]], ["bone":["born"]], ["tone":["porn", "turn"]], ["omit":["almonds", "almond", "i meet", "i'll meet", "a mitt"]], ["of":["off"]], ["offspring":["of spring"]], ["old":["owed"]], ["cold":["code"]], ["bow":["wow"]], ["sit":["set"]], ["sin":["send", "seen"]], ["red":["read", "rat"]], ["pig":["pick"]], ["very":["barry"]], ["carry":["carrie"]], ["ski":["schey"]], ["skill":["scale"]], ["tick":["take"]], ["tin":["10", "ten", "teen"]], ["fifty":["50"]], ["sixty":["60"]], ["to":["2", "two"]], ["rub":["rob"]], ["bun":["bon"]], ["gun":["gone"]], ["cup":["prop", "cop"]], ["drum":["john", "from"]], ["dumb":["dom", "damn"]], ["gain":["can", "game", "dan"]], ["cut":["caught"]], ["nut":["not", "nuts", "that's"]], ["burn":["born"]], ["surf":["sorry", "serve"]], ["sad":["said"]], ["accept":["a sept", "except"]], ["principle":["principal"]], ["atom":["adam", "at tom", "at ten", "at them"]], ["far":["fart"]], ["lawyer":["law yer", "law your"]], ["seesaw":["cecil"]], ["mat":["matt", "that"]], ["May":["mei", "main"]], ["gram":["graham"]], ["jam":["jan"]], ["pan":["pam"]], ["behave":["behalf", "we have"]], ["mass":["mas"]], ["haunted":["hunted"]], ["lack":["leg"]], ["neck":["nick", "mac"]], ["niece":["nice"]], ["column":["caller", "call him"]], ["colleague":["cardi", "kolic", "connie"]], ["wet":["what"]], ["media":["pedia"]], ["done":["don", "dan"]], ["dollar":["daughter"]], ["dry":["trying"]], ["bean":["being", "been"]], ["tea":["t", "tee"]], ["pen":["pam", "pan"]], ["lend":["land"]], ["sight":["site"]], ["hit":["hits"]], ["hippo":["hipple", "people"]], ["goal":["call"]], ["loaf":["love"]], ["sing":["seen", "same"]], ["thing":["fin", "fan", "thin"]], ["will":["we'll"]], ["till":["teal"]], ["mill":["mail", "male", "meal"]], ["win":["when", "wayne"]], ["wing":["wayne", "win", "when"]], ["among":["a man", "i'm on"]], ["iron":["i am"]], ["neon":["young"]], ["ours":["hours"]], ["rot":["rat"]], ["pot":["part"]], ["born":["porn"]], ["door":["don't worry", "dori"]], ["cow":["cal"]], ["town":["towel"]], ["prize":["price"]], ["marry":["merry", "mary"]], ["both":["bath", "ballf"]], ["sun":["son"]], ["hide":["height", "hi"]], ["due":["do you", "do", "dew", "dude"]], ["June":["john", "joan"]], ["rule":["drool"]], ["rude":["dude"]], ["gesture":["chester", "just trailer", "just your", "juster"]], ["eighty":["80", "eddie"]], ["thumb":["foam", "psalm"]], ["ketchup":["catch up"]], ["main":["man", "mane"]], ["band":["and"]], ["ladder":["leather", "other"]], ["daddy":["that he"]], ["whale":["well", "we'll"]], ["burst":["first"]], ["lamb":["let", "land"]], ["climate":["climb at", "climat"]], ["piece":["peace"]], ["place":["please", "play's"]], ["rat":["got", "rhett"]], ["battle":["that'll"]], ["drawer":["droller"]], ["autumn":["i'll touch", "alton"]], ["way":["we"]], ["liter":["litter", "letter", "later"]], ["ten":["pam", "can", "tin", "10"]], ["tent":["pant"]], ["deer":["beer", "dear"]], ["grey":["gray"]], ["obey":["i'll be"]], ["bucket":["buckets"]], ["tempo":["temple"]], ["nose":["knows"]], ["role":["roll", "raw"]], ["hire":["higher"]], ["skirt":["scarred"]], ["thirty":["30"]], ["bowling":["morning", "welding"]], ["ceiling":["sitting"]], ["fork":["fort"]], ["form":["foreign"]], ["more":["morning"]], ["fool":["for"]], ["aloud":["allowed"]], ["parrot":["pirate"]], ["ninety":["nighty", "90"]], ["quiz":["chris", "please"]], ["path":["pat", "pass"]], ["than":["then", "van"]], ["shoe":["she'll", "sure"]], ["gate":["kate"]], ["hate":["eight"]], ["hang":["hannah", "hand", "i am", "ham"]], ["sand":["send"]], ["admire":["at the meyer", "edmeyer"]], ["advise":["advice", "a device"]], ["whole":["call", "hall"]], ["whose":["who's", "who is"]], ["wheel":["we'll", "we"]], ["tall":["call", "paul"]], ["pair":["prayer"]], ["ease":["is"]], ["crayon":["korean", "quinn"]], ["dock":["talk", "dark"]], ["faucet":["fossett"]], ["itself":["it's self"]], ["race":["raise"]], ["knight":["night", "nights"]], ["rose":["roast"]], ["toad":["told", "towed"]], ["fond":["found"]], ["monk":["monarch", "month"]], ["noon":["no", "no one"]], ["move":["movie"]], ["foul":["fall", "follow"]], ["bounce":["taos"]], ["male":["mail"]], ["shut":["shot"]], ["bathe":["beef"]], ["badminton":["that minton", "abington", "babington"]], ["naughty":["knotty"]], ["granddaughter":["when dollar", "where daughter", "when daughter"]], ["twice":["pies"]], ["sail":["sale"]], ["tail":["pale"]], ["star":["*", "start"]], ["trial":["kyle", "child", "cheil"]], ["dial":["i'll", "kyle"]], ["coin":["calling"]], ["thin":["then", "fin"]], ["maximum":["messy mom"]], ["knee":["me"]], ["owner":["almost there", "on their"]], ["sell":["sale", "cell"]], ["leaf":["leave"]], ["flour":["flower"]], ["root":["route"]], ["blow":["hello", "below"]], ["bowl":["ball"]], ["grow":["grill", "roll"]], ["railroad":["rail road"]], ["raincoat":["wrinkled"]], ["alone":["along"]], ["mole":["ball", "more", "mall"]], ["hose":["house", "holes"]], ["word":["where"]], ["wedding":["waiting"]], ["thirtieth":["30th"]], ["twirl":["pearl", "twhirl", "thorough"]], ["ego":["eagle"]], ["name":["ma'am"]], ["ninth":["knife", "nice", "mines"]], ["shall":["sure", "scholl", "shell"]], ["six":["6"]], ["curtain":["carton"]], ["lead":["bead", "dead", "did"]], ["angel":["angil"]], ["need":["me"]], ["seem":["seeing", "same"]], ["pound":["pilot", "now"]], ["forty":["40"]], ["room":["ram"]], ["soon":["so in", "sean"]], ["ride":["right"]], ["rise":["lies", "rice"]], ["low":["no", "loel", "lol"]], ["own":["on", "all"]], ["know":["no"]], ["ruler":["reuther"]], ["their":["there"]], ["pale":["pio"]], ["race":["raise"]], ["plain":["plane"]], ["raise":["race"]], ["buy":["bye", "by"]], ["garden":["pardon"]], ["kilogram":["program"]], ["necklace":["nicolas"]], ["seek":["see"]], ["tool":["cool", "pool"]], ["wood":["would"]], ["woods":["what's"]], ["gym":["jane", "james", "jim", "jean", "gen"]], ["north":["no wife"]], ["row":["roll", "raw"]], ["fence":["sence", "sense", "thanks"]], ["deaf":["-", "def"]], ["tangerine":["thank you rain"]], ["beam":["boehm", "been"]], ["cent":["sent"]], ["thick":["fake", "sick", "fick"]], ["thief":["fief"]], ["safe":["save"]], ["shine":["shall i"]], ["childish":["ciao dish"]], ["guard":["god"]], ["wife":["weiss"]], ["sting":["stain", "steam"]], ["yourself":["your self"]], ["yourselves":["your selves"]], ["invent":["event"]], ["since":["sence", "scenes", "sense", "sings"]], ["sincere":["since year", "since you"]], ["tear":["cheer"]], ["boost":["post"]], ["goose":["close"]], ["train":["chain", "friend"]], ["waist":["waste"]], ["stair":["stare"]], ["twelfth":["12th"]], ["cellphone":["cell phone"]], ["many":["manny", "manning"]], ["planner":["planer"]], ["passenger":["messenger"]], ["alike":["i like"]], ["alive":["i life", "a life", "life"]], ["narrow":["nero", "natural"]], ["ground":["grounded", "grout"]], ["shore":["sure"]], ["spoon":["spohn", "splinter"]], ["crust":["quest", "cost", "cross", "crossed"]], ["eleven":["11"]], ["were":["where"]], ["daredevil":["there devil"]], ["pillow":["pelo"]], ["chin":["chain"]], ["stray":["straight"]], ["playground": ["play ground"]], ["write":["right"]], ["spend":["spand"]], ["yellow":["hello"]], ["still":["steel"]], ["tenth":["10", "10th"]], ["twenty":["20"]], ["restroom":["restaurant"]], ["eager":["either"]], ["omnipresent":["omni present", "i'm the present"]], ["scan":["scam"]], ["dazzle":["diesel"]], ["barber":["bubber", "barbara"]], ["armchair":["i'm chair", "arm chair"]], ["bed":["bad", "that"]], ["bedding":["heading", "betting"]], ["tailor":["paid her", "pedro", "taylor", "tater"]], ["debt":["that"]], ["doubtful":["duffel"]], ["amend":["amended"]], ["cable":["table"]], ["careless":["care less", "kelis"]], ["bitter":["peter"]], ["hear":["here"]], ["weary":["wearing"]], ["hobby":["abi", "happy"]], ["display":["let's play"]], ["dismiss":["this mess"]], ["cycle":["psycho"]], ["watermelon":["what a melon"]], ["laugh":["left"]], ["numb":["nom", "mom", "num", "nam"]], ["bomb":["mom"]], ["comb":["calm"]], ["humid":["you meant"]], ["assign":["a sign"]], ["housework":["how's work"]], ["noun":["known", "now"]], ["exist":["it's sixth"]], ["vest":["best"]], ["fist":["thirst"]], ["Walkman":["look man"]], ["strong":["stronger"]], ["young":["john"]], ["lung":["lawn", "loan", "lon"]], ["slang":["slam"]], ["taxi":["taxie"]], ["calm":["come"]], ["foreign":["flooring", "forane"]], ["golf":["cough"]], ["typhoon":["iphone"]], ["miner":["minor"]], ["microwave":["michael way"]], ["hound":["hi loved", "how", "hell", "how old"]], ["mud":["martha"]], ["mudslide":["must light", "mud slide", "most light"]], ["stove":["stealth"]], ["meat":["meet"]], ["least":["beast"]], ["kettle":["cuddle", "cattle"]], ["swan":["suong"]], ["cattle":["tattle"]], ["decide":["decided"]], ["carpet":["corporate"]], ["cartoon":["carton"]], ["course":["coris"]], ["balloon":["but when"]], ["fifteen":["15"]], ["fifteenth":["15th"]], ["yarn":["john", "jan"]], ["bookcase":["book case", "bouquets"]], ["manner":["mandor"]], ["clerk":["bonarck", "croak", "craig", "choleric"]], ["think":["thank", "fin"]], ["fourteen":["14"]], ["fourteenth":["14th"]], ["shorten":["sorry"]], ["four":["fort", "4", "for"]], ["fancy":["thanks he"]], ["blanket":["blankets"]], ["desert":["dessert"]], ["kangaroo":["bangaru"]], ["sidewalk":["so i walk"]], ["nineteen":["19"]], ["nineteenth":["19th"]], ["boast":["post"]], ["platform":["my phone"]], ["kindergarten":["can you gotten", "can you garden"]], ["steal":["steel"]], ["stream":["straight"]], ["dozen":["doesn't", "does"]], ["woolly":["hooley"]], ["decorate":["the correct"]], ["seventeen":["17"]], ["sleepover":["sleep over"]], ["wound":["warned", "owned", "wind", "orland"]], ["entrance":["entress"]], ["sixteen":["six team", "16"]], ["sixteenth":["16th"]], ["altogether":["i'll together"]], ["factory":["factoring"]], ["mourn":["morning"]], ["dough":["door", "dough"]], ["doughnut":["donut", "donuts", "doughnuts"]], ["medal":["metal", "middle"]], ["alright":["all right"]], ["evening":["evelyn"]], ["gentleman":["gentlemen"]], ["meaning":["minute", "minden"]], ["honor":["partner"]], ["forehead":["for head"]], ["icecream":["ice cream"]], ["succeed":["secede"]], ["thirteen":["13"]], ["thirteenth":["13th"]], ["color":["caller"]], ["honor":["other", "on their"]], ["eighteen":["18"]], ["eighteenth":["18th"]], ["influence":["inference"]], ["error":["eric"]], ["sightseeing":["sizing", "site seeing", "sight seeing"]], ["sailor":["saito", "seller", "seiter"]], ["weekend":["we can", "we can't"]], ["oven":["arvin", "alvin"]], ["river":["reverb"]], ["head":["had"]], ["seventy":["70"]], ["seventh":["7th"]], ["steak":["stick", "stuck"]], ["pleasure":["plazier"]], ["breath":["breast"]], ["breathe":["brief", "breeze", "breve"]], ["brand":["brenda"]], ["bet":["but"]], ["bettor":["better"]], ["barn":["born"]], ["ban":["bam"]], ["concern":["concerned"]], ["wear":["where"]], ["whether":["weather"]], ["sweater":["sweeter", "spider"]], ["pear":["pair"]], ["sudden":["southern"]], ["awaken":["we can"]], ["aware":["where"]], ["ban":["been", "bam", "bang", "ben"]], ["bang":["banging"]], ["bar":["art", "barley", "bari"]], ["bargain":["oregon"]], ["barn":["on", "porn"]], ["bleed":["plead", "believe it", "believe", "belief"]], ["breast":["rest"]], ["marble":["mobile", "moble"]]]
    
    
    
    let wrongPronounceWords:[[String:[String]]] = [["烘焙":["烘陪"]], ["affect":["a fect"]], ["頭髮":["頭法"]], ["campaign":["cam pain"]], ["和":["汗"]], ["woman":["wo men"]], ["snowman":["snow man"]], ["fisherman":["fisher man"]], ["gentleman":["gentle man"]], ["supermarket":["super market"]], ["劣拙地":["列濁地"]], ["begin":["be ghing"]], ["巧克力":["巧顆粒"]], ["lead":["leed"]], ["tear":["tee er"]], ["度數":["度樹"]], ["年紀較長的":["年紀較漲的"]], ["告訴":["吿速"]], ["envelope":["anvelope"]], ["sensor":["sen sir"]], ["友誼":["有宜"]], ["kilometer":["killa meter"]], ["桶子":["統子"]], ["油炸":["油柵"]], ["外框":["外筐"]], ["高麗菜":["高力菜"]], ["油炸的":["油柵的"]], ["磨坊":["魔訪"]], ["螫":["遮"]], ["kneepad":["knee pad"]], ["iron":["eye ern"]], ["歌曲":["哥取"]], ["鵝":["蛾"]], ["forehead":["fore head"]], ["數":["鼠"]], ["April":["eigh pro"]], ["重播":["蟲剝"]], ["槳糊":["降胡"]], ["stupid":["stubid"]], ["錫":["習"]], ["曲線":["娶線"]], ["風箏":["風蒸"]], ["comb":["kome"]], ["wolf":["wallf"]], ["absurd":["a bsurd"]]]
    
    @IBOutlet weak var sen1Btn: UIButton!
    
    @IBOutlet weak var sen2Btn: UIButton!
    
    @IBOutlet weak var sen3Btn: UIButton!
    
    @IBOutlet weak var sen4Btn: UIButton!
    
    
    var allUnitSpotNums = [[Int]]()
    
    var randomSpots = [Int]()
    var randomUnits = [Int]()
    
    
    var allRandomSens = [[Int:Int]]()
    
    
    var allBtns = [UIButton]()
    
    var correctRandom = Int()
    
    let correctSign = UIImageView()
    let wrongSign = UIImageView()
    
    var btnTimer = Timer()
    var timerCount = 0
    
    var chiSentence = String()
    
    //所有alertView的變數
    var alertBg = UIImageView()
    var alertText = UILabel()
    var ghostBtn = UIButton()
    var quitBtn = UIButton()
    var cancelBtn = UIButton()
    var leftBtnClickedImg = UIImageView()
    var rightBtnClickedImg = UIImageView()
    let darkRed = UIColor.init(red: 192/255, green: 40/255, blue: 75/255, alpha: 1)

    var isCountingTriggered = false
    
    var audioSession = AVAudioSession.sharedInstance()
    
    @IBOutlet weak var playSoundBtn: UIButton!
    
    var courseReceived = Int()
    var gamePassedDic:[Int:Int]?
    var mapPassedInt = Int()
    var increaseNum = Int()
    var maxSpotNum = Int()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var dif = CGFloat()
        var senLabelHeightDif = CGFloat()
        var iPadDif = CGFloat()
        var btnDif = CGFloat()
                var xDif = CGFloat()
        
        switch height {
        case 812:
            xDif = 1.2
            btnDif = 1
            dif = 1.15
            senLabelHeightDif = 0.7
            iPadDif = 1
        case 736:
            xDif = 1
            btnDif = 1.1
            dif = 1.1
            senLabelHeightDif = 0.78
            iPadDif = 1
            
        case 667:
            xDif = 1
            btnDif = 1
            dif = 1
            senLabelHeightDif = 0.9
            iPadDif = 1
            
        case 568:
            xDif = 1
            btnDif = 0.9
            dif = 0.9
            senLabelHeightDif = 1
            iPadDif = 1
            
        default:
            xDif = 1
            btnDif = 0.9
            dif = 0.9
            senLabelHeightDif = 1
            iPadDif = 1.2
            
        }
        
        
        /*
        switch courseReceived {
            
        case 0:
            
            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            
        case 1:
            
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            
        default:
            break
        
        }
        */
        // Do any additional setup after loading the view.
       
        //暫時測試畫面使用
        
        //加入alertView
        let lightGray = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.58)
        ghostBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        ghostBtn.backgroundColor = lightGray
        //ghostBtn.addTarget(self, action: #selector(LessonViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(ghostBtn)
        
        alertBg.frame = CGRect(x: (width - 237 * dif) / 2, y: height * 2 /  5, width: width * 237 / 375, height: height * 140 / 667)
        alertBg.image = UIImage(named: "reviewSelectBg.png")
        self.view.addSubview(alertBg)
        
        alertText.frame = CGRect(x: 5 * dif , y: 5 * dif, width: alertBg.frame.width - 5 * dif * 2, height: alertBg.frame.height / 2)
        alertText.font = UIFont(name: "Helvetica Neue Bold", size: 34)
        alertText.textColor = .white
        alertText.text = "\n離開目前課程\n學習進度不會儲存!"
        alertText.numberOfLines = 0
        alertText.textAlignment = .center
        alertText.adjustsFontSizeToFitWidth = true
        alertBg.addSubview(alertText)
        
        
   
        
        cancelBtn.frame = CGRect(x: alertBg.frame.minX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(darkRed, for: .normal)
        cancelBtn.addTarget(self, action: #selector(NewGameViewController.removeBtns), for: .touchUpInside)
        self.view.addSubview(cancelBtn)
        
        quitBtn.frame = CGRect(x: cancelBtn.frame.maxX, y: alertBg.frame.maxY - 44 * dif * xDif, width: alertBg.frame.width / 2, height: height * 44 / 667)
        quitBtn.setTitle("離開", for: .normal)
        quitBtn.setTitleColor(darkRed, for: .normal)
        quitBtn.addTarget(self, action: #selector(NewGameViewController.leaveWithoutSaving), for: .touchUpInside)
        self.view.addSubview(quitBtn)
        
        leftBtnClickedImg.frame = cancelBtn.frame
        leftBtnClickedImg.image = UIImage(named: "leftBtnClickedImg.png")
        
        rightBtnClickedImg.frame = quitBtn.frame
        rightBtnClickedImg.image = UIImage(named: "rightBtnClickedImg.png")
        
        self.view.addSubview(leftBtnClickedImg)
        self.view.addSubview(rightBtnClickedImg)
        leftBtnClickedImg.alpha = 0
        rightBtnClickedImg.alpha = 0

        
        
        coverBg.image = UIImage(named:"coverBg.png")
        resultBg.image = UIImage(named:"resultBg.png")
        
        coverBtn.isHidden = true
        coverBg.isHidden = true
        resultBg.isHidden = true
        firstWordBtn.isHidden = true
        secondWordBtn.isHidden = true
        thirdWordBtn.isHidden = true
        bigOkBtn.isHidden = true
        bigOkBtn.setImage(UIImage(named:"bigOkBtn.png"), for: .normal)
        firstWordBtn.isEnabled = false
        secondWordBtn.isEnabled = false
        thirdWordBtn.isEnabled = false
        
        
        
        sen1Btn.frame = CGRect(x:(width - 350 * dif) / 2, y: height / 2 , width: 350 * dif, height: 57 * dif)
        
        sen2Btn.frame = CGRect(x:(width - 350 * dif) / 2, y: sen1Btn.frame.maxY + 20 * dif, width: 350 * dif, height: 57 * dif)
        
        sen3Btn.frame = CGRect(x:(width - 350 * dif) / 2, y: sen2Btn.frame.maxY + 20 * dif , width: 350 * dif, height: 57 * dif)
        
        sen4Btn.frame = CGRect(x:(width - 350 * dif) / 2, y: sen3Btn.frame.maxY + 20 * dif , width: 350 * dif, height: 57 * dif)
        

        allBtns.append(sen1Btn)
        allBtns.append(sen2Btn)
        allBtns.append(sen3Btn)
        allBtns.append(sen4Btn)
        
        for btn in allBtns{
            
            btn.isHidden = true
        }
        
        
        //layOut
        
        
        resultBg.frame = CGRect(x: (width - 280 * dif) / 2, y: height / 8, width: 280 * dif, height: 488 * dif)
        firstWordBtn.frame = CGRect(x: resultBg.frame.origin.x + ((resultBg.frame.width - (519 / 2 * dif)) / 2), y: resultBg.frame.midY - resultBg.frame.height / 20, width: 519 / 2 * dif, height: 57 * dif)

        
        secondWordBtn.frame = CGRect(x: firstWordBtn.frame.origin.x, y: firstWordBtn.frame.maxY +  15 * dif, width: firstWordBtn.frame.width, height: firstWordBtn.frame.height)
        
        thirdWordBtn.frame = CGRect(x: firstWordBtn.frame.origin.x, y: secondWordBtn.frame.maxY + 15 * dif, width: firstWordBtn.frame.width, height: firstWordBtn.frame.height)
        
        
        firstEngWord.frame = CGRect(x: firstWordBtn.frame.minX + 20 * dif, y: firstWordBtn.frame.minY + 12 * dif, width: 208 * dif, height: 35 * dif)
        firstChiWord.frame = CGRect(x: firstWordBtn.frame.maxX - 89 * dif, y: firstWordBtn.frame.minY + 16 * dif, width: 69 * dif, height: 28 * dif)
        
        secondEngWord.frame = CGRect(x: firstWordBtn.frame.minX + 20 * dif, y: secondWordBtn.frame.minY + 12 * dif, width: 208 * dif, height: 35 * dif)
        secondChiWord.frame = CGRect(x: firstWordBtn.frame.maxX - 89 * dif, y: secondWordBtn.frame.minY + 16 * dif, width: 69 * dif, height: 28 * dif)
        
        thirdEngWord.frame = CGRect(x: firstWordBtn.frame.minX + 20 * dif, y: thirdWordBtn.frame.minY + 12 * dif, width: 208 * dif, height: 35 * dif)
        thirdChiWord.frame = CGRect(x: firstWordBtn.frame.maxX - 89 * dif, y: thirdWordBtn.frame.minY + 16 * dif, width: 69 * dif, height: 28 * dif)
        
        
        bigOkBtn.frame = CGRect(x: resultBg.frame.minX + ((resultBg.frame.width - (210 * dif)) / 2), y: resultBg.frame.maxY - 40 * dif * iPadDif, width: 210 * dif, height: 29 * dif)
        
        
        scoreLabel.frame = CGRect(x: resultBg.frame.maxX - 140 * dif, y: resultBg.frame.minY + 53 * dif, width: 106 * dif, height: 21 * dif)
        
        
        wordCountLabel.frame = CGRect(x: resultBg.frame.minX + 50 * dif, y: resultBg.frame.minY + 140 * dif, width: 157 * dif, height: 95 * dif)
        wordCountLabel.adjustsFontSizeToFitWidth = true
        
        sentenceLabel.frame = CGRect(x: (width - (width - 50 * dif)) / 2, y: height / 10, width: width - 50 * dif, height: height / 4.6 * dif * senLabelHeightDif)
        chiSentenceLabel.frame = CGRect(x: (width - (width - 50 * dif)) / 2, y: sentenceLabel.frame.maxY + 10 * dif, width: sentenceLabel.frame.width, height: height / 10 * dif)
        sentenceLabel.adjustsFontSizeToFitWidth = true
        chiSentenceLabel.adjustsFontSizeToFitWidth = true
        coverBg.frame = CGRect(x: 0, y: 0, width: width, height: height)
        coverBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        recogTextLabel.frame = CGRect(x: 0, y: height * 2 / 5, width: width, height: height / 5)
       //recogTextLabel.backgroundColor = .yellow
        //做三個對話圓

        /*
        outCircle.frame.size = CGSize(width: 230, height: 230)
        outCircle.center = CGPoint(x: 187, y: 500)
        outCircle.image = UIImage(named:"outCircle.png")
        view.addSubview(outCircle)
        midCircle.frame.size = CGSize(width: 150, height: 150)
        midCircle.center = CGPoint(x: 187, y: 500)
        midCircle.image = UIImage(named:"midCircle.png")
        view.addSubview(midCircle)
        inCircle.frame.size = CGSize(width: 90, height: 90)
        inCircle.center = CGPoint(x: 187, y: 500)
        inCircle.image = UIImage(named:"inCircle.png")
        view.addSubview(inCircle)
        */
        word1Label.frame = CGRect(x: firstWordBtn.frame.width / 3, y: 0, width: firstWordBtn.frame.width / 3, height: firstWordBtn.frame.height)
        word1Label.textColor = .white
        word1Label.font = UIFont(name: "Helvetica Bold", size: 14)
        word1Label.text = "加入最愛"
        word1Label.textAlignment = .center
        word1Label.alpha = 0
        self.firstWordBtn.addSubview(word1Label)
       
        word2Label.frame = CGRect(x: secondWordBtn.frame.width / 3, y: 0, width: secondWordBtn.frame.width / 3, height: secondWordBtn.frame.height)
        word2Label.textColor = .white
        word2Label.font = UIFont(name: "Helvetica Bold", size: 14)
        word2Label.text = "加入最愛"
        word2Label.textAlignment = .center
        word2Label.alpha = 0
        self.secondWordBtn.addSubview(word2Label)

        word3Label.frame = CGRect(x: thirdWordBtn.frame.width / 3, y: 0, width: thirdWordBtn.frame.width / 3, height: thirdWordBtn.frame.height)
        word3Label.textColor = .white
        word3Label.font = UIFont(name: "Helvetica Bold", size: 14)
        word3Label.text = "加入最愛"
        word3Label.textAlignment = .center
        word3Label.alpha = 0
        self.thirdWordBtn.addSubview(word3Label)
        
        recordBtn.frame = CGRect(x: (width - 128 * dif) / 2, y: height - 180 * dif, width: 128 * dif, height: 128 * dif)
        
        
        //載入我的最愛單字
        if let myWordsString = user!["myWords"] as! String?{
            myWords = myWordsString.components(separatedBy: ";")
            
        }
        
        wordBtns.append(firstWordBtn)
        wordBtns.append(secondWordBtn)
        wordBtns.append(thirdWordBtn)
        
        //設定delegate來監控讀音
        synth.delegate = self
        
        //設定好tagView
        tagView.backgroundColor = .clear
        tagView.delegate = self
        tagView.isHidden = true
        
        tagView.frame = CGRect(x: width / 20, y: height * 3 / 5, width: width - width / 10, height: height / 2.7 * dif * senLabelHeightDif / iPadDif)
        
        tagView.textFont = UIFont.boldSystemFont(ofSize: 30)
       
        //辨識字的大小設定
        recogTextLabel.adjustsFontSizeToFitWidth = true
        
        //wave畫面設定
        audioView.isHidden = true
        audioView.backgroundColor = .clear
        audioView.density = 1
        audioView.numberOfWaves = 5
        audioView.secondaryLineWidth = 1
        audioView.amplitude = 0.1
        audioView.alpha = 0.7
        audioView.waveColor = recordingPinkColor
        audioView.frame = CGRect(x: 0, y: height - 158 * dif, width: width, height: height / 6.5)
        
        //設定發音鍵
        playSoundBtn.frame = CGRect(x: width - 35 * dif * 1.5, y: height - 23 * dif * 1.5, width: 35 * dif, height: 23 * dif)
        
        
        //離開遊戲
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.leaveGame), name: NSNotification.Name("leaveGame"), object: nil)
        
        //接收發音 - ok
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pronounceWord), name: NSNotification.Name("pronounceWord"), object: nil)
        //接收口試NC (單字 + 句子)
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.startToRecognize), name: NSNotification.Name("startToRecognize"), object: nil)
        
        //啟動聽考拼寫
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyBackToSpell), name: NSNotification.Name("backToSpell"), object: nil)
        //接收做句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showSentence), name: NSNotification.Name("showSentence"), object: nil)
        
        //啟動下個單字
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("practiceNextWord"), object: nil)
        
        
        //啟動計分
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyAddScore), name: NSNotification.Name("addScore"), object: nil)
        
        //啟動倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyStartCountDown), name: NSNotification.Name("startCountDown"), object: nil)
        
        //接收時間到, 利用別的func來刪除畫面
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyPracticeNextWord), name: NSNotification.Name("timesUp"), object: nil)

        
        //接收顯示tagView內容
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.showTag), name: NSNotification.Name("showTag"), object: nil)
        

        //通知句子念完要準備口試
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyReadyToReadSentence), name: NSNotification.Name("readyToReadSentence"), object: nil)
        
        
        //準備口試句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.readSentence), name: NSNotification.Name("readSentence"), object: nil)
        
        
        //接收練習句子
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.onlyPracticeSentence), name: NSNotification.Name("onlyPracticeSentence"), object: nil)
        
        
        //從gameScene時間到來接收restartGame2
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.game2RestartFunc), name: NSNotification.Name("restartGame2"), object: nil)
        
        
        //接收暫停功能
                NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.pauseGame), name: NSNotification.Name("pause"), object: nil)
        
        //重新倒數
        NotificationCenter.default.addObserver(self, selector: #selector(NewGameViewController.notifyRestartCounting), name: NSNotification.Name("restartCounting"), object: nil)
        
        
        //先隱藏錄音及辨識
        recordBtn.isHidden = true

        recogTextLabel.isHidden = true
        
        
        
        //讀目前課程數字數量
        switch courseReceived {
            
        case 0:

            gamePassedDic = gamePassed!
            mapPassedInt = mapPassed!
            increaseNum = 0
            maxSpotNum = 14

            
        case 1:
            
            gamePassedDic = gamePassed2!
            mapPassedInt = mapPassed2!
            increaseNum = 5
            maxSpotNum = 13
            
        default:
            break
            
        }
        
        //讀取Bundle裡的句子
        var sentenceFile:String?
        
        
        if gameMode == 0 {
        
        //這裡的mapNum 已經加過increaseNum
        let sentenceName = "s" + String(mapNumber + 1) + "-" + String(spotNumber + 1)
        
        if let filepath = Bundle.main.path(forResource: sentenceName, ofType: "txt") {
            do {
                sentenceFile = try String(contentsOfFile: filepath)
                let sentences = sentenceFile?.components(separatedBy: "; ")
                
                //把字讀取到wordSets裡
                sentenceSets = sentences!
                //print(contents)
            } catch {
                // contents could not be loaded
                print("catch error")
            }
        } else {
            // example.txt not found!
            print("txt can't be found")
        }
            
        } else if gameMode == 2 {
            
            

            //隨機單字
            //在此抓測驗單字的亂數順序
            
            for (s,u) in gamePassedDic!{
                
                //1. 填入spot上限供亂數選擇
                
                //填入全部
                if s > 0 {
                    
                    allUnitSpotNums = [Array<Any>](repeating: [Int](), count: s + 1) as! [[Int]]
                    
                    for i in 0 ..< (s) {
                        
                        for n in 0 ..< 30{
                            
                            allUnitSpotNums[i].append(n)
                            
                        }
                        
                    }
                    
                    //填入殘值
                    if u > 0 {
                        
                        for i in 0 ..< u * 3 {
                            
                            allUnitSpotNums[allUnitSpotNums.count - 1].append(i)
                            
                        }
                    } else {
                        
                        
                        allUnitSpotNums.remove(at: allUnitSpotNums.count - 1)
                        
                    }
                    
                //    print(allUnitSpotNums)
                    
                } else {
                    
                    allUnitSpotNums = [Array<Any>](repeating: [Int](), count: 1) as! [[Int]]
                    //填入殘值
                    
                    //如果只過一關, 加入四個句子去隨機選項
                    if u == 1 {
                        
                        for i in 0 ..< 4 {
                            
                            allUnitSpotNums[0].append(i)
                            
                        }

                        
                        
                        //超過一關就直接隨機所有學過句子
                    } else if u > 0 {
                        
                        for i in 0 ..< u * 3 {
                            
                            allUnitSpotNums[0].append(i)
                            
                        }
                    }
                    
                    
                }
                
                
            }
            
            //加數字才能讀到正確數字
            mapPassedInt += increaseNum
            
            
            //Part 2. 讀取所有句子
            
            for (s,_) in gamePassedDic!{
                
                //讀取已完整的所有字集
                
                for i in 0 ..< (s + 1){
                    
                    var wordFile:String?
                    //前面的1代表第一張地圖
                    let name = "s" + String(describing: mapPassedInt + 1) + "-" + String(i + 1)
                    
                    //抓字
                    if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
                        do {
                            wordFile = try String(contentsOfFile: filepath)
                            let words = wordFile?.components(separatedBy: "; ")
                            
                            //把字讀取到wordSets裡
                            allSentenceSets.append(words!)
                            //print(contents)
                            
                        } catch {
                            // contents could not be loaded
                        }
                    } else {
                        // example.txt not found!
                    }
                    
                }
                
                
            }

        }
            
        //print(allSentenceSets)
            
        
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "NewGameScene") {
            
     
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! NewGameScene? {
                
                // Copy gameplay related content over to the scene
                //傳送關卡資訊過去
                sceneNode.unitNumber = unitNumber
                sceneNode.spotNumber = spotNumber
                sceneNode.mapNumber =  mapNumber
                sceneNode.gameMode = gameMode
                sceneNode.courseReceived = courseReceived
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        }
        
        //辨識語音的delegate
        speechRecognizer.delegate = self
        
        //先設定為false之後做開啟
        recordBtn.isEnabled = false
        
        //設定語言
        speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en"))!

        //備註: 請求授權, 之後要做拒絕的機制
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            OperationQueue.main.addOperation({
                
                switch authStatus {
                    
                case .authorized:
                    self.recordBtn.isEnabled = true
                    
                case .denied:
                    self.recordBtn.isEnabled = false
                    //self.recordingButton.setTitle("User denied access to speech recogniztion", for: .disabled)
                    
                case .restricted:
                    self.recordBtn.isEnabled = false
                    //self.recordingButton.setTitle("Speech recogniztion is restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordBtn.isEnabled = false
                    //self.recordingButton.setTitle("Speech recognition has not yet been authorized", for: .disabled)
                    
                    
                }
                
                
            })
            
            
        }

        
        //中文句子字顏色
        chiSentenceLabel.textColor = pinkColor
        
        
        //做錄音動畫
        let frame = CGRect(x: recordBtn.frame.origin.x - 8 * dif, y: recordBtn.frame.origin.y - 8 * dif, width:145 * dif, height: 145 * dif)
        recordingIndicator = NVActivityIndicatorView(frame: frame, type: .circleStrokeSpin, color: recordingPinkColor, padding: 2)
        
        
        self.view.addSubview(recordingIndicator!)
        self.view.bringSubview(toFront: recordBtn)
  
        //拉到最前方
        self.view.bringSubview(toFront: ghostBtn)
        self.view.bringSubview(toFront: alertBg)
        
        self.view.bringSubview(toFront: cancelBtn)
        self.view.bringSubview(toFront: quitBtn)
        self.view.bringSubview(toFront: leftBtnClickedImg)
        self.view.bringSubview(toFront: rightBtnClickedImg)

        ghostBtn.isHidden = true
        alertBg.isHidden = true
        cancelBtn.isHidden = true
        quitBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true
    }
    
    //接收nc
    @objc func pauseGame(){
        
        ghostBtn.isHidden = false
        alertBg.isHidden = false
        cancelBtn.isHidden = false
        quitBtn.isHidden = false
        leftBtnClickedImg.isHidden = false
        rightBtnClickedImg.isHidden = false
        
    }
    

    @IBAction func playSoundClicked(_ sender: Any) {
        
        //避免空字也發音
        if synWord != String(){
        
          //  print("playSound")
          //  print(synWord)
            synPronounce()
        }
        
        
    }
    @objc func leaveWithoutSaving(){
        
        UIView.animate(withDuration: 0.06, animations: {[weak self] in
            
            self!.leftBtnClickedImg.alpha = 1
            
            
        }) {[weak self] (finished:Bool) in
            
            
            if finished {
                /*
                 self!.leftBtnClickedImg.alpha = 0
                 self?.cancelBtn.isEnabled = false
                 self?.quitBtn.isEnabled = false
 
                 //停止動畫
                 self!.recordingIndicator?.stopAnimating()
 
                 //停止辨識
                 self!.audioEngine.stop()
                 self!.recognitionRequest?.endAudio()
                 self!.recognitionTask?.cancel()
                 */
 
                self!.timer?.invalidate()
                

                self!.dismiss(animated: true, completion: nil)
            }
        }
        
    }

    @objc func removeBtns(){
        
        //send Nc去continue
        
     //   if isCountingTriggered{
            
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "restartCounting"), object: nil, userInfo: nil)
       // }
        
        ghostBtn.isHidden = true
        alertBg.isHidden = true
        cancelBtn.isHidden = true
        quitBtn.isHidden = true
        leftBtnClickedImg.isHidden = true
        rightBtnClickedImg.isHidden = true

        
    }
    
    @objc func notifyRestartCounting(){
        
    }

    //顯示tagView
    @objc func showTag(){
        
        //避免再次產生hint
        isCheckingSentence = false
        
        tagView.isHidden = false
        recogTextLabel.text = ""
    }

    @objc func notifyReadyToReadSentence(){
        
    }
    
    @objc func readSentence(){
        
        //補足delegate裡沒有enable的功能
        
        if tagView.isHidden {
        recordBtn.isEnabled = true
        
        recordBtn.isHidden = false
        }
        //playSoundBtn.isEnabled = true
        
        //打開輸入字的label
        recogTextLabel.isHidden = false
        
    }
    

    @objc func notifyAddScore(){
        
    }


    //wave動畫
    @objc internal func refreshAudioView(_:Timer) {
        if self.audioView.amplitude <= self.audioView.idleAmplitude || self.audioView.amplitude > 1.0 {
            self.change *= -1.0
        }
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioView.amplitude += self.change
    }
    
    
    //造句子
    @objc func showSentence(_ notification: NSNotification){
        
        //接收單字數字準備做句子
        
        if gameMode == 0 {
        
        if let sequenceToReceive = notification.userInfo?["currentWordSequence"] as? String{
            
             //指定好數字
             wordSequenceToReceive = sequenceToReceive
            
        }
        if let speakTime = notification.userInfo?["pronounceTime"] as? Int{
            
            pronounceTime = speakTime
        }
        
        //回復錄音btn圖示
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
    
        //製作句子
        makeSentence()
        
        } else if gameMode == 2 {
            
            makeSentence()
            
        }
        
    }
    
    
    @objc func notifyPracticeNextWord(){

        //移除tagView
        attrTagsSelected.removeAll(keepingCapacity: false)
        tagView.isHidden = true
        tagView.removeAllTags()
        
        //移除輸入字
        recogTextLabel.text = ""
        recogTextLabel.isHidden = true
        
        //回復recordBtn
        if gameMode == 0 {
        recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        //recordBtn.isHidden = true  這應該不用
        }
        
        //輸入重置
        sentenceLabel.text = ""
        chiSentenceLabel.text = ""
        
    }
    
    @objc func notifyBackToSpell(){
        
        //隱藏錄音字欄位
        recogTextLabel.text = ""
        
        recogTextLabel.isHidden = true
        
        //變回錄音鍵
        //recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
        
        recordBtn.isHidden = true
      
    }
    
    
    //result畫面
    @objc func leaveGame(_ notification: NSNotification){
        
        playSoundBtn.isEnabled = false

        coverBtn.isHidden = false
        //coverBg.isHidden = false
        resultBg.isHidden = false
        firstWordBtn.isHidden = false
        secondWordBtn.isHidden = false
        thirdWordBtn.isHidden = false
        bigOkBtn.isHidden = false
        
        firstWordBtn.isEnabled = true
        secondWordBtn.isEnabled = true
        thirdWordBtn.isEnabled = true
        
        firstEngWord.adjustsFontSizeToFitWidth = true
        secondEngWord.adjustsFontSizeToFitWidth = true
        thirdEngWord.adjustsFontSizeToFitWidth = true

        firstChiWord.adjustsFontSizeToFitWidth = true
        secondChiWord.adjustsFontSizeToFitWidth = true
        thirdChiWord.adjustsFontSizeToFitWidth = true
        
        //接收單字數字準備做句子
        
        var wrongWordsCount = 0
        
        if let engWords = notification.userInfo?["engWords"] as? [String]{
            if let chiWords = notification.userInfo?["chiWords"] as? [String]{
                if let score = notification.userInfo?["score"] as? [String] {
                    if let results = notification.userInfo?["correctResults"] as? [String]{
                        
                    
                        for i in 0 ..< results.count{
                            
                            if results[i] == "1"{
      
                                wordBtns[i].setImage(UIImage(named:"wrongWordBtn.png"), for: .normal)
                                
                                wrongWordsCount += 1
                                
                                
                            } else {
                                
                                wordBtns[i].setImage(UIImage(named:"rightWordBtn.png"), for: .normal)
          
                            }
                        }
                    
                        //抓字
                        firstEngWordText = engWords[0]
                        secondEngWordText = engWords[1]
                        thirdEngWordText = engWords[2]
                        
                    
                        //做分數動畫+ 單字動畫
                    
                        scoreLabel.text = score[0]
                    
                    moveUpAnimation(label: firstEngWord, text: firstEngWordText)
                    moveUpAnimation(label: secondEngWord, text: secondEngWordText)
                    moveUpAnimation(label: thirdEngWord, text: thirdEngWordText)
                    
                    moveUpAnimation(label: firstChiWord, text: chiWords[0])
                    moveUpAnimation(label: secondChiWord, text: chiWords[1])
                    moveUpAnimation(label: thirdChiWord, text: chiWords[2])
                        

                        //如果有錯就不算過關的條件
                        
                        // if wrongWordsCount == 0 {}
                        
                        //目前這裡就先寫成都可以過關

                            //如果玩之前的關卡就不改變
                            mapNumber -= increaseNum
                        print("increase:\(increaseNum)")
                        
                        print("mapNumer:\(mapNumber)")
                        
                            if mapPassedInt == (mapNumber){
               
                                for (s,u) in gamePassedDic! {
                                    
                                    if s == spotNumber{
                                        
                                        if u == unitNumber{
                                            
                                            print("過關卡")
                                            
                                            //紀錄關卡
                                            if unitNumber == 9{
                                                
                                                //此探索點已過完, 此探索點要做動態化
                                                if spotNumber == maxSpotNum {
                                                 
                                                    //備註: 目前map只做4張, 之後要抓正確數字, 以及做全部過關的通知
                                                    
                                                    isCelebratingMapPassed = true
                                                    
                                                    bigOkBtn.setImage(UIImage(named:"unlockOkBtn.png"), for: .normal)

                                                    
                                                    switch courseReceived{
                                                        
                                                    case 0:
                                                        mapPassed! += 1
                                                        gamePassed = [0:0]
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                                        UserDefaults.standard.set(mapPassed!, forKey: "mapPassed")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed")

                                                        //有更新地圖才執行
                                                        updateMapPassed()
                                                    case 1:
                                                        mapPassed2! += 1
                                                        gamePassed2 = [0:0]
                                                        
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                                        UserDefaults.standard.set(mapPassed2!, forKey: "mapPassed2")
                                                        userDefaults.set(encodedObject, forKey: "gamePassed2")
                                                        
                                                        //pending做一個純粹更新中級的sql
                                                        

                                                    default:
                                                        break
                                                        
                                                    }
                                            
                                                    
                                               
                                                    
                                                } else {
                                                    
                                                    
                                                    switch courseReceived{
                                                        
                                                    case 0:
                                           
                                                        gamePassed = [spotNumber + 1:0]
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                       
                                                        userDefaults.set(encodedObject, forKey: "gamePassed")

                                                        
                                                        updateGamePassed()
                           
                                                    case 1:
                                        
                                                        gamePassed2 = [spotNumber + 1:0]
                                                        
                                                        //然後儲存
                                                        let userDefaults = UserDefaults.standard
                                                        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                                   
                                                        userDefaults.set(encodedObject, forKey: "gamePassed2")
                                                        
                                                        
                                                        //pending update to sql
                                          
                                                        
                                                    default:
                                                        break
                                                        
                                                    }
                                                
                                                }
                                           
                                            }else {
                                                
                                                
                                                switch courseReceived{
                                                    
                                                case 0:
                                                    
                                                    gamePassed = [spotNumber: unitNumber + 1]
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed!)
                                    
                                                    userDefaults.set(encodedObject, forKey: "gamePassed")
                                                    
                                                    
                                                    updateGamePassed()

                                                    
                                                case 1:
                                                    
                                                    gamePassed2 = [spotNumber: unitNumber + 1]
                                                    
                                                    //然後儲存
                                                    let userDefaults = UserDefaults.standard
                                                    let encodedObject = NSKeyedArchiver.archivedData(withRootObject: gamePassed2!)
                                              
                                                    userDefaults.set(encodedObject, forKey: "gamePassed2")
                                                    
                                                    //pending update to sql
                                                    
                                                default:
                                                    break
                                                    
                                                }
                                         
                                            }
                                            
                                            
                                
                                            

                                        } else {
                                            print("前元素")
                                    
                                        }
                                    } else {
                                        
                                        print("前探索點")
                                    }
                                }
         
                            } else {
                                
                                print("前地圖")
                                
                            }
                        
                        
                                //計算所有字數
                            countWords()
                        
                }
                }
            }
        }
    }
    
    
    func countWords(){
        //計算所有字數
        
        var wordsCounts = Int()


        switch courseReceived{
            
        case 0:
            
            
            wordsCounts += mapPassed! * 450
            
            
            for (s,u) in gamePassed!{
                
                wordsCounts += s * 30 + u * 3
                
            }
            
         
            
        case 1:
            
            
            wordsCounts += mapPassed2! * 420
            
            
            for (s,u) in gamePassed2!{
                
                wordsCounts += s * 30 + u * 3
                
            }
            
        default:
            break
            
        }

        //顯示出來
        wordCountLabel.text = String(wordsCounts)
        
    }
    
    @IBAction func firstWordClicked(_ sender: Any) {
        
        if isParseEnabled{
               isParseEnabled = false
            addWord(word: firstEngWordText)
            moveUpAndGone(label: word1Label)
            
        }
        
    }
    @IBAction func secondWordClicked(_ sender: Any) {
        if isParseEnabled{
            isParseEnabled = false
            addWord(word: secondEngWordText)
            moveUpAndGone(label: word2Label)
            
        }
    }
    
    @IBAction func thirdWordClicked(_ sender: Any) {
        
        if isParseEnabled{
            isParseEnabled = false
            addWord(word: thirdEngWordText)
            moveUpAndGone(label: word3Label)
            
        }
        
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {

        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
        waitTimer.invalidate()
    }
    
    
    func moveUpAnimation(label:UILabel,text:String){
        
        let labelToMove = label
        
        labelToMove.alpha = 0.3
        labelToMove.text = text
        let originY = label.frame.origin.y
        labelToMove.frame.origin.y = originY + 20
        UIView.animate(withDuration: 0.3) {
            labelToMove.alpha = 1
            labelToMove.frame.origin.y = originY
  
        }
    }
    
    func moveUpAndGone(label:UILabel){
        
        let labelToMove = label
        labelToMove.alpha = 1

        UIView.animate(withDuration: 0.7, animations: {
            labelToMove.alpha = 0
            labelToMove.frame.origin.y = -20
        }) { (true) in
            labelToMove.frame.origin.y = 0
        }
    }
    
    //開始辨識聲音
    @objc func startToRecognize(){

        //顯示按鈕, 顯示label
        recordBtn.isHidden = false

        recogTextLabel.isHidden = false
        
        //回復錄音輸入的單字或句子
        wordRecorded = String()
        
        //對字
        isCheckingSentence = false
        
        //指定答案的字
        wordToReceive = synWord

        
        
        //移除標點符號
        wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
        
        //改成小寫
        wordToReceive = wordToReceive.lowercased()
        
       
    }
    
    //接收發音單字
    
    /*
    @objc func pronounceWord(_ notification: NSNotification){

        if let wordToPronunce = notification.userInfo?["wordToPass"] as? String {
                //設訂發音的單字
                synWord = wordToPronunce

        }
        //發音
        synPronounce()
    }
    */
    
    
    var pronounceTime = Int()
    @objc func pronounceWord(_ notification: NSNotification){
        
        //一定要指定要說幾次
        guard let speakTime = notification.userInfo?["pronounceTime"] as? Int else{
            return
        }
        pronounceTime = speakTime
        
        //要發音的單字或句子可有可無
        if let wordToPronunce = notification.userInfo?["wordToPass"] as? String {
            
            //設訂發音的單字
            synWord = wordToPronunce
            
            //確認是否有別的發音
            
            //抓發音錯誤字集
            for i in 0 ..< wrongPronounceWords.count{
                
                for (word,rightWord) in wrongPronounceWords[i]{
                    
                    //假如有抓到的話
                    if word == wordToPronunce{
                        print("found wrond pronounce word")
                        synWord = rightWord[0]
                        
                    }
                    
                }
                
            }
        
        }
        //發音

        synPronounce()
    }

    @objc func notifyStartCountDown(){
        
        
    }
    
    //按鈕
    @IBAction func recordClicked(_ sender: Any) {

    
        //停止
        if audioEngine.isRunning {
            
            //避免再次快速按
            recordBtn.isEnabled = false
            
            //wave 消失停止
            audioView.isHidden = true
            timer?.invalidate()
            
            //更改Btn圖示為待錄音
            recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
            
            //停止動畫
            recordingIndicator?.stopAnimating()
  
            
            //停止辨識

            audioEngine.stop()
            recognitionRequest?.endAudio()
            recognitionTask?.cancel()
            
            playSoundBtn.isEnabled = true
            
            //檢查答案, 句子/單字
            if isCheckingSentence{
                
                //檢查
                self.checkSentence()
           
                //隱藏Btn, 以便顯示句子得分的img
                recordBtn.isHidden = true
           
            } else {
                self.checkWord()
                
            }

            
        }  else {
            

            
            //btn圖案更改成錄音
            recordBtn.setImage(UIImage(named:"recordingBtn.png"), for: .normal)
            
            //siriWave
            audioView.isHidden = false
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(NewGameViewController.refreshAudioView(_:)), userInfo: nil, repeats: true)

            //錄音動畫開啟
            recordingIndicator?.startAnimating()
            
            //如果Task還在, 就取消task 等待再次開啟
            if recognitionTask != nil {
                recognitionTask?.cancel()
                recognitionTask = nil
            }

            //抓目前單字的相關字
            var relWords:[String]?
            
            //抓發音錯誤字集
            for i in 0 ..< relevantWords.count{
                
                for (word,rels) in relevantWords[i]{

                    //假如有抓到的話
                    if word == wordToReceive{
                        
                        relWords = rels
  
                    }

                }

                
            }

            //開始辨識
           

            do {
 
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
                try audioSession.setMode(AVAudioSessionModeMeasurement)
                try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
                
          
 
                if let inputNode = audioEngine.inputNode as AVAudioInputNode?{
                    
                    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

                    guard let recognitionRequest = recognitionRequest else {
                        fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
                    }
                    
                    recognitionRequest.shouldReportPartialResults = true
                    
                    self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: {[weak self] (result, error) in
                        
                        
                        if let result = result {
    
                            if let resultWord = result.bestTranscription.formattedString.lowercased() as String?{
                                
                                
                                if relWords != nil {
                                    
                                    if relWords!.contains(resultWord){
                                        
                                        self!.recogTextLabel.text = self!.wordToReceive
                                        
                                    } else {
                                        
                                     self!.recogTextLabel.text = resultWord
                                    }
                                } else {
                                    
                                     self!.recogTextLabel.text = resultWord
                                    
                                }
                                
                            }
                            
                            //對答案的部分要修掉標點符號
                            self!.wordRecorded = self!.recogTextLabel.text!.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
                          
    
                            if result.isFinal {
                                
                                self!.audioEngine.stop()
                                inputNode.removeTap(onBus: 0)
                                
                                //移除掉Request避免Reuse
                                self!.recognitionRequest = nil
                                self!.recognitionTask = nil
                                
                                //self!.recordBtn.setTitle("Start Recording", for: [])
                                
                                
                            }
                            
                        }
                        
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
   
                    //先移除之前的
                    inputNode.removeTap(onBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: {[weak self] (buffer, when) in
                        
                        self!
                            .recognitionRequest?.append(buffer)
           
                    })
                    
                    audioEngine.prepare()
                    try audioEngine.start()
                  
                    //開啟錄音
                    playSoundBtn.isEnabled = false
                }
                
    
            } catch {
                
                //Handle error
                
            }
    
        }
        
    }
    

    
    //假如沒有辦法錄音就要啟動認證
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
        if available{
            
            
        } else {
            //重新啟動認證
            
        }
    }
    
    //準備離開遊戲
    @IBAction func okBtnClicked(_ sender: Any) {
        
        //在此確認是否已過地圖的確認
        
        if isCelebratingMapPassed{
            
            //dimiss掉兩個VCs
            self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
            
        } else {
        
            self.dismiss(animated: true, completion: nil)
        
        }
        
        
    }
    

    //檢查句子
    
    func checkSentence(){
        
        var attrSentence = NSMutableAttributedString()
        
        let attrs0 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.white]
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedStringKey.foregroundColor : UIColor.magenta]
        
        var recorded = [String]()
        var received = [String]()
        var completeWords = [String]()
        
        recorded = wordRecorded.components(separatedBy: " ")
        received = wordToReceive.components(separatedBy: " ")
        completeWords = completeWordsToShow.components(separatedBy: " ")
        
        
        //寫一個對答案比例的func
        var finalPoints = Int()
        let unitPoint = 100 / received.count
        var pointGet = Int()
        var pointMinus = Int()
        
        //計分算法, 基本上還是要按照順序來計算
        if recorded == received{
            
            finalPoints = 100
            
        } else {
            
            for i in 0 ..< received.count{
                
                
                if i < recorded.count{
                    if recorded[i] == received[i]{
                        if i == 0 {
                            
                            attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs0)
                        } else {
                            
                            attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs0))
                        }
                        
                    } else {
                        
                        if i == 0 {
                            
                            attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1)
                        } else {
                            
                            attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1))
                        }
                    }
                } else {
                    
                    
                    if i == 0 {
                        
                        attrSentence = NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1)
                    } else {
                        
                        attrSentence.append(NSMutableAttributedString(string: completeWords[i] + " ", attributes: attrs1))
                    }
                }
                
                for r in 0 ..< recorded.count{
                    
                    if recorded[r] == received[i]{
                        
                        //假如有字對到
                        
                        pointGet += 1
                        
                    }
                    
                }
                
            }
            
            //顯示label字的正確與否 用顏色分辨
            recogTextLabel.attributedText = attrSentence
            
            //避免分數超過
            if pointGet > received.count{
                pointGet = received.count
            }
            
            finalPoints = pointGet * unitPoint
        }
        
        //如果輸入的字更多要扣分
        if recorded.count > received.count{
            
            pointMinus = recorded.count  - received.count
            finalPoints = finalPoints - pointMinus * unitPoint / 2
            
            if finalPoints < 0 {
                finalPoints = 0
            }
            
        }
        
        //結果決定圖片
        /*
         if finalPoints >= 70 {
         recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
         } else{
         recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
         }
         */
        
        //計算分數
        var score = Int()
        score = 500 * finalPoints / 100
        
        //卡一下顯示分數
        //之後可以改變分數高低不同的img顏色
 
        let pointImg = UIImageView()
        let pointLabel = UILabel()
     
        pointImg.frame = CGRect(x: recordBtn.frame.origin.x, y: recordBtn.frame.origin.y, width: recordBtn.frame.width, height: recordBtn.frame.height)
        pointImg.image = UIImage(named: "pointImg.png")
        self.view.addSubview(pointImg)
       
        pointLabel.frame = CGRect(x: 0, y: recordBtn.frame.height / 3.5, width: recordBtn.frame.width, height: 60)
        pointLabel.backgroundColor = .clear
        pointLabel.textColor = .white
        pointLabel.font = UIFont(name: "Helvetica Bold", size: 40)
        pointLabel.textAlignment = .center
        pointLabel.text = "\(finalPoints)%"
        pointImg.addSubview(pointLabel)
        
        //pointsIndicator?.startAnimating()
        
        //隱藏recordBtn
        //recordBtn.isHidden = true
        
        //讓分數停留一下後再消失
        let when = DispatchTime.now() + 1.5
        
        //接著做選擇題, 所有顯示的func都包在下方
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            pointImg.removeFromSuperview()

//            self!.pointsIndicator?.stopAnimating()
            
            //製作tags
            self!.sentenceTag = self!.sentence.components(separatedBy: " ")
            
            
            self!.sentenceTag.shuffled()
            
            for i in 0 ..< self!.sentenceTag.count{
                
                self!.tagView.addTag(self!.sentenceTag[i] + " " + String(i))
                
            }
            
            //準備選擇題
            self!.sentenceLabel.text = ""
            
            //算分數 + 啟動tag的機制 (目前修正成nc去啟動倒數）
            let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
            
            //給暫停使用的
           // self!.isCountingTriggered = true
            
            //隱藏輸入字
            self!.recogTextLabel.text = ""
            
            //顯示出tag
            self!.tagView.isHidden = false
            
            //避免再次產生hint
            self!.isCheckingSentence = false
            
            //發音
            self!.pronounceTime = 1
   
            self!.synPronounce()
            

        }
        
        
    }
    
    
    func checkWord(){
        
        //正確
        if wordRecorded == wordToReceive{
            
            recordBtn.setImage(UIImage(named:"recordCheck.png"), for: .normal)
            
            isRecogWordCorrect = true
            
            //正確暫時不改顏色
            

        } else {
            
       
            //錯誤
            recordBtn.setImage(UIImage(named:"recordCross.png"), for: .normal)
            
            isRecogWordCorrect = false
            
            //改變字成紅色
            self.recogTextLabel.textColor = .red
            
        }
        
        //都等一下反應, 讓user看到成功或失敗的圖示
        let when = DispatchTime.now() + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {[weak self] in
            
            //辨識的字消失
            self!.recogTextLabel.text = ""
            
            //回復顏色
            self!.recogTextLabel.textColor = .white
            
            if self!.isRecogWordCorrect{
                
                
                
                //隱藏Btn
                self!.recordBtn.isHidden = true
                
                //計分
                var score = Int()
                if self!.answerTime == 0 {
                    
                    score = 200
                } else if self!.answerTime == 1 {
                    
                    score = 100
                    self?.answerTime = 0
                }
                
            
                let addScore:[String:Int] = ["addScore":score]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                
            } else {
                
                
                if self!.answerTime < 1 {
                    
                    //可以繼續練習
                
                    self!.answerTime += 1
                    
                    self!.recordBtn.setImage(UIImage(named:"recordBtn.png"), for: .normal)
                    self!.recordBtn.isHidden = false
                    self!.recordBtn.isEnabled = true
                
                } else {
                    //失敗跳離畫面
                    self!.answerTime = 0
                    
                    
                    let addScore:[String:Int] = ["addScore":0]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "backToSpell"), object: nil, userInfo: addScore)
                    
                    
                }
                
            }
        }
        
    }
    
    @objc func onlyPracticeSentence(_ notification: NSNotification){
        
        
        //抓所有句子數量來做全部的亂數
        var totalNum = Int()
        
        for s in allUnitSpotNums{
            
            for _ in s{
                
                totalNum += 1
            }
        }

        
        //做亂數
        for _ in 0 ..< totalNum {
            
            //新增目前能選擇的spotIndex
            let spotIndex = Int(arc4random_uniform(UInt32(allUnitSpotNums.count)))
            randomSpots.append(spotIndex)
            
            //從目前能選的spotIndex中選擇能選的unitIndex
            let unitCount = allUnitSpotNums[spotIndex].count
            let unitIndex = Int(arc4random_uniform(UInt32(unitCount)))
            randomUnits.append(allUnitSpotNums[spotIndex][unitIndex])
            
            
            //移除
            
            allUnitSpotNums[spotIndex].remove(at: unitIndex)
            
            if allUnitSpotNums[spotIndex].count == 0 {
                
                allUnitSpotNums.remove(at: spotIndex)
            }
            
        }

        //print(randomSpots)
        //print(randomUnits)
        
        //抓到的順序為0
        if let wordSeq = notification.userInfo?["wordSequence"] as? Int {
          
            wordSequenceToReceive = String(wordSeq)
        }
        
        //做句子
        makeSentence()

    }
    

    //做句子, 傳送nc去發音
    func makeSentence(){
        
        //顯示句子文字
        
        if gameMode == 2 {
            //只練習句子
            
            //英文句子
            sentence = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]][randomUnits[Int(wordSequenceToReceive)!]]
            
            let halfCount = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]].count / 2
            
            //中文句子
            chiSentence = allSentenceSets[randomSpots[Int(wordSequenceToReceive)!]][randomUnits[Int(wordSequenceToReceive)!] + halfCount]
            
            /*
            print(sentence)
            print(chiSentence)
            */
            
            //製作4個中文選項Btn
            for btn in allBtns{
                btn.isHidden = false
            }

            //抓好中英文句子答案
            sentenceLabel.text = sentence
            chiSentenceLabel.text = "請選出正確中文翻譯"

            //準備做四個選項
            var senBtnTitles = ["","","",""]
           
            //抓一個正確的隨機置放位置, 放中文答案進去
            correctRandom = Int(arc4random_uniform(UInt32(4)))
            senBtnTitles[correctRandom] = chiSentence
            
            //填入數字
            allRandomSens = Array(repeating: [Int:Int](), count: 4)
            
            //填入正確句子的數字
            allRandomSens[correctRandom] = [randomSpots[Int(wordSequenceToReceive)!]:randomUnits[Int(wordSequenceToReceive)!]]
            

            //設定好正確的按鈕
            allBtns[correctRandom].addTarget(self, action: #selector(NewGameViewController.rightSenButtonClicked), for: .touchUpInside)
            allBtns[correctRandom].tag = correctRandom


            //填滿其他的隨機數
            for i in 0 ..< 4 where i != correctRandom{
                
                //抓四個隨機數, 並且避開重複值
                allRandomSens[i] = getRandom()
                
                for (s,u) in allRandomSens[i] {

                    //填入中文句子當作選項
                    senBtnTitles[i] = allSentenceSets[s][u + halfCount]
                    
                }

                //設定好其餘選項的tag
                allBtns[i].tag = i
                
                //加入到錯誤按鈕的button
                allBtns[i].addTarget(self, action: #selector(NewGameViewController.wrongSenButtonClicked), for: .touchUpInside)
                
            }
            
 
            //設定所有案件的中文內文
            for i in 0 ..< allBtns.count {
         
                allBtns[i].contentHorizontalAlignment = .left
               
                allBtns[i].setTitle("   \(i + 1). " + senBtnTitles[i], for: .normal)
          
            }

            //避免再次產生hint
            isCheckingSentence = false
            
        } else{
            
            //英文句子
            sentence = sentenceSets[Int(wordSequenceToReceive)!]
            let halfCount = sentenceSets.count / 2
            chiSentence = sentenceSets[halfCount + Int(wordSequenceToReceive)!]
            
            sentenceLabel.text = sentence
            
            //接著要辨認句子, 用此來讓delegate send NC給gameScene
            
            isCheckingSentence = true
            chiSentenceLabel.text = chiSentence
            
            
            //對答案用
            wordToReceive = sentence
            
            //提供顯示用的答案, 包含標點符號及大小寫
            completeWordsToShow = sentence
            
            //移除標點符號
            wordToReceive = wordToReceive.removingCharacters(inCharacterSet: CharacterSet.punctuationCharacters)
            
            //改成小寫
            wordToReceive = wordToReceive.lowercased()
            
            //準備練習句子
            //顯示按鈕, 顯示label
            
            //回復錄音輸入的單字或句子
            wordRecorded = String()
            
        }
        
        //句子發音
        synWord = sentence
   

        synPronounce()
    }
    
    
    @objc func rightSenButtonClicked(sender:UIButton){
        print("correct")
        
        //做圈圈記號
        /*
        correctSign.frame = CGRect(x: allBtns[correctRandom].frame.midX - allBtns[correctRandom].frame.width / 10, y: allBtns[correctRandom].frame.minY - allBtns[correctRandom].frame.height * 0.1, width: allBtns[correctRandom].frame.height * 1.2, height: allBtns[correctRandom].frame.height * 1.2)
        correctSign.image = UIImage(named:"rightCircle.png")
        self.view.addSubview(correctSign)
        self.view.bringSubview(toFront: correctSign)
        */

        //錯誤按鈕改圖片
        sender.setBackgroundImage(UIImage(named:"answerRightBtn.png"), for: .normal)
        
        //錯誤的隱藏
        for i in 0 ..< 4 where i != correctRandom{

        allBtns[i].isHidden = true
            
        }
        
        //所有按鍵都不要有反應
        for btn in allBtns{
            
                btn.isUserInteractionEnabled = false
            
        }
        
        //等待1.5秒
        btnTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(NewGameViewController.btnCounting), userInfo: nil, repeats: true)
        
    }
    

    
    @objc func wrongSenButtonClicked(sender:UIButton) {
        print("wrong")
        
        //錯誤按鈕改圖片
        sender.setBackgroundImage(UIImage(named:"wrongSenBlock.png"), for: .normal)
        
        
        //留下對錯兩按鈕, 其餘隱藏
        for i in 0 ..< 4 where i != correctRandom && i != sender.tag{
            
            allBtns[i].isHidden = true
            
        }
        
        //所有按鈕不能按
        for btn in allBtns{
            
            btn.isUserInteractionEnabled = false
        }
        
        //做錯誤符號
        wrongSign.frame = CGRect(x: allBtns[sender.tag].frame.midX - allBtns[sender.tag].frame.width / 10, y: allBtns[sender.tag].frame.minY - allBtns[sender.tag].frame.height * 0.1, width: allBtns[sender.tag].frame.height * 1.2, height: allBtns[sender.tag].frame.height * 1.2)
        wrongSign.image = UIImage(named:"wrongX.png")
        self.view.addSubview(wrongSign)
        self.view.bringSubview(toFront: wrongSign)
        
        
        //等待1.5秒
        btnTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(NewGameViewController.btnCounting), userInfo: nil, repeats: true)
        
    }
    
    
    //倒數秒數, 倒數玩跳下一題
    @objc func btnCounting(){
        
        if timerCount < 2 {
            
            timerCount += 1
        } else {
            
            btnTimer.invalidate()
            timerCount = 0
            
            //跳下一題
            jumpToTagPractice()
            
        }
        
        
    }
    

    //進入選擇題
    func jumpToTagPractice(){
        
        correctSign.removeFromSuperview()
        wrongSign.removeFromSuperview()
        
        for btn in allBtns{
           
            btn.isUserInteractionEnabled = true
            btn.isHidden = true
            btn.setBackgroundImage(UIImage(named:"senBlock.png"), for: .normal)
        }
        
        sentenceLabel.text = ""
        chiSentenceLabel.text = chiSentence
        recogTextLabel.isHidden = false
        
        makeTag()
        
    }
    
    
    //選擇題
    func makeTag(){
        
        //製作tags
        sentenceTag = sentence.components(separatedBy: " ")
        
        //亂數
        sentenceTag.shuffled()
        
        //加入tag裡
        for i in 0 ..< sentenceTag.count{
            
            //後方加入數字做辨認
            tagView.addTag(sentenceTag[i] + " " + String(i))
            
        }
        
        //準備選擇題
        sentenceLabel.text = ""
        
        //算分數 + 啟動tag的機制 (目前修正成nc去啟動倒數）
        let score = Int()
        let finalPoints = Int()
        
        let addScore:[String:Int] = ["addScore":score,"finalPoints":finalPoints]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addScore"), object: nil, userInfo: addScore)
 
        
        //隱藏輸入字
        recogTextLabel.text = ""
        
        //顯示出tag
        tagView.isHidden = false
        
        //避免再次產生hint
        isCheckingSentence = false
        
        //發音
        pronounceTime = 1

        synPronounce()
        
    }

    
    
    //取亂數不重複的func
    func getRandom() -> [Int:Int] {
        
        var selRan = [Int:Int]()
      
        let ranSpot = Int(arc4random_uniform(UInt32(randomSpots.count)))
      
        let ranUnit = Int(arc4random_uniform(UInt32(randomUnits.count)))
        selRan = [randomSpots[ranSpot]:randomUnits[ranUnit]]
        

        //如果數字重複了就重來
        if allRandomSens.contains(selRan){
            
            return getRandom()
        }
        
        return selRan
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //確認tag的答案
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
       
        tagView.isSelected = !tagView.isSelected
        
        //抓attrTitle
        let attr = tagView.attributedTitle(for: .normal) as! NSMutableAttributedString
        
        var sentenceShown = String()
        
        if attrTagsSelected.count > 0 {
            
            if attrTagsSelected.contains(attr){
                
                for i in 0 ..< attrTagsSelected.count{
                    
                    if attrTagsSelected[i] == attr{
                        
                        attrTagsSelected[i] = NSMutableAttributedString()
                        
                    }
                    
                }
                

            } else {
                
                     attrTagsSelected.append(attr)
            }
            
            
        } else {
            
            attrTagsSelected.append(attr)
        }
        
        
        //把attrTitle的純String顯示在畫面上
        for attr in attrTagsSelected{
            
            
            if attr != NSMutableAttributedString() {
                
                let attrWords = attr.mutableString.components(separatedBy: NSCharacterSet.decimalDigits)
               
                sentenceShown += attrWords[0] + " "
                
            }
            
            
        }
        
 
        //show出選擇的字
        recogTextLabel.text = sentenceShown
        
        //抓輸入答案來對
        let answerEntered = recogTextLabel.text?.dropLast()
        
        if answerEntered! == sentence{
            
        //    isCountingTriggered = false
            
            //跳轉下個字
            
            if gameMode == 0 {
            //過關進入下個字
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
            } else if gameMode == 2{
                
                //確認是否還有字
                //繼續練習下一個字
                //如果是的話代表是練習最後一個
                
                
                //在此抓共有幾題
                var randomSpotsCount = randomSpots.count
                
                //避免只有三題卻出四次
                for (s,u) in gamePassed! {
                    if s == 0 {
                        
                        if u == 1 {
                            
                            randomSpotsCount = 3
                        }
                    }
                    
                }
                
                if Int(wordSequenceToReceive) == (randomSpotsCount - 1){
                    print("結束練習")
                    
                    //過關進入下個字, 在此功能在gameMode == 2為刪除倒數線
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
                    
                    
                    //要跳出練習總結畫面
                    
                } else {
                

                    //過關進入下個字, 在此功能在gameMode == 2為刪除倒數線
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "practiceNextWord"), object: nil, userInfo: nil)
                
                //這裡包含了重新開始的所有功能, 另外建功能是要為了接收gameScene發出來的NC, 避免以上的再次send Nc到gameScene
                
                    game2RestartFunc()
                
                }
         
            }
            
    
        } else {
            
            print("not yet correct")
    
        }
   
    }

    
    @objc func game2RestartFunc(){
        
        let seq = Int(wordSequenceToReceive)
    
        //順序 + 1
        wordSequenceToReceive = String(seq! + 1)
        
        //移除按鈕target
        for btn in allBtns {
            
            btn.removeTarget(nil, action: nil, for: .allEvents)
        }
        

        
        allRandomSens.removeAll(keepingCapacity: false)
        
        //移除tagView
        attrTagsSelected.removeAll(keepingCapacity: false)
        tagView.isHidden = true
        removeAll()
        
        //移除輸入字
        recogTextLabel.text = ""
        recogTextLabel.isHidden = true
        
        //製作句子
        makeSentence()
    }
    
    @objc func removeAll(){
        
        tagView.removeAllTags()
    }
    
    //重設synth & 他的delegate
    func stopSpeech(){
        
        if synth.isSpeaking{
            
            synth.stopSpeaking(at: .immediate)
            synth = AVSpeechSynthesizer()
            synth.delegate = self
            
        }
    }

    //syn發音
    func synPronounce(){
        
        
        do {
            
            //設置成ambient看能不能避免任何interruption 造成當機
            
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
            try audioSession.setMode(AVAudioSessionModeDefault)
            try audioSession.setActive(true)
            
        } catch  {
            print("error")
        }
        

        let string = synWord
        
        var rateFloat = Float()
        
        let utterance = AVSpeechUtterance(string: string)
        let utterance2 = AVSpeechUtterance(string: string)
        
        if string.contains(" "){
            
            rateFloat = 0.4
          //  print("唸句子")
          //  print(synWord)
            
            //delay要做0, delegate才會發音結束準時告知
            utterance.postUtteranceDelay = 0
            
        } else {
        //    print("唸單字")
        //    print(synWord)
            rateFloat = 0.45
            utterance.postUtteranceDelay = 0
        }
        
        
        utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance2.rate = rateFloat
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rateFloat
        
        
        stopSpeech()
        synth.speak(utterance)
        
        
        /* 下方功能為兩次發音先不需要
        //發音等待時間
        let when = DispatchTime.now() + 2.7
        
        DispatchQueue.main.async {[weak self] in
            
            guard let strongSelf = self else{
                return
            }
            //strongSelf.synth.stopSpeaking(at: .immediate)
            strongSelf.synth.speak(utterance)

            
            if strongSelf.pronounceTime == 2 {
                
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                    strongSelf.synth.speak(utterance2)

                })
                
            }
        }
        
        */
    }

    

    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance){
       
        //print("**start")
        recordBtn.isEnabled = false
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance){

        print("**Finish")
       
        if isCheckingSentence{

            //檢查句子前先發hint
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "readyToReadSentence"), object: nil, userInfo: nil)
        }
        
        
        if !synth.isSpeaking{
            recordBtn.isEnabled = true
            print("really pause")
       
        } else {
        
            //避免delegate不成功...此function可能不需要暫時留著需要注意timer有沒有invalidate..
            print("not yet Paused")
            waitTimer.invalidate()
            waitTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(NewGameViewController.waitTime), userInfo: nil, repeats: true)
        }
        
        
    }
    
    
    //避免delegate不成功的TIMER
    @objc func waitTime(){
        
        print("enter Timer")
        if !synth.isSpeaking{
            recordBtn.isEnabled = true
            print("timer pause")
            waitTimer.invalidate()
        }
        
        
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance){
        print("**pause")
        recordBtn.isEnabled = true
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance){
          print("**continue")
          recordBtn.isEnabled = false
    }
    
    @available(iOS 7.0, *)
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance){
          print("**cancel")
        recordBtn.isEnabled = true
        
    }

    //更新mapPassed
    
    func updateMapPassed(){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/mapPassed.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        // body gonna be appended to url
        let body = "userID=\(id)&mapPassed=\(mapPassed!)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            // no error
            

            if error == nil {
            
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
      
                        return
                    }
                    
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary

                    print(user!)
                    print("mapPassed updated")
                    
                } catch{
              
                    print("catch error")
                    
                    
                }
            } else {
                print("urlsession has error")
                
            }
        }).resume()

        
        
    }
    
    
    //更新gamePassed
    func updateGamePassed(){
        
        
        let id = user?["id"] as! String
        
        // url to access our php file
        let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/gamePassed.php")!
        
        // request url
        var request = URLRequest(url: url)
        
        // method to pass data POST - cause it is secured
        request.httpMethod = "POST"
        
        var gamePassedString = String()
        
        for (s,u) in gamePassed!{
            
            gamePassedString = String(s) + ":" + String(u)
            
        }
        
        // body gonna be appended to url
        let body = "userID=\(id)&gamePassed=\(gamePassedString)"
        
        // append body to our request that gonna be sent
        request.httpBody = body.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            // no error
            
            
            if error == nil {
                
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJSON = json else {
                        print("Error while parsing")
                        //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                        
                        return
                    }
                    
                    //再次儲存使用者資訊
                    UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                    user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                    
                    
                    print("gamePassed updated")
                    
                } catch{
                    
                    print("catch error")
                    
                    
                }
            } else {
                print("urlsession has error")
                
            }
        }).resume()
        

        
    }
    

    
    
    //新增最愛單字
    func addWord(word:String){
        
        //確認該字沒有在最愛之內
        if !myWords.contains(word){
            
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/addWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                                self?.isParseEnabled = true
                            return
                        }
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        //載入我的最愛單字
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }
                        self?.isParseEnabled = true

                    } catch{
                            self?.isParseEnabled = true
                        print("catch error")
                        
                        
                    }
                } else {
                        self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        } else {
            
            print("alreaded added")
            isParseEnabled = true
        }
    }
    
    //刪除最愛單字---這部分要到單字集裡面做
    
    func removeWord(word:String){
        
        if myWords.contains(word) {
            let id = user?["id"] as! String
            
            // url to access our php file
            let url = URL(string: "http://ec2-54-238-246-23.ap-northeast-1.compute.amazonaws.com/wordDrugApp/removeWord.php")!
            
            // request url
            var request = URLRequest(url: url)
            
            // method to pass data POST - cause it is secured
            request.httpMethod = "POST"
            
            // body gonna be appended to url
            let body = "userID=\(id)&word=\(word)"
            
            // append body to our request that gonna be sent
            request.httpBody = body.data(using: .utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: {[weak self] data, response, error in
                // no error
                if error == nil {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJSON = json else {
                            print("Error while parsing")
                                self?.isParseEnabled = true
                            //self?.createAlert(title: (self?.generalErrorTitleText)!, message: (self?.generalErrorMessageText)!)
                            return
                        }
                        
                        //再次儲存使用者資訊
                        UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                        user = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                        print(user!)
                        //載入我的最愛單字
                        if let myWordsString = user!["myWords"] as! String?{
                            self!.myWords = myWordsString.components(separatedBy: ";")
                            
                        }

                            self?.isParseEnabled = true
                        
                    } catch{
                        
                            self?.isParseEnabled = true
                        print("catch error")
                        
                    }
                } else {
                        self?.isParseEnabled = true
                    print("urlsession has error")
                    
                }
            }).resume()
        }
    }
    
    /*
    func playSound() {
        guard let url = Bundle.main.url(forResource: sentenceToPronounce, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
*/
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension String {
    func removingCharacters(inCharacterSet forbiddenCharacters:CharacterSet) -> String
    {
        var filteredString = self
        while true {
            if let forbiddenCharRange = filteredString.rangeOfCharacter(from: forbiddenCharacters)  {
                filteredString.removeSubrange(forbiddenCharRange)
            }
            else {
                break
            }
        }
        
        return filteredString
    }
}
