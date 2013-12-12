//
//  Utility.m
//  LeheB
//
//  Created by zhangluyi on 11-5-4.
//  Copyright 2011年 Lehe. All rights reserved.
//

#import "Utility.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "DES3Util.h"

#define ARC4RANDOM_MAX      0x100000000

#define HANZI_START 19968
#define HANZI_COUNT 20902

#define MAX_STRING_LENGTH 255

static char firstLetterArray[HANZI_COUNT] = 
"ydkqsxnwzssxjbymgcczqpssqbycdscdqldylybssjgyqzjjfgcclzznwdwzjljpfyynnjjtmynzwzhflzppqhgccyynmjqyxxgd"
"nnsnsjnjnsnnmlnrxyfsngnnnnqzggllyjlnyzssecykyyhqwjssggyxyqyjtwktjhychmnxjtlhjyqbyxdldwrrjnwysrldzjpc"
"bzjjbrcfslnczstzfxxchtrqggddlyccssymmrjcyqzpwwjjyfcrwfdfzqpyddwyxkyjawjffxjbcftzyhhycyswccyxsclcxxwz"
"cxnbgnnxbxlzsqsbsjpysazdhmdzbqbscwdzzyytzhbtsyyfzgntnxjywqnknphhlxgybfmjnbjhhgqtjcysxstkzglyckglysmz"
"xyalmeldccxgzyrjxjzlnjzcqkcnnjwhjczccqljststbnhbtyxceqxkkwjyflzqlyhjxspsfxlmpbysxxxytccnylllsjxfhjxp"
"jbtffyabyxbcczbzyclwlczggbtssmdtjcxpthyqtgjjxcjfzkjzjqnlzwlslhdzbwjncjzyzsqnycqynzcjjwybrtwpyftwexcs"
"kdzctbyhyzqyyjxzcfbzzmjyxxsdczottbzljwfckscsxfyrlrygmbdthjxsqjccsbxyytswfbjdztnbcnzlcyzzpsacyzzsqqcs"
"hzqydxlbpjllmqxqydzxsqjtzpxlcglqdcwzfhctdjjsfxjejjtlbgxsxjmyjjqpfzasyjnsydjxkjcdjsznbartcclnjqmwnqnc"
"lllkbdbzzsyhqcltwlccrshllzntylnewyzyxczxxgdkdmtcedejtsyyssdqdfmxdbjlkrwnqlybglxnlgtgxbqjdznyjsjyjcjm"
"rnymgrcjczgjmzmgxmmryxkjnymsgmzzymknfxmbdtgfbhcjhkylpfmdxlxjjsmsqgzsjlqdldgjycalcmzcsdjllnxdjffffjcn"
"fnnffpfkhkgdpqxktacjdhhzdddrrcfqyjkqccwjdxhwjlyllzgcfcqjsmlzpbjjblsbcjggdckkdezsqcckjgcgkdjtjllzycxk"
"lqccgjcltfpcqczgwbjdqyzjjbyjhsjddwgfsjgzkcjctllfspkjgqjhzzljplgjgjjthjjyjzccmlzlyqbgjwmljkxzdznjqsyz"
"mljlljkywxmkjlhskjhbmclyymkxjqlbmllkmdxxkwyxwslmlpsjqqjqxyqfjtjdxmxxllcrqbsyjbgwynnggbcnxpjtgpapfgdj"
"qbhbncfjyzjkjkhxqfgqckfhygkhdkllsdjqxpqyaybnqsxqnszswhbsxwhxwbzzxdmndjbsbkbbzklylxgwxjjwaqzmywsjqlsj"
"xxjqwjeqxnchetlzalyyyszzpnkyzcptlshtzcfycyxyljsdcjqagyslcllyyysslqqqnldxzsccscadycjysfsgbfrsszqsbxjp"
"sjysdrckgjlgtkzjzbdktcsyqpyhstcldjnhmymcgxyzhjdctmhltxzhylamoxyjcltyfbqqjpfbdfehthsqhzywwcncxcdwhowg"
"yjlegmdqcwgfjhcsntmydolbygnqwesqpwnmlrydzszzlyqpzgcwxhnxpyxshmdqjgztdppbfbhzhhjyfdzwkgkzbldnzsxhqeeg"
"zxylzmmzyjzgszxkhkhtxexxgylyapsthxdwhzydpxagkydxbhnhnkdnjnmyhylpmgecslnzhkxxlbzzlbmlsfbhhgsgyyggbhsc"
"yajtxglxtzmcwzydqdqmngdnllszhngjzwfyhqswscelqajynytlsxthaznkzzsdhlaxxtwwcjhqqtddwzbcchyqzflxpslzqgpz"
"sznglydqtbdlxntctajdkywnsyzljhhdzckryyzywmhychhhxhjkzwsxhdnxlyscqydpslyzwmypnkxyjlkchtyhaxqsyshxasmc"
"hkdscrsgjpwqsgzjlwwschsjhsqnhnsngndantbaalczmsstdqjcjktscjnxplggxhhgoxzcxpdmmhldgtybynjmxhmrzplxjzck"
"zxshflqxxcdhxwzpckczcdytcjyxqhlxdhypjqxnlsyydzozjnhhqezysjyayxkypdgxddnsppyzndhthrhxydpcjjhtcnnctlhb"
"ynyhmhzllnnxmylllmdcppxhmxdkycyrdltxjchhznxclcclylnzsxnjzzlnnnnwhyqsnjhxynttdkyjpychhyegkcwtwlgjrlgg"
"tgtygyhpyhylqyqgcwyqkpyyettttlhyylltyttsylnyzwgywgpydqqzzdqnnkcqnmjjzzbxtqfjkdffbtkhzkbxdjjkdjjtlbwf"
"zpptkqtztgpdwntpjyfalqmkgxbcclzfhzcllllanpnxtjklcclgyhdzfgyddgcyyfgydxkssendhykdndknnaxxhbpbyyhxccga"
"pfqyjjdmlxcsjzllpcnbsxgjyndybwjspcwjlzkzddtacsbkzdyzypjzqsjnkktknjdjgyepgtlnyqnacdntcyhblgdzhbbydmjr"
"egkzyheyybjmcdtafzjzhgcjnlghldwxjjkytcyksssmtwcttqzlpbszdtwcxgzagyktywxlnlcpbclloqmmzsslcmbjcsdzkydc"
"zjgqjdsmcytzqqlnzqzxssbpkdfqmddzzsddtdmfhtdycnaqjqkypbdjyyxtljhdrqxlmhkydhrnlklytwhllrllrcxylbnsrnzz"
"symqzzhhkyhxksmzsyzgcxfbnbsqlfzxxnnxkxwymsddyqnggqmmyhcdzttfgyyhgsbttybykjdnkyjbelhdypjqnfxfdnkzhqks"
"byjtzbxhfdsbdaswpawajldyjsfhblcnndnqjtjnchxfjsrfwhzfmdrfjyxwzpdjkzyjympcyznynxfbytfyfwygdbnzzzdnytxz"
"emmqbsqehxfznbmflzzsrsyqjgsxwzjsprytjsjgskjjgljjynzjjxhgjkymlpyyycxycgqzswhwlyrjlpxslcxmnsmwklcdnkny"
"npsjszhdzeptxmwywxyysywlxjqcqxzdclaeelmcpjpclwbxsqhfwrtfnjtnqjhjqdxhwlbyccfjlylkyynldxnhycstyywncjtx"
"ywtrmdrqnwqcmfjdxzmhmayxnwmyzqtxtlmrspwwjhanbxtgzypxyyrrclmpamgkqjszycymyjsnxtplnbappypylxmyzkynldgy"
"jzcchnlmzhhanqnbgwqtzmxxmllhgdzxnhxhrxycjmffxywcfsbssqlhnndycannmtcjcypnxnytycnnymnmsxndlylysljnlxys"
"sqmllyzlzjjjkyzzcsfbzxxmstbjgnxnchlsnmcjscyznfzlxbrnnnylmnrtgzqysatswryhyjzmgdhzgzdwybsscskxsyhytsxg"
"cqgxzzbhyxjscrhmkkbsczjyjymkqhzjfnbhmqhysnjnzybknqmcjgqhwlsnzswxkhljhyybqcbfcdsxdldspfzfskjjzwzxsddx"
"jseeegjscssygclxxnwwyllymwwwgydkzjggggggsycknjwnjpcxbjjtqtjwdsspjxcxnzxnmelptfsxtllxcljxjjljsxctnswx"
"lennlyqrwhsycsqnybyaywjejqfwqcqqcjqgxaldbzzyjgkgxbltqyfxjltpydkyqhpmatlcndnkxmtxynhklefxdllegqtymsaw"
"hzmljtkynxlyjzljeeyybqqffnlyxhdsctgjhxywlkllxqkcctnhjlqmkkzgcyygllljdcgydhzwypysjbzjdzgyzzhywyfqdtyz"
"szyezklymgjjhtsmqwyzljyywzcsrkqyqltdxwcdrjalwsqzwbdcqyncjnnszjlncdcdtlzzzacqqzzddxyblxcbqjylzllljddz"
"jgyqyjzyxnyyyexjxksdaznyrdlzyyynjlslldyxjcykywnqcclddnyyynycgczhjxcclgzqjgnwnncqqjysbzzxyjxjnxjfzbsb"
"dsfnsfpzxhdwztdmpptflzzbzdmyypqjrsdzsqzsqxbdgcpzswdwcsqzgmdhzxmwwfybpngphdmjthzsmmbgzmbzjcfzhfcbbnmq"
"dfmbcmcjxlgpnjbbxgyhyyjgptzgzmqbqdcgybjxlwnkydpdymgcftpfxyztzxdzxtgkptybbclbjaskytssqyymscxfjhhlslls"
"jpqjjqaklyldlycctsxmcwfgngbqxllllnyxtyltyxytdpjhnhgnkbyqnfjyyzbyyessessgdyhfhwtcqbsdzjtfdmxhcnjzymqw"
"srxjdzjqbdqbbsdjgnfbknbxdkqhmkwjjjgdllthzhhyyyyhhsxztyyyccbdbpypzyccztjpzywcbdlfwzcwjdxxhyhlhwczxjtc"
"nlcdpxnqczczlyxjjcjbhfxwpywxzpcdzzbdccjwjhmlxbqxxbylrddgjrrctttgqdczwmxfytmmzcwjwxyywzzkybzcccttqnhx"
"nwxxkhkfhtswoccjybcmpzzykbnnzpbthhjdlszddytyfjpxyngfxbyqxzbhxcpxxtnzdnnycnxsxlhkmzxlthdhkghxxsshqyhh"
"cjyxglhzxcxnhekdtgqxqypkdhentykcnymyyjmkqyyyjxzlthhqtbyqhxbmyhsqckwwyllhcyylnneqxqwmcfbdccmljggxdqkt"
"lxkknqcdgcjwyjjlyhhqyttnwchhxcxwherzjydjccdbqcdgdnyxzdhcqrxcbhztqcbxwgqwyybxhmbymykdyecmqkyaqyngyzsl"
"fnkkqgyssqyshngjctxkzycssbkyxhyylstycxqthysmnscpmmgcccccmnztasmgqzjhklosjylswtmqzyqkdzljqqyplzycztcq"
"qpbbcjzclpkhqcyyxxdtdddsjcxffllchqxmjlwcjcxtspycxndtjshjwhdqqqckxyamylsjhmlalygxcyydmamdqmlmcznnyybz"
"xkyflmcncmlhxrcjjhsylnmtjggzgywjxsrxcwjgjqhqzdqjdcjjskjkgdzcgjjyjylxzxxcdqhhheslmhlfsbdjsyyshfyssczq"
"lpbdrfnztzdkykhsccgkwtqzckmsynbcrxqbjyfaxpzzedzcjykbcjwhyjbqzzywnyszptdkzpfpbaztklqnhbbzptpptyzzybhn"
"ydcpzmmcycqmcjfzzdcmnlfpbplngqjtbttajzpzbbdnjkljqylnbzqhksjznggqstzkcxchpzsnbcgzkddzqanzgjkdrtlzldwj"
"njzlywtxndjzjhxnatncbgtzcsskmljpjytsnwxcfjwjjtkhtzplbhsnjssyjbhbjyzlstlsbjhdnwqpslmmfbjdwajyzccjtbnn"
"nzwxxcdslqgdsdpdzgjtqqpsqlyyjzlgyhsdlctcbjtktyczjtqkbsjlgnnzdncsgpynjzjjyyknhrpwszxmtncszzyshbyhyzax"
"ywkcjtllckjjtjhgcssxyqyczbynnlwqcglzgjgqyqcczssbcrbcskydznxjsqgxssjmecnstjtpbdlthzwxqwqczexnqczgwesg"
"ssbybstscslccgbfsdqnzlccglllzghzcthcnmjgyzazcmsksstzmmzckbjygqljyjppldxrkzyxccsnhshhdznlzhzjjcddcbcj"
"xlbfqbczztpqdnnxljcthqzjgylklszzpcjdscqjhjqkdxgpbajynnsmjtzdxlcjyryynhjbngzjkmjxltbsllrzpylssznxjhll"
"hyllqqzqlsymrcncxsljmlzltzldwdjjllnzggqxppskyggggbfzbdkmwggcxmcgdxjmcjsdycabxjdlnbcddygskydqdxdjjyxh"
"saqazdzfslqxxjnqzylblxxwxqqzbjzlfbblylwdsljhxjyzjwtdjcyfqzqzzdzsxzzqlzcdzfxhwspynpqzmlpplffxjjnzzyls"
"jnyqzfpfzgsywjjjhrdjzzxtxxglghtdxcskyswmmtcwybazbjkshfhgcxmhfqhyxxyzftsjyzbxyxpzlchmzmbxhzzssyfdmncw"
"dabazlxktcshhxkxjjzjsthygxsxyyhhhjwxkzxssbzzwhhhcwtzzzpjxsyxqqjgzyzawllcwxznxgyxyhfmkhydwsqmnjnaycys"
"pmjkgwcqhylajgmzxhmmcnzhbhxclxdjpltxyjkdyylttxfqzhyxxsjbjnayrsmxyplckdnyhlxrlnllstycyyqygzhhsccsmcct"
"zcxhyqfpyyrpbflfqnntszlljmhwtcjqyzwtlnmlmdwmbzzsnzrbpdddlqjjbxtcsnzqqygwcsxfwzlxccrszdzmcyggdyqsgtnn"
"nlsmymmsyhfbjdgyxccpshxczcsbsjyygjmpbwaffyfnxhydxzylremzgzzyndsznlljcsqfnxxkptxzgxjjgbmyyssnbtylbnlh"
"bfzdcyfbmgqrrmzszxysjtznnydzzcdgnjafjbdknzblczszpsgcycjszlmnrznbzzldlnllysxsqzqlcxzlsgkbrxbrbzcycxzj"
"zeeyfgklzlnyhgzcgzlfjhgtgwkraajyzkzqtsshjjxdzyznynnzyrzdqqhgjzxsszbtkjbbfrtjxllfqwjgclqtymblpzdxtzag"
"bdhzzrbgjhwnjtjxlkscfsmwlldcysjtxkzscfwjlbnntzlljzllqblcqmqqcgcdfpbphzczjlpyyghdtgwdxfczqyyyqysrclqz"
"fklzzzgffcqnwglhjycjjczlqzzyjbjzzbpdcsnnjgxdqnknlznnnnpsntsdyfwwdjzjysxyyczcyhzwbbyhxrylybhkjksfxtjj"
"mmchhlltnyymsxxyzpdjjycsycwmdjjkqyrhllngpngtlyycljnnnxjyzfnmlrgjjtyzbsyzmsjyjhgfzqmsyxrszcytlrtqzsst"
"kxgqkgsptgxdnjsgcqcqhmxggztqydjjznlbznxqlhyqgggthqscbyhjhhkyygkggcmjdzllcclxqsftgjslllmlcskctbljszsz"
"mmnytpzsxqhjcnnqnyexzqzcpshkzzyzxxdfgmwqrllqxrfztlystctmjcsjjthjnxtnrztzfqrhcgllgcnnnnjdnlnnytsjtlny"
"xsszxcgjzyqpylfhdjsbbdczgjjjqzjqdybssllcmyttmqnbhjqmnygjyeqyqmzgcjkpdcnmyzgqllslnclmholzgdylfzslncnz"
"lylzcjeshnyllnxnjxlyjyyyxnbcljsswcqqnnyllzldjnllzllbnylnqchxyyqoxccqkyjxxxyklksxeyqhcqkkkkcsnyxxyqxy"
"gwtjohthxpxxhsnlcykychzzcbwqbbwjqcscszsslcylgddsjzmmymcytsdsxxscjpqqsqylyfzychdjynywcbtjsydchcyddjlb"
"djjsodzyqyskkyxdhhgqjyohdyxwgmmmazdybbbppbcmnnpnjzsmtxerxjmhqdntpjdcbsnmssythjtslmltrcplzszmlqdsdmjm"
"qpnqdxcfrnnfsdqqyxhyaykqyddlqyyysszbydslntfgtzqbzmchdhczcwfdxtmqqsphqwwxsrgjcwnntzcqmgwqjrjhtqjbbgwz"
"fxjhnqfxxqywyyhyscdydhhqmrmtmwctbszppzzglmzfollcfwhmmsjzttdhlmyffytzzgzyskjjxqyjzqbhmbzclyghgfmshpcf"
"zsnclpbqsnjyzslxxfpmtyjygbxlldlxpzjyzjyhhzcywhjylsjexfszzywxkzjlnadymlymqjpwxxhxsktqjezrpxxzghmhwqpw"
"qlyjjqjjzszcnhjlchhnxjlqwzjhbmzyxbdhhypylhlhlgfwlcfyytlhjjcwmscpxstkpnhjxsntyxxtestjctlsslstdlllwwyh"
"dnrjzsfgxssyczykwhtdhwjglhtzdqdjzxxqgghltzphcsqfclnjtclzpfstpdynylgmjllycqhynspchylhqyqtmzymbywrfqyk"
"jsyslzdnjmpxyyssrhzjnyqtqdfzbwwdwwrxcwggyhxmkmyyyhmxmzhnksepmlqqmtcwctmxmxjpjjhfxyyzsjzhtybmstsyjznq"
"jnytlhynbyqclcycnzwsmylknjxlggnnpjgtysylymzskttwlgsmzsylmpwlcwxwqcssyzsyxyrhssntsrwpccpwcmhdhhxzdzyf"
"jhgzttsbjhgyglzysmyclllxbtyxhbbzjkssdmalhhycfygmqypjyjqxjllljgclzgqlycjcctotyxmtmshllwlqfxymzmklpszz"
"cxhkjyclctyjcyhxsgyxnnxlzwpyjpxhjwpjpwxqqxlxsdhmrslzzydwdtcxknstzshbsccstplwsscjchjlcgchssphylhfhhxj"
"sxallnylmzdhzxylsxlmzykcldyahlcmddyspjtqjzlngjfsjshctsdszlblmssmnyymjqbjhrzwtyydchjljapzwbgqxbkfnbjd"
"llllyylsjydwhxpsbcmljpscgbhxlqhyrljxyswxhhzlldfhlnnymjljyflyjycdrjlfsyzfsllcqyqfgqyhnszlylmdtdjcnhbz"
"llnwlqxygyyhbmgdhxxnhlzzjzxczzzcyqzfngwpylcpkpykpmclgkdgxzgxwqbdxzzkzfbddlzxjtpjpttbythzzdwslcpnhslt"
"jxxqlhyxxxywzyswttzkhlxzxzpyhgzhknfsyhntjrnxfjcpjztwhplshfcrhnslxxjxxyhzqdxqwnnhyhmjdbflkhcxcwhjfyjc"
"fpqcxqxzyyyjygrpynscsnnnnchkzdyhflxxhjjbyzwttxnncyjjymswyxqrmhxzwfqsylznggbhyxnnbwttcsybhxxwxyhhxyxn"
"knyxmlywrnnqlxbbcljsylfsytjzyhyzawlhorjmnsczjxxxyxchcyqryxqzddsjfslyltsffyxlmtyjmnnyyyxltzcsxqclhzxl"
"wyxzhnnlrxkxjcdyhlbrlmbrdlaxksnlljlyxxlynrylcjtgncmtlzllcyzlpzpzyawnjjfybdyyzsepckzzqdqpbpsjpdyttbdb"
"bbyndycncpjmtmlrmfmmrwyfbsjgygsmdqqqztxmkqwgxllpjgzbqrdjjjfpkjkcxbljmswldtsjxldlppbxcwkcqqbfqbccajzg"
"mykbhyhhzykndqzybpjnspxthlfpnsygyjdbgxnhhjhzjhstrstldxskzysybmxjlxyslbzyslzxjhfybqnbylljqkygzmcyzzym"
"ccslnlhzhwfwyxzmwyxtynxjhbyymcysbmhysmydyshnyzchmjjmzcaahcbjbbhblytylsxsnxgjdhkxxtxxnbhnmlngsltxmrhn"
"lxqqxmzllyswqgdlbjhdcgjyqyymhwfmjybbbyjyjwjmdpwhxqldyapdfxxbcgjspckrssyzjmslbzzjfljjjlgxzgyxyxlszqkx"
"bexyxhgcxbpndyhwectwwcjmbtxchxyqqllxflyxlljlssnwdbzcmyjclwswdczpchqekcqbwlcgydblqppqzqfnqdjhymmcxtxd"
"rmzwrhxcjzylqxdyynhyyhrslnrsywwjjymtltllgtqcjzyabtckzcjyccqlysqxalmzynywlwdnzxqdllqshgpjfjljnjabcqzd"
"jgthhsstnyjfbswzlxjxrhgldlzrlzqzgsllllzlymxxgdzhgbdphzpbrlwnjqbpfdwonnnhlypcnjccndmbcpbzzncyqxldomzb"
"lzwpdwyygdstthcsqsccrsssyslfybnntyjszdfndpdhtqzmbqlxlcmyffgtjjqwftmnpjwdnlbzcmmcngbdzlqlpnfhyymjylsd"
"chdcjwjcctljcldtljjcbddpndsszycndbjlggjzxsxnlycybjjxxcbylzcfzppgkcxqdzfztjjfjdjxzbnzyjqctyjwhdyczhym"
"djxttmpxsplzcdwslshxypzgtfmlcjtacbbmgdewycyzxdszjyhflystygwhkjyylsjcxgywjcbllcsnddbtzbsclyzczzssqdll"
"mjyyhfllqllxfdyhabxggnywyypllsdldllbjcyxjznlhljdxyyqytdlllbngpfdfbbqbzzmdpjhgclgmjjpgaehhbwcqxajhhhz"
"chxyphjaxhlphjpgpzjqcqzgjjzzgzdmqyybzzphyhybwhazyjhykfgdpfqsdlzmljxjpgalxzdaglmdgxmmzqwtxdxxpfdmmssy"
"mpfmdmmkxksyzyshdzkjsysmmzzzmdydyzzczxbmlstmdyemxckjmztyymzmzzmsshhdccjewxxkljsthwlsqlyjzllsjssdppmh"
"nlgjczyhmxxhgncjmdhxtkgrmxfwmckmwkdcksxqmmmszzydkmsclcmpcjmhrpxqpzdsslcxkyxtwlkjyahzjgzjwcjnxyhmmbml"
"gjxmhlmlgmxctkzmjlyscjsyszhsyjzjcdajzhbsdqjzgwtkqxfkdmsdjlfmnhkzqkjfeypzyszcdpynffmzqykttdzzefmzlbnp"
"plplpbpszalltnlkckqzkgenjlwalkxydpxnhsxqnwqnkxqclhyxxmlnccwlymqyckynnlcjnszkpyzkcqzqljbdmdjhlasqlbyd"
"wqlwdgbqcryddztjybkbwszdxdtnpjdtcnqnfxqqmgnseclstbhpwslctxxlpwydzklnqgzcqapllkqcylbqmqczqcnjslqzdjxl"
"ddhpzqdljjxzqdjyzhhzlkcjqdwjppypqakjyrmpzbnmcxkllzllfqpylllmbsglzysslrsysqtmxyxzqzbscnysyztffmzzsmzq"
"hzssccmlyxwtpzgxzjgzgsjzgkddhtqggzllbjdzlsbzhyxyzhzfywxytymsdnzzyjgtcmtnxqyxjscxhslnndlrytzlryylxqht"
"xsrtzcgyxbnqqzfhykmzjbzymkbpnlyzpblmcnqyzzzsjztjctzhhyzzjrdyzhnfxklfzslkgjtctssyllgzrzbbjzzklpkbczys"
"nnyxbjfbnjzzxcdwlzyjxzzdjjgggrsnjkmsmzjlsjywqsnyhqjsxpjztnlsnshrnynjtwchglbnrjlzxwjqxqkysjycztlqzybb"
"ybyzjqdwgyzcytjcjxckcwdkkzxsnkdnywwyyjqyytlytdjlxwkcjnklccpzcqqdzzqlcsfqchqqgssmjzzllbjjzysjhtsjdysj"
"qjpdszcdchjkjzzlpycgmzndjxbsjzzsyzyhgxcpbjydssxdzncglqmbtsfcbfdzdlznfgfjgfsmpnjqlnblgqcyyxbqgdjjqsrf"
"kztjdhczklbsdzcfytplljgjhtxzcsszzxstjygkgckgynqxjplzbbbgcgyjzgczqszlbjlsjfzgkqqjcgycjbzqtldxrjnbsxxp"
"zshszycfwdsjjhxmfczpfzhqhqmqnknlyhtycgfrzgnqxcgpdlbzcsczqlljblhbdcypscppdymzzxgyhckcpzjgslzlnscnsldl"
"xbmsdlddfjmkdqdhslzxlsznpqpgjdlybdskgqlbzlnlkyyhzttmcjnqtzzfszqktlljtyyllnllqyzqlbdzlslyyzxmdfszsnxl"
"xznczqnbbwskrfbcylctnblgjpmczzlstlxshtzcyzlzbnfmqnlxflcjlyljqcbclzjgnsstbrmhxzhjzclxfnbgxgtqncztmsfz"
"kjmssncljkbhszjntnlzdntlmmjxgzjyjczxyhyhwrwwqnztnfjscpyshzjfyrdjsfscjzbjfzqzchzlxfxsbzqlzsgyftzdcszx"
"zjbjpszkjrhxjzcgbjkhcggtxkjqglxbxfgtrtylxqxhdtsjxhjzjjcmzlcqsbtxwqgxtxxhxftsdkfjhzyjfjxnzldlllcqsqqz"
"qwqxswqtwgwbzcgcllqzbclmqjtzgzyzxljfrmyzflxnsnxxjkxrmjdzdmmyxbsqbhgzmwfwygmjlzbyytgzyccdjyzxsngnyjyz"
"nbgpzjcqsyxsxrtfyzgrhztxszzthcbfclsyxzlzqmzlmplmxzjssfsbysmzqhxxnxrxhqzzzsslyflczjrcrxhhzxqndshxsjjh"
"qcjjbcynsysxjbqjpxzqplmlxzkyxlxcnlcycxxzzlxdlllmjyhzxhyjwkjrwyhcpsgnrzlfzwfzznsxgxflzsxzzzbfcsyjdbrj"
"krdhhjxjljjtgxjxxstjtjxlyxqfcsgswmsbctlqzzwlzzkxjmltmjyhsddbxgzhdlbmyjfrzfcgclyjbpmlysmsxlszjqqhjzfx"
"gfqfqbphngyyqxgztnqwyltlgwgwwhnlfmfgzjmgmgbgtjflyzzgzyzaflsspmlbflcwbjztljjmzlpjjlymqtmyyyfbgygqzgly"
"zdxqyxrqqqhsxyyqxygjtyxfsfsllgnqcygycwfhcccfxpylypllzqxxxxxqqhhsshjzcftsczjxspzwhhhhhapylqnlpqafyhxd"
"ylnkmzqgggddesrenzltzgchyppcsqjjhclljtolnjpzljlhymhezdydsqycddhgznndzclzywllznteydgnlhslpjjbdgwxpcnn"
"tycklkclwkllcasstknzdnnjttlyyzssysszzryljqkcgdhhyrxrzydgrgcwcgzqffbppjfzynakrgywyjpqxxfkjtszzxswzddf"
"bbqtbgtzkznpzfpzxzpjszbmqhkyyxyldkljnypkyghgdzjxxeaxpnznctzcmxcxmmjxnkszqnmnlwbwwqjjyhclstmcsxnjcxxt"
"pcnfdtnnpglllzcjlspblpgjcdtnjjlyarscffjfqwdpgzdwmrzzcgodaxnssnyzrestyjwjyjdbcfxnmwttbqlwstszgybljpxg"
"lbnclgpcbjftmxzljylzxcltpnclcgxtfzjshcrxsfysgdkntlbyjcyjllstgqcbxnhzxbxklylhzlqzlnzcqwgzlgzjncjgcmnz"
"zgjdzxtzjxycyycxxjyyxjjxsssjstsstdppghtcsxwzdcsynptfbchfbblzjclzzdbxgcjlhpxnfzflsyltnwbmnjhszbmdnbcy"
"sccldnycndqlyjjhmqllcsgljjsyfpyyccyltjantjjpwycmmgqyysxdxqmzhszxbftwwzqswqrfkjlzjqqyfbrxjhhfwjgzyqac"
"myfrhcyybynwlpexcczsyyrlttdmqlrkmpbgmyyjprkznbbsqyxbhyzdjdnghpmfsgbwfzmfqmmbzmzdcgjlnnnxyqgmlrygqccy"
"xzlwdkcjcggmcjjfyzzjhycfrrcmtznzxhkqgdjxccjeascrjthpljlrzdjrbcqhjdnrhylyqjsymhzydwcdfryhbbydtssccwbx"
"glpzmlzjdqsscfjmmxjcxjytycghycjwynsxlfemwjnmkllswtxhyyyncmmcyjdqdjzglljwjnkhpzggflccsczmcbltbhbqjxqd"
"jpdjztghglfjawbzyzjltstdhjhctcbchflqmpwdshyytqwcnntjtlnnmnndyyyxsqkxwyyflxxnzwcxypmaelyhgjwzzjbrxxaq"
"jfllpfhhhytzzxsgqjmhspgdzqwbwpjhzjdyjcqwxkthxsqlzyymysdzgnqckknjlwpnsyscsyzlnmhqsyljxbcxtlhzqzpcycyk"
"pppnsxfyzjjrcemhszmnxlxglrwgcstlrsxbygbzgnxcnlnjlclynymdxwtzpalcxpqjcjwtcyyjlblxbzlqmyljbghdslssdmxm"
"bdczsxyhamlczcpjmcnhjyjnsykchskqmczqdllkablwjqsfmocdxjrrlyqchjmybyqlrhetfjzfrfksryxfjdwtsxxywsqjysly"
"xwjhsdlxyyxhbhawhwjcxlmyljcsqlkydttxbzslfdxgxsjkhsxxybssxdpwncmrptqzczenygcxqfjxkjbdmljzmqqxnoxslyxx"
"lylljdzptymhbfsttqqwlhsgynlzzalzxclhtwrrqhlstmypyxjjxmnsjnnbryxyjllyqyltwylqyfmlkljdnlltfzwkzhljmlhl"
"jnljnnlqxylmbhhlnlzxqchxcfxxlhyhjjgbyzzkbxscqdjqdsndzsygzhhmgsxcsymxfepcqwwrbpyyjqryqcyjhqqzyhmwffhg"
"zfrjfcdbxntqyzpcyhhjlfrzgpbxzdbbgrqstlgdgylcqmgchhmfywlzyxkjlypjhsywmqqggzmnzjnsqxlqsyjtcbehsxfszfxz"
"wfllbcyyjdytdthwzsfjmqqyjlmqsxlldttkghybfpwdyysqqrnqwlgwdebzwcyygcnlkjxtmxmyjsxhybrwfymwfrxyymxysctz"
"ztfykmldhqdlgyjnlcryjtlpsxxxywlsbrrjwxhqybhtydnhhxmmywytycnnmnssccdalwztcpqpyjllqzyjswjwzzmmglmxclmx"
"nzmxmzsqtzppjqblpgxjzhfljjhycjsrxwcxsncdlxsyjdcqzxslqyclzxlzzxmxqrjmhrhzjbhmfljlmlclqnldxzlllfyprgjy"
"nxcqqdcmqjzzxhnpnxzmemmsxykynlxsxtljxyhwdcwdzhqyybgybcyscfgfsjnzdrzzxqxrzrqjjymcanhrjtldbpyzbstjhxxz"
"ypbdwfgzzrpymnnkxcqbyxnbnfyckrjjcmjegrzgyclnnzdnkknsjkcljspgyyclqqjybzssqlllkjftbgtylcccdblsppfylgyd"
"tzjqjzgkntsfcxbdkdxxhybbfytyhbclnnytgdhryrnjsbtcsnyjqhklllzslydxxwbcjqsbxnpjzjzjdzfbxxbrmladhcsnclbj"
"dstblprznswsbxbcllxxlzdnzsjpynyxxyftnnfbhjjjgbygjpmmmmsszljmtlyzjxswxtyledqpjmpgqzjgdjlqjwjqllsdgjgy"
"gmscljjxdtygjqjjjcjzcjgdzdshqgzjggcjhqxsnjlzzbxhsgzxcxyljxyxyydfqqjhjfxdhctxjyrxysqtjxyefyyssyxjxncy"
"zxfxcsxszxyyschshxzzzgzzzgfjdldylnpzgsjaztyqzpbxcbdztzczyxxyhhscjshcggqhjhgxhsctmzmehyxgebtclzkkwytj"
"zrslekestdbcyhqqsayxcjxwwgsphjszsdncsjkqcxswxfctynydpccczjqtcwjqjzzzqzljzhlsbhpydxpsxshhezdxfptjqyzc"
"xhyaxncfzyyhxgnqmywntzsjbnhhgymxmxqcnssbcqsjyxxtyyhybcqlmmszmjzzllcogxzaajzyhjmchhcxzsxsdznleyjjzjbh"
"zwjzsqtzpsxzzdsqjjjlnyazphhyysrnqzthzhnyjyjhdzxzlswclybzyecwcycrylchzhzydzydyjdfrjjhtrsqtxyxjrjhojyn"
"xelxsfsfjzghpzsxzszdzcqzbyyklsgsjhczshdgqgxyzgxchxzjwyqwgyhksseqzzndzfkwyssdclzstsymcdhjxxyweyxczayd"
"mpxmdsxybsqmjmzjmtjqlpjyqzcgqhyjhhhqxhlhdldjqcfdwbsxfzzyyschtytyjbhecxhjkgqfxbhyzjfxhwhbdzfyzbchpnpg"
"dydmsxhkhhmamlnbyjtmpxejmcthqbzyfcgtyhwphftgzzezsbzegpbmdskftycmhbllhgpzjxzjgzjyxzsbbqsczzlzscstpgxm"
"jsfdcczjzdjxsybzlfcjsazfgszlwbczzzbyztzynswyjgxzbdsynxlgzbzfygczxbzhzftpbgzgejbstgkdmfhyzzjhzllzzgjq"
"zlsfdjsscbzgpdlfzfzszyzyzsygcxsnxxchczxtzzljfzgqsqqxcjqccccdjcdszzyqjccgxztdlgscxzsyjjqtcclqdqztqchq"
"qyzynzzzpbkhdjfcjfztypqyqttynlmbdktjcpqzjdzfpjsbnjlgyjdxjdcqkzgqkxclbzjtcjdqbxdjjjstcxnxbxqmslyjcxnt"
"jqwwcjjnjjlllhjcwqtbzqqczczpzzdzyddcyzdzccjgtjfzdprntctjdcxtqzdtjnplzbcllctdsxkjzqdmzlbznbtjdcxfczdb"
"czjjltqqpldckztbbzjcqdcjwynllzlzccdwllxwzlxrxntqjczxkjlsgdnqtddglnlajjtnnynkqlldzntdnycygjwyxdxfrsqs"
"tcdenqmrrqzhhqhdldazfkapbggpzrebzzykyqspeqjjglkqzzzjlysyhyzwfqznlzzlzhwcgkypqgnpgblplrrjyxcccgyhsfzf"
"wbzywtgzxyljczwhncjzplfflgskhyjdeyxhlpllllcygxdrzelrhgklzzyhzlyqszzjzqljzflnbhgwlczcfjwspyxzlzlxgccp"
"zbllcxbbbbnbbcbbcrnnzccnrbbnnldcgqyyqxygmqzwnzytyjhyfwtehznjywlccntzyjjcdedpwdztstnjhtymbjnyjzlxtsst"
"phndjxxbyxqtzqddtjtdyztgwscszqflshlnzbcjbhdlyzjyckwtydylbnydsdsycctyszyyebgexhqddwnygyclxtdcystqnygz"
"ascsszzdzlcclzrqxyywljsbymxshzdembbllyyllytdqyshymrqnkfkbfxnnsbychxbwjyhtqbpbsbwdzylkgzskyghqzjxhxjx"
"gnljkzlyycdxlfwfghljgjybxblybxqpqgntzplncybxdjyqydymrbeyjyyhkxxstmxrczzjwxyhybmcflyzhqyzfwxdbxbcwzms"
"lpdmyckfmzklzcyqycclhxfzlydqzpzygyjyzmdxtzfnnyttqtzhgsfcdmlccytzxjcytjmkslpzhysnwllytpzctzccktxdhxxt"
"qcyfksmqccyyazhtjplylzlyjbjxtfnyljyynrxcylmmnxjsmybcsysslzylljjgyldzdlqhfzzblfndsqkczfyhhgqmjdsxyctt"
"xnqnjpyybfcjtyyfbnxejdgyqbjrcnfyyqpghyjsyzngrhtknlnndzntsmgklbygbpyszbydjzsstjztsxzbhbscsbzczptqfzlq"
"flypybbjgszmnxdjmtsyskkbjtxhjcegbsmjyjzcstmljyxrczqscxxqpyzhmkyxxxjcljyrmyygadyskqlnadhrskqxzxztcggz"
"dlmlwxybwsyctbhjhcfcwzsxwwtgzlxqshnyczjxemplsrcgltnzntlzjcyjgdtclglbllqpjmzpapxyzlaktkdwczzbncctdqqz"
"qyjgmcdxltgcszlmlhbglkznnwzndxnhlnmkydlgxdtwcfrjerctzhydxykxhwfzcqshknmqqhzhhymjdjskhxzjzbzzxympajnm"
"ctbxlsxlzynwrtsqgscbptbsgzwyhtlkssswhzzlyytnxjgmjrnsnnnnlskztxgxlsammlbwldqhylakqcqctmycfjbslxclzjcl"
"xxknbnnzlhjphqplsxsckslnhpsfqcytxjjzljldtzjjzdlydjntptnndskjfsljhylzqqzlbthydgdjfdbyadxdzhzjnthqbykn"
"xjjqczmlljzkspldsclbblnnlelxjlbjycxjxgcnlcqplzlznjtsljgyzdzpltqcssfdmnycxgbtjdcznbgbqyqjwgkfhtnbyqzq"
"gbkpbbyzmtjdytblsqmbsxtbnpdxklemyycjynzdtldykzzxtdxhqshygmzsjycctayrzlpwltlkxslzcggexclfxlkjrtlqjaqz"
"ncmbqdkkcxglczjzxjhptdjjmzqykqsecqzdshhadmlzfmmzbgntjnnlhbyjbrbtmlbyjdzxlcjlpldlpcqdhlhzlycblcxccjad"
"qlmzmmsshmybhbnkkbhrsxxjmxmdznnpklbbrhgghfchgmnklltsyyycqlcskymyehywxnxqywbawykqldnntndkhqcgdqktgpkx"
"hcpdhtwnmssyhbwcrwxhjmkmzngwtmlkfghkjyldyycxwhyyclqhkqhtdqkhffldxqwytyydesbpkyrzpjfyyzjceqdzzdlattpb"
"fjllcxdlmjsdxegwgsjqxcfbssszpdyzcxznyxppzydlyjccpltxlnxyzyrscyyytylwwndsahjsygyhgywwaxtjzdaxysrltdps"
"syxfnejdxyzhlxlllzhzsjnyqyqyxyjghzgjcyjchzlycdshhsgczyjscllnxzjjyyxnfsmwfpyllyllabmddhwzxjmcxztzpmlq"
"chsfwzynctlndywlslxhymmylmbwwkyxyaddxylldjpybpwnxjmmmllhafdllaflbnhhbqqjqzjcqjjdjtffkmmmpythygdrjrdd"
"wrqjxnbysrmzdbyytbjhpymyjtjxaahggdqtmystqxkbtzbkjlxrbyqqhxmjjbdjntgtbxpgbktlgqxjjjcdhxqdwjlwrfmjgwqh"
"cnrxswgbtgygbwhswdwrfhwytjjxxxjyzyslphyypyyxhydqpxshxyxgskqhywbdddpplcjlhqeewjgsyykdpplfjthkjltcyjhh"
"jttpltzzcdlyhqkcjqysteeyhkyzyxxyysddjkllpymqyhqgxqhzrhbxpllnqydqhxsxxwgdqbshyllpjjjthyjkyphthyyktyez"
"yenmdshlzrpqfbnfxzbsftlgxsjbswyysksflxlpplbbblnsfbfyzbsjssylpbbffffsscjdstjsxtryjcyffsyzyzbjtlctsbsd"
"hrtjjbytcxyyeylycbnebjdsysyhgsjzbxbytfzwgenhhhthjhhxfwgcstbgxklstyymtmbyxjskzscdyjrcythxzfhmymcxlzns"
"djtxtxrycfyjsbsdyerxhljxbbdeynjghxgckgscymblxjmsznskgxfbnbbthfjyafxwxfbxmyfhdttcxzzpxrsywzdlybbktyqw"
"qjbzypzjznjpzjlztfysbttslmptzrtdxqsjehbnylndxljsqmlhtxtjecxalzzspktlzkqqyfsyjywpcpqfhjhytqxzkrsgtksq"
"czlptxcdyyzsslzslxlzmacpcqbzyxhbsxlzdltztjtylzjyytbzypltxjsjxhlbmytxcqrblzssfjzztnjytxmyjhlhpblcyxqj"
"qqkzzscpzkswalqsplczzjsxgwwwygyatjbbctdkhqhkgtgpbkqyslbxbbckbmllndzstbklggqkqlzbkktfxrmdkbftpzfrtppm"
"ferqnxgjpzsstlbztpszqzsjdhljqlzbpmsmmsxlqqnhknblrddnhxdkddjcyyljfqgzlgsygmjqjkhbpmxyxlytqwlwjcpbmjxc"
"yzydrjbhtdjyeqshtmgsfyplwhlzffnynnhxqhpltbqpfbjwjdbygpnxtbfzjgnnntjshxeawtzylltyqbwjpgxghnnkndjtmszs"
"qynzggnwqtfhclssgmnnnnynzqqxncjdqgzdlfnykljcjllzlmzznnnnsshthxjlzjbbhqjwwycrdhlyqqjbeyfsjhthnrnwjhwp"
"slmssgzttygrqqwrnlalhmjtqjsmxqbjjzjqzyzkxbjqxbjxshzssfglxmxnxfghkzszggslcnnarjxhnlllmzxelglxydjytlfb"
"kbpnlyzfbbhptgjkwetzhkjjxzxxglljlstgshjjyqlqzfkcgnndjsszfdbctwwseqfhqjbsaqtgypjlbxbmmywxgslzhglsgnyf"
"ljbyfdjfngsfmbyzhqffwjsyfyjjphzbyyzffwotjnlmftwlbzgyzqxcdjygzyyryzynyzwegazyhjjlzrthlrmgrjxzclnnnljj"
"yhtbwjybxxbxjjtjteekhwslnnlbsfazpqqbdlqjjtyyqlyzkdksqjnejzldqcgjqnnjsncmrfqthtejmfctyhypymhydmjncfgy"
"yxwshctxrljgjzhzcyyyjltkttntmjlzclzzayyoczlrlbszywjytsjyhbyshfjlykjxxtmzyyltxxypslqyjzyzyypnhmymdyyl"
"blhlsyygqllnjjymsoycbzgdlyxylcqyxtszegxhzglhwbljheyxtwqmakbpqcgyshhegqcmwyywljyjhyyzlljjylhzyhmgsljl"
"jxcjjyclycjbcpzjzjmmwlcjlnqljjjlxyjmlszljqlycmmgcfmmfpqqmfxlqmcffqmmmmhnznfhhjgtthxkhslnchhyqzxtmmqd"
"cydyxyqmyqylddcyaytazdcymdydlzfffmmycqcwzzmabtbyctdmndzggdftypcgqyttssffwbdttqssystwnjhjytsxxylbyyhh"
"whxgzxwznnqzjzjjqjccchykxbzszcnjtllcqxynjnckycynccqnxyewyczdcjycchyjlbtzyycqwlpgpyllgktltlgkgqbgychj"
"xy";


