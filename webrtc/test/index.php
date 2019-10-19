<!DOCTYPE html>
<html>

<head lang="ja">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SkyWay JS SDK Tutorial</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="pure-g">

    <!-- Video area -->
    <div class="pure-u-2-3" id="video-container">
        <video id="their-video" autoplay playsinline></video>
        <video id="my-video" muted="true" autoplay playsinline></video>
    </div>

    <!-- Steps -->
    <div class="pure-u-1-3">
        <h1>jphack_NG1913</h1>
        <h2>SkyWay Video Chat</h2>

        <p>Your id: <span id="my-id">...</span></p>
        <p>Share this id with others so they can call you.</p>
        <h3>Make a call</h3>
        <form id="make-call" class="pure-form">
            <input type="text" placeholder="Call user id..." id="callto-id">
            <button href="hoge.html" class="pure-button pure-button-success" type="submit">Call</button>
        </form>
        <form id="end-call" class="pure-form">
            <p>Currently in call with <span id="their-id">...</span></p>
            <button href="#" class="pure-button pure-button-success" type="submit">End Call</button>
        </form>
    </div>
</div>


<br>
    <!-- 送信からPOSTされたデータの受け取りと受け取った時間の取得 -->
    <?php

        //input.phpからのデータ受け取り/
        $komento = $_POST["komento"];
        date_default_timezone_set('Asia/Tokyo');
        $timestamp = time();

        //ファイル書き込み　記事内容//
        $article_array = array($komento,$timestamp);
        $article_file = fopen("article.csv","a");
        fputcsv($article_file,$article_array);
        fclose($article_file);

    ?>

    <!-- コメント表示 -->
    <div id="scroll" style="height: 200px; width:1000px; overflow: auto; padding: 16px; border: 1px solid #ccc; background: #fffff7; border-radius: 6px;">
        <?php

            date_default_timezone_set('Asia/Tokyo');

            $article_file = fopen("article.csv","r");

                while($line = fgetcsv($article_file)){
                    $GG[] = $line;
                }

                $GG = array_reverse($GG);

                foreach($GG as $GGs){
                    // print date("Y/m/d/H:i",$GGs[1]);
                    print date("H:i",$GGs[1]);
                    print("&nbsp;&nbsp;");
                    print $GGs[0];
                    print("<br>");
                }

            fclose($article_file);

        ?>
    </div>

    <!-- コメント書き込み・送信 -->
    <form method="POST" action="index.php">
        <input type="text" name="komento" size="40" methodlength="50">
        <input type="submit" value="送信">
    </form>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://cdn.webrtc.ecl.ntt.com/skyway-latest.js"></script>
<script type="text/javascript" src="script.js"></script>


</body>
</html>