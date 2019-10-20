#!//usr/bin/ruby
# coding: utf-8


require "cgi"
require "pstore"

c = CGI.new(:accept_charset => "UTF-8")

mode = c["mode"]
name = c["name"]
cmt  = c["comment"]
time  = Time.now

print " <!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
 \"http://www.w3.org/TR/html4/strict.dtd\">
<html lang=\"ja\">
  <head>
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">
    <meta http-equiv=\"Content-Style-Type\" content=\"text/css\">
    <meta name=\"author\" content=\"HOMMA Kanan\">
    <meta name=\"description\" content=\"\">
    <meta name=\"keywords\" content=\"Menu, card, entertainment,\">
    <title>Card Duel</title>
    <style type=\"text/css\">
      <!--
      body {background-color: #90ee90;}
      h1 {color: #0000ff;
	  background-color: #ffffff;
	  border: 2px solid #ffff00
		      margin: 50px 30px 0px 30px;
          padding: 0px 0px 0px 10px;
	  border-style: inset ;border-width: 4px; border-color :#90ee90;}
      p {margin: 30px 50px 0px 50px;
	 color: #000000;
	 letter-spacing: 0.1em;
	 line-height: 1.5;
	 font-size: large;}
      pre {font-size: large;
	   margin: 20px 70px 0px 70px;
	   letter-spacing: 0.1em;
	   color: #ffffff;
	   background-color: #006666;
	   line-height: 1.2;}
      
      a:link {color: #000000;}
      a:visited {color: #000066;}
      a:hover {color: #000066;
	       background: #ffffcc}
      a:active {color: #000066;
		background: #ffffcc;
		border: 3px solid #ff0000}
      .center {text-align: center;}
      
      
      <!-- ラジオボタンを非表示にしたいけどできん -->
      .taba input { display: none; }
      
      
      .taba {display: inline-block;
	     border-width: 1px 1px 0px 1px;
	     border-style: solid;
	     border-color: black;
	     border-radius: 0.75em 0.75em 0px 0px;
	     padding: 0.75em 1em;
	     color: black;
	     background-color: #fafcf4;
	     font-weight: bold;}
      
      
      .taba:hover {background-color: #fbffd6;
                   <!-- background-color: brack; -->
		   color: green;
		   cursor: pointer;}
      
      
      input:checked + .taba {background-color: #fbffd6;
			     position: relative;
			     z-index: 10;}
      
      .tabcontent {display: none;
		   border: 1px solid black;
		   margin-top: -1px;
		   padding: 1em;
		   position: relative;
		   z-index: 0;
		   background-color: #fbffd6;}
      
      
      
      #tabcheck1:checked ~ #tabcontent1 { display: block; }
      #tabcheck2:checked ~ #tabcontent2 { display: block; }
      #tabcheck3:checked ~ #tabcontent3 { display: block; }
      
      
      -->
    </style>
  </head>\n"

bbs = PStore.new("data.db")
bbs.transaction do
  if bbs["root"] == nil
    bbs["root"] = Hash.new
  end
  data = bbs["root"]  # csvに変更したほうがいい。
  
  if name >"" #&& cmt > "" #&& filename > "" && #gpsza >""
    # 名前、値があるなら登録
    data[name] = [time]
  end
  

 print" <body>
<form method=\"POST\" action=\"./menu2.rb\">\n"
 
print "<div class=\"tab\">
      <input type=\"radio\" name=\"tabset\" id=\"tabcheck1\" checked>
      <label for=\"tabcheck1\"class=\"taba\">ナブラ演算子ゲーム</label>
      <input type=\"radio\" name=\"tabset\" id=\"tabcheck2\"        >
      <label for=\"tabcheck2\"class=\"taba\">ポケモンカード</label>
      <input type=\"radio\" name=\"tabset\" id=\"tabcheck3\"        >
      <label for=\"tabcheck3\" class=\"taba\">遊戯王</label>\n"
      
print '<div class=\"tabcontent\" id=\"tabcontent1\"><br><h2>Enter your ID</h2><ul>
      <p>   
      NAME: <input name="name" type="text" maxlength="40"><br>
      </textarea><br>
      <input type="submit" value="送信">
      <input type="reset" value="reset"><br>
      </p><hr>'
    print "<dl>\n"  # 定義環境開始
    for i in data.keys.sort{|x, y|
          data[y][0] <=> data[x][0]  # 日付の新しい順にソート
        }
      day = data[i][0]  # 第0要素=日付
      printf(" <dt> %s\n", i)  # キー(つまり飲んだものの名前)
      printf(" <dd> 記載日: %s<br>\n", day.strftime("%Y/%m/%d/ %X"))
    end
    print "</dl>\n"  # 定義環境終了
    print '</div>
                
      <div class=\"tabcontent\" id=\"tabcontent2\">
	   <br><h2>Enter Your ID</h2><ul>
      <p>        
      NAME: <input name="name" type="text" maxlength="40"><br>
      </textarea><br>
      <input type="submit" value="送信">
      <input type="reset" value="reset"><br>
      </p><hr>'
    print "<dl>\n"  # 定義環境開始
    for i in data.keys.sort{|x, y|
          data[y][0] <=> data[x][0]  # 日付の新しい順にソート
        }
      day = data[i][0]  # 第0要素=日付
      printf(" <dt> %s\n", i)  # キー(つまり飲んだものの名前)
      printf(" <dd> 記載日: %s<br>\n", day.strftime("%Y/%m/%d/ %X"))
    end
    print "</dl>    
    </br>\n"
    
    print '</div>
          
      <div class=\"tabcontent\" id=\"tabcontent3\">
	   <br><h2>Enter Your ID</h2><ul>
      <p>        
      NAME: <input name="name" type="text" maxlength="40"><br>
      </textarea><br>
      <input type="submit" value="送信">
      <input type="reset" value="reset"><br>
      </p><hr>'
    print "<dl>\n"  # 定義環境開始
    for i in data.keys.sort{|x, y|
          data[y][0] <=> data[x][0]  # 日付の新しい順にソート
        }
      day = data[i][0]  # 第0要素=日付
      printf(" <dt> %s\n", i)  # キー(つまり飲んだものの名前)
      printf(" <dd> 記載日: %s<br>\n", day.strftime("%Y/%m/%d/ %X"))
    end
    
    # <!-- <p>New map name : <input name=\"name\" type=\"text\" maxlength=\"40\"><br> -->
    #                                                                                   <!--   <button type=\"button\" name=\"make\" id=\"make\">作成</button> -->
    #                                                                                  <!--   <hr> -->
    print "</br>
           </div>\n"
end   

print "</div>\n</body>\n</html>"