@implementation Utility

char indexTitleOfString(unsigned short string) {
	int index = string - HANZI_START;
	if (index >= 0 && index <= HANZI_COUNT) {
		return toupper(firstLetterArray[index]);
	}
	else if ( (string >= 'a' && string <= 'z') || (string >= 'A' && string <= 'Z') ) {
		return toupper(string);
	} else {
		return '#';
	}
}

//add for search
+ (BOOL)isCharacterChinese:(unichar)ch
{
	if (indexTitleOfString(ch) != '#' && ![Utility isCharacter:ch])
		return YES;
	return NO;
}

+ (BOOL)isCharacter:(unichar)ch {
	return (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z');
}


+ (NSString *)codeOfString:(NSString *)string {
	NSMutableString *code = [NSMutableString string];
	for(int i = 0; i < [string length]; i++) {
		NSString *str = [NSString stringWithFormat:@"%c", indexTitleOfString([string characterAtIndex:i])];
		if([str isEqual:@"#"] && ![self isNumberString:str])
			continue;
		[code appendString:str];
	}
	return code;
}

+ (BOOL)isNumberString:(NSString *)str {
	for(int i = 0; i < [str length]; i++) {
		char ch = [str characterAtIndex:i];
		if(ch < '0' || ch > '9')
			return NO;
	}
	return YES;
}

+ (void)changeNavigation:(UINavigationItem *)navItem Title:(NSString *)title {
    if (navItem && title) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 30)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.shadowColor = [UIColor grayColor];
        titleLabel.shadowOffset = CGSizeMake(0, 1);
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        navItem.titleView = titleLabel;   
    }
}

+ (void)removeShadow:(UIView *)view {
    CALayer *layer = [view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = 0; 
    layer.masksToBounds = NO;
}

+ (void)addShadowUp:(UIView *)view {
    // shadow path
    UIBezierPath *path = [UIBezierPath bezierPath]; 
    
    CGPoint topLeft = CGPointMake(view.bounds.origin.x, view.bounds.origin.y - 3); 
    CGPoint bottomLeft = CGPointMake(0.0, CGRectGetHeight(view.bounds) + 0); 
//    CGPoint bottomMiddle = CGPointMake(CGRectGetWidth(view.bounds) / 2, CGRectGetHeight(view.bounds)); 
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)); 
    CGPoint topRight = CGPointMake(CGRectGetWidth(view.bounds), view.bounds.origin.y-3); 
    
    [path moveToPoint:topLeft]; 
    [path addLineToPoint:bottomLeft]; 
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight]; 
    [path addLineToPoint:topLeft]; 
    [path closePath]; 
    
    view.layer.shadowPath = path.CGPath; 
    
    //setup shadow
    CALayer *layer = [view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;    
    layer.shadowOffset = CGSizeMake(0, 3);
    layer.shadowOpacity = 0.5; 
    //    layer.shouldRasterize = YES;
    layer.masksToBounds = NO;
}

+ (void)addShadow:(UIView *)view {
    
    // shadow path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint topLeft = view.bounds.origin; 
    CGPoint bottomLeft = CGPointMake(0.0, CGRectGetHeight(view.bounds) + 0); 
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)); 
    CGPoint topRight = CGPointMake(CGRectGetWidth(view.bounds), 0.0); 
    
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
//    [path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight]; 
    [path addLineToPoint:topLeft]; 
    [path closePath]; 
    
    view.layer.shadowPath = path.CGPath; 
    
    //setup shadow
    CALayer *layer = [view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;    
    layer.shadowOffset = CGSizeMake(0, 0.5);
    layer.shadowOpacity = 0.7; 
//    layer.shouldRasterize = YES;
    layer.masksToBounds = NO;
}

+ (void)addShadow:(UIView *)view withColor:(UIColor *)color width:(CGFloat)width
{
    // shadow path
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint topLeft = view.bounds.origin;
    CGPoint bottomLeft = CGPointMake(0.0, CGRectGetHeight(view.bounds) + 0);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    CGPoint topRight = CGPointMake(CGRectGetWidth(view.bounds), 0.0);
    
    [path moveToPoint:topLeft];
    [path addLineToPoint:bottomLeft];
    //    [path addQuadCurveToPoint:bottomRight controlPoint:bottomMiddle];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:topRight];
    [path addLineToPoint:topLeft];
    [path closePath];
    
    view.layer.shadowPath = path.CGPath;
    
    //setup shadow
    CALayer *layer = [view layer];
    layer.shadowColor = color.CGColor;
    layer.shadowOffset = CGSizeMake(0, width);
    layer.shadowOpacity = 0.7;
    //    layer.shouldRasterize = YES;
    layer.masksToBounds = NO;
}

+ (void)addShadowByLayer:(UIView *)view {
    //setup shadow
    CALayer *layer = [view layer];
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 3);
    layer.shadowOpacity = 0.5;
    layer.shouldRasterize = YES;
    layer.masksToBounds = YES;
}

+ (void)addRoundCornerToView:(UIView *)view radius:(NSInteger)radius borderColor:(UIColor *)color {
    CALayer *layer = [view layer];
    layer.cornerRadius = radius;
    layer.borderWidth = 1;
    layer.borderColor = [color CGColor];
    layer.masksToBounds = YES;
    layer.shouldRasterize = NO;
}


+ (void)addRoundCornerToView:(UIView *)view radius:(NSInteger)radius {
    
    CALayer *layer = [view layer];
    layer.cornerRadius = radius;
    layer.borderWidth = 1;
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.masksToBounds = YES;
    layer.shouldRasterize = NO;
    
}

+ (void)addRoundCornerToView:(UIView *)view {

    CALayer *layer = [view layer];
    layer.cornerRadius = 5;
    layer.borderWidth = 0;
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.masksToBounds = YES;
    layer.shouldRasterize = NO;
    
}


+ (NSString *)item:(NSString *)name descriptionWithCount:(NSInteger)count {
    if (!name) {
        return nil;
    }
    
    NSString *string = nil;
    if (count > 9999) {
        string = [NSString stringWithFormat:@"%@9999+", name];
    } else {
        string = [NSString stringWithFormat:@"%@%d", name,count];
    }
    return string;
}

+ (NSString *)date:(NSDate *)date descriptorWithFormate:(NSString *)dateFormat {
    NSString *dateString = nil;
    
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:tzGMT];
    [format setDateFormat:dateFormat];

    dateString = [format stringFromDate:date];
    
    return dateString;
}

+ (NSDate *)dateStr:(NSString *)dateStr withFormate:(NSString *)formate
{
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:tzGMT];
    [format setDateFormat:formate];
    
    NSDate *date = [format dateFromString:dateStr];
    
    return date;
}

+ (NSString *)descriptionForDateInterval:(NSString *)timeIntervalStr {
    if (timeIntervalStr == nil) {
        return nil;
    }
    
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[NSLocale currentLocale]];
    [format setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [format setTimeZone:tzGMT];
    [format setDateFormat:@"yyyy年MM月dd hh:mm:ss a"];
    NSDate *realDate = [NSDate dateWithTimeIntervalSince1970:timeIntervalStr.doubleValue];
    
    NSTimeInterval intervalFromNow = [[NSDate date] timeIntervalSince1970] - [timeIntervalStr doubleValue];
    
    NSInteger year = intervalFromNow / 3600 / 24 / 365;
    NSInteger day = intervalFromNow / 3600 / 24;
    NSInteger hour = intervalFromNow / 3600;
    NSInteger minute = ((int)intervalFromNow % 3600) / 60;
    NSInteger second = ((int)intervalFromNow % 3600) % 60;
    
    if (intervalFromNow < 0) {
        return @"刚刚";
    }
    
    if (year >= 1) {

        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setTimeZone:tzGMT];
        [format setDateFormat:@"yyyy年M月d日"];
        NSString *dateString = [format stringFromDate:realDate];
        return dateString;
    }
    
    if (day > 7) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"M月d日 HH:mm"];
        NSString *dateString = [format stringFromDate:realDate];
        return dateString;
    }
        
    if (day >= 1 && day <= 7) {
        NSString *finalDate = [NSString stringWithFormat:@"%d天前", day];

        return finalDate;
    }
    
    if (hour >= 1 && hour <= 24) {
        NSString *finalDate = [NSString stringWithFormat:@"%d小时前", hour];

        return finalDate;
    }
    
    if (minute >= 1 && minute <= 60) {
        NSString *finalDate = [NSString stringWithFormat:@"%d分钟前", minute];

        return finalDate;
    }
    
    if (second >= 30 && second <= 60) {
        NSString *finalDate = [NSString stringWithFormat:@"%d秒前", second];

        return finalDate;
    }
    
    if (second >= 0 && second < 30) {
        return @"刚刚";
    }
    
    return nil;
}

+ (NSString *)abbrdescriptionForDateInterval:(NSString *)timeIntervalStr
{
    if (timeIntervalStr == nil) {
        return nil;
    }
    
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[NSLocale currentLocale]];
    [format setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [format setTimeZone:tzGMT];
    [format setDateFormat:@"yy-M-d"];
    NSDate *realDate = [NSDate dateWithTimeIntervalSince1970:timeIntervalStr.doubleValue];
    
    NSTimeInterval intervalFromNow = [[NSDate date] timeIntervalSince1970] - [timeIntervalStr doubleValue];
    
    NSInteger year = intervalFromNow / 3600 / 24 / 365;
    //    NSInteger month = timeInterval / 3600 / 24 / 30;
    //    NSInteger week = timeInterval / 3600 / 24 / 7;
    NSInteger day = intervalFromNow / 3600 / 24;
    NSInteger hour = intervalFromNow / 3600;
    NSInteger minute = ((int)intervalFromNow % 3600) / 60;
    NSInteger second = ((int)intervalFromNow % 3600) % 60;
    
    if (intervalFromNow < 0) {
        NSString *finalDate = [format stringFromDate:realDate];
        return finalDate;
    }
    
    if (year >= 1) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setTimeZone:tzGMT];
        [format setDateFormat:@"yy-M-d"];
        NSString *dateString = [format stringFromDate:realDate];
        return dateString;
    }
    
    if (day > 7) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yy-M-d"];
        NSString *dateString = [format stringFromDate:realDate];
        return dateString;
    }
    
    if (day >= 1 && day <= 7) {
        NSString *finalDate = [NSString stringWithFormat:@"%d天前", day];
        
        return finalDate;
    }
    
    if (hour >= 1 && hour <= 24) {
        NSString *finalDate = [NSString stringWithFormat:@"%d小时前", hour];
        
        return finalDate;
    }
    
    if (minute >= 1 && minute <= 60) {
        NSString *finalDate = [NSString stringWithFormat:@"%d分钟前", minute];
        
        return finalDate;
    }
    
    if (second >= 0 && second <= 60) {
        return @"刚刚";
    }
    
    return nil;
}

+ (NSString *)timeIntervalFromDate:(NSString *)date withFormate:(NSString *)formateStr
{
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[NSLocale currentLocale]];
    [format setFormatterBehavior:NSDateFormatterBehaviorDefault];
    [format setTimeZone:tzGMT];
    [format setDateFormat:formateStr];
    
    NSDate *realDate = [format dateFromString:date];
    NSString *timeInterval = [NSString stringWithFormat:@"%lf", [realDate timeIntervalSince1970]];
    return timeInterval;
}


+ (void)addBorderColor:(UIView *)view  {
    CALayer *layer = [view layer];
    layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [layer setBorderWidth:2.0f];
}

+ (void)addBorderView:(UIView *)view withColor:(UIColor *)color width:(CGFloat)width {
	CALayer *layer = [view layer];
    layer.borderColor = [color CGColor];
    [layer setBorderWidth:width];
}

+ (void)clearBorderColor:(UIView *)view {
    CALayer *layer = [view layer];
    layer.borderColor = [[UIColor blackColor] CGColor];
    [layer setBorderWidth:0.0f];
    
}

+ (CGFloat)getFloatRandom {
    return (float)(1+arc4random()% 99)/100;
}

// 从0到(max-1)之间的随机整数
+ (NSInteger)getIntegerRandomWithInMax:(NSInteger)max {
    return (arc4random() % max);
}

+ (void)doAnimationFromLeft:(BOOL)leftDir
                   delegate:(id)_delegate 
                       view:(UIView *)transView 
                   duration:(CGFloat)duration {
    
    UIView *currentView = transView;
	UIView *theWindow = [currentView superview];
	
	[currentView removeFromSuperview];
	[theWindow addSubview:currentView];
	
	CATransition *animation = [CATransition animation];
	[animation setDelegate:self];
	[animation setDuration:0.3];
	[animation setType:kCATransitionPush];
	[animation setSubtype:(leftDir?kCATransitionFromLeft:kCATransitionFromRight)];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	[animation setValue:@"sliding" forKey:@"LeheAnimation"];
	[[theWindow layer] addAnimation:animation forKey:nil];
    
//	[self clear];
//    CATransition *transition = [CATransition animation];
//    transition.duration = duration;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    transition.delegate = _delegate;
//    transition.type = kCATransitionPush;
//    transition.subtype = (leftDir ? kCATransitionFromLeft : kCATransitionFromRight);
//    [transView.layer addAnimation:transition forKey:nil];    
}

+ (UIAlertView *)startWebViewMaskWithMessage:(NSString *)_message  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:_message
                                                    delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alert addSubview:progress];
    [progress startAnimating];
    [alert show];
    return alert;
}

+ (void)disMissMaskView:(UIAlertView **)_alertView {
    if (*_alertView != nil) {
        [*_alertView dismissWithClickedButtonIndex:0 animated:YES];
        *_alertView = nil;
    }
    
}

+ (NSMutableString *)URLStringMakeWithDict:(NSDictionary *)dict {
    NSMutableString *urlString = [NSMutableString string];
    [urlString appendFormat:@"http://www.lehe.com/lehe/api_call.php?"];
    int i = 0;
    for (NSString *key in dict) {
        if (i == 0) {
            [urlString appendFormat:@"%@=%@", key, dict[key]];
        } else {
            [urlString appendFormat:@"&%@=%@",key, dict[key]];
        }
        i++;
    }
    return urlString;
}


+ (void)setWebView:(UIWebView *)webView withId:(NSInteger)webId {
    NSString *jsString = [NSString stringWithFormat:@"javascript:eval(setContext(%d))",webId];
    [webView stringByEvaluatingJavaScriptFromString:jsString];  
}


+ (BOOL)isValidLatLon:(double)lat Lon:(double)lon {

	if (lat>-90.0f && lat<90.0f && lon>-180.0f && lon<180.0f && lat!=0.0f && lon!=0.0f) {
		return YES;
	}
	
	return NO;
}

+ (NSString*)getPhotoDownloadURL:(NSString*)currentURLString sizeType:(NSString*)sizetype {
    
	NSRange range;
	int location = 0;
	currentURLString = [currentURLString stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
	NSMutableString* resultURL = [[NSMutableString alloc] initWithString:currentURLString];
	
	if ([sizetype caseInsensitiveCompare:@"large"] == NSOrderedSame) {			// To: large
		
		// small -> large 
		range = [resultURL rangeOfString:@"/small/"];
		location = range.location;
		if (location != NSNotFound)
			[resultURL replaceCharactersInRange:range withString:@"/large/"];
		
		// normal -> large
		range = [resultURL rangeOfString:@"/normal/"];
		location = range.location;
		if (location != NSNotFound)
			[resultURL replaceCharactersInRange:range withString:@"/large/"];
		
	} else if ([sizetype caseInsensitiveCompare:@"normal"] == NSOrderedSame) {	// To: normal
		
		// small -> normal 
		range = [resultURL rangeOfString:@"/small/"];
		location = range.location;
		if (location != NSNotFound)
			[resultURL replaceCharactersInRange:range withString:@"/normal/"];
		
		// large -> normal
		range = [resultURL rangeOfString:@"/large/"];
		location = range.location;
		if (location != NSNotFound)
			[resultURL replaceCharactersInRange:range withString:@"/normal/"];
		
		
	} else if ([sizetype caseInsensitiveCompare:@"small"] == NSOrderedSame) {	// To: samll
		
		// normal -> small 
		range = [resultURL rangeOfString:@"/normal/"];
		location = range.location;
		if (location != NSNotFound)
			[resultURL replaceCharactersInRange:range withString:@"/small/"];
		
		// large -> small
		range = [resultURL rangeOfString:@"/large/"];
		location = range.location;
		if (location != NSNotFound)
			[resultURL replaceCharactersInRange:range withString:@"/small/"];

	}
	
	return resultURL;
}

+ (NSMutableDictionary *)datasourceFromListArray:(NSArray *)array {
    NSMutableDictionary *finalDict = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dict in array) {
        NSString *name = dict[@"name"];
        if (name && [name length] > 0) {
            if ([Utility isCharacter:[name characterAtIndex:0]] || [Utility isCharacterChinese:[name characterAtIndex:0]]) {
                NSString *codeOfString = [Utility codeOfString:name];
                NSString *firstLetter = [NSString stringWithFormat:@"%C", [codeOfString characterAtIndex:0]];
                
                NSMutableArray *array = finalDict[firstLetter];
                if (array == nil) {
                    array = [NSMutableArray array];
                    [finalDict setObject:array forKey:firstLetter];
                }
                [array addObject:dict];
            } else {
                NSMutableArray *arrayForUnkown = finalDict[@"#"];
                if (arrayForUnkown == nil) {
                    arrayForUnkown = [NSMutableArray array];
                    [finalDict setObject:arrayForUnkown forKey:@"#"];
                }
                [arrayForUnkown addObject:dict];
            }
        }
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"name" 
                                                               ascending:YES 
                                                                selector:@selector(localizedCompare:)];
    for (NSString *key in [finalDict allKeys]) {
        NSMutableArray *array = finalDict[key];
        [array sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    }       
    
    return finalDict;
}

+ (void)popModalsToRootFrom:(UIViewController*)aVc {
    if(aVc.parentViewController == nil) {
        return;
    }
    else {
        [Utility popModalsToRootFrom:aVc.parentViewController];  // recursive call to this method
        [aVc.parentViewController dismissModalViewControllerAnimated:NO];
    }
}
 
+ (NSString *)descriptionForDistance:(NSInteger)distance {
	if (distance == 0) {
		return @"身边";
	}
	
    if (distance > 0 && distance < 1000) {
        return [NSString stringWithFormat:@"%d米", distance];
    }
    if (distance >= 1000 && distance < 1000*100) {
        CGFloat newDistance = distance/1000.0;
        return [NSString stringWithFormat:@"%0.1f公里", newDistance];
    }
    if (distance >= 100*1000 && distance < 1000*1000) {
//        NSInteger distance = (NSInteger)(distance/1000.0);
        return [NSString stringWithFormat:@"1百公里外"];
    }
    if (distance >= 1000*1000) {
        return [NSString stringWithFormat:@"1千公里外"];
    }
    return nil;
}

+ (NSDictionary *)intervalForDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setTimeZone:tzGMT];
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | 
    NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags 
                                           fromDate:fromDate  
                                             toDate:toDate options:0];

    NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
    [dateDict setObject:[NSNumber numberWithInt:[comps hour]] forKey:@"hour"];
    [dateDict setObject:[NSNumber numberWithInt:[comps day]] forKey:@"day"];    
    [dateDict setObject:[NSNumber numberWithInt:[comps month]] forKey:@"month"];
    [dateDict setObject:[NSNumber numberWithInt:[comps minute]] forKey:@"minute"];
    [dateDict setObject:[NSNumber numberWithInt:[comps second]] forKey:@"second"];
    [dateDict setObject:[NSNumber numberWithInt:[comps year]] forKey:@"year"];
    
    return dateDict;
}

+ (NSDictionary *)parseByDate:(NSDate *)date {
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | 
    NSDayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:tzGMT];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionary];
    [dateDict setObject:[NSNumber numberWithInt:[comps hour]] forKey:@"hour"];
    [dateDict setObject:[NSNumber numberWithInt:[comps day]] forKey:@"day"];    
    [dateDict setObject:[NSNumber numberWithInt:[comps month]] forKey:@"month"];
    [dateDict setObject:[NSNumber numberWithInt:[comps minute]] forKey:@"minute"];
    [dateDict setObject:[NSNumber numberWithInt:[comps second]] forKey:@"second"];
    [dateDict setObject:[NSNumber numberWithInt:[comps year]] forKey:@"year"];
    [dateDict setObject:[NSNumber numberWithInt:[comps weekday]] forKey:@"weekday"];
    return dateDict;
}

+ (void)plainTableView:(UITableView *)_tableView changeBgForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundView = [[UIImageView alloc] init];
    cell.selectedBackgroundView = [[UIImageView alloc] init];
    
    UIImage *rowBackground;
    UIImage *selectionBackground;
    rowBackground = [UIImage stretchableImage:@"bg_cell.png" leftCap:2 topCap:6];
    selectionBackground = [UIImage stretchableImage:@"bg_cell_p.png" leftCap:2 topCap:6];
	((UIImageView *)cell.backgroundView).image = rowBackground;
    ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
}

+ (void)groupTableView:(UITableView *)_tableView changeBgForCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundView = [[UIImageView alloc] init];
    cell.selectedBackgroundView = [[UIImageView alloc] init];
    
    UIImage *rowBackground;
    UIImage *selectionBackground;
	NSInteger sectionRows = [_tableView numberOfRowsInSection:[indexPath section]];
	NSInteger row = [indexPath row];
	if (row == 0 && row == sectionRows - 1)
	{
        rowBackground = [UIImage stretchableImage:@"bg_cell_single.png" leftCap:20 topCap:15];
        selectionBackground = [UIImage stretchableImage:@"bg_cell_single_p.png" leftCap:20 topCap:15];
	}
	else if (row == 0)
	{
		rowBackground = [UIImage stretchableImage:@"bg_cell_top.png" leftCap:0 topCap:10];
        selectionBackground = [UIImage stretchableImage:@"bg_cell_top_p.png" leftCap:0 topCap:10];
	}
	else if (row == sectionRows - 1)
	{
		rowBackground = [UIImage stretchableImage:@"bg_cell_buttom.png" leftCap:0 topCap:11];
        selectionBackground = [UIImage stretchableImage:@"bg_cell_buttom_p.png" leftCap:0 topCap:11];
	}
	else
	{
		rowBackground = [UIImage stretchableImage:@"bg_cell_middle.png" leftCap:0 topCap:5];
        selectionBackground = [UIImage stretchableImage:@"bg_cell_middle_p.png" leftCap:0 topCap:5];
	}
	((UIImageView *)cell.backgroundView).image = rowBackground;
    ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
}

#pragma mark - save & read image

+ (void)saveImage:(UIImage *)image toDiskWithName:(NSString *)name
{
    if (!image) {
        return;
    }
    
    NSString *aPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), name];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    [imgData writeToFile:aPath atomically:YES];
}

+ (UIImage *)readImageFromDisk:(NSString *)path
{
    NSString *truePath = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),path];
    UIImage *image = [UIImage imageWithContentsOfFile:truePath];
    return image;
}

+ (void)saveImage:(UIImage *)image toDiskWithName:(NSString *)imageName atDirectory:(NSString *)dir
{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dirPath = [documentDir stringByAppendingPathComponent:dir];
    
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    
    NSString *filePath = [dirPath stringByAppendingPathComponent:imageName];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    [imgData writeToFile:filePath atomically:YES];
}

+ (UIImage *)readImageFromDisk:(NSString *)imageName atDirectory:(NSString *)dir
{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dirPath = [documentDir stringByAppendingPathComponent:dir];
    
    NSString *filePath = [dirPath stringByAppendingPathComponent:imageName];
    if ([imageName isValid] && [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        return image;
    }
    
    return nil;
}

#pragma mark - utility

+ (void)drawLineFromPoint:(CGPoint )startPoint toPoint:(CGPoint)endPoint inContext:(CGContextRef)context withColor:(UIColor *)color
{
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

+ (void)verticalizeButton:(UIButton *)button withSpace:(CGFloat)space
{
    // the space between the image and text
    if (space == 0.f) {
        space = 6.0;
    }

    // get the size of the elements here for readability
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    
    // lower the text and push it left to center it
    button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + space), 0.0);
    
    // the text width might have changed (in case it was shortened before due to
    // lack of space and isn't anymore now), so we get the frame size again
    
    // raise the image and push it right to center it
    button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + space), 0.0, 0.0, - titleSize.width);
}

#pragma mark - 

+ (BOOL)deviceCanCall
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPod touch"] ||
       [deviceType  isEqualToString:@"iPad"] ||
       [deviceType  isEqualToString:@"iPhone Simulator"]) {
        return NO;
    }
    return YES;
}

@end
